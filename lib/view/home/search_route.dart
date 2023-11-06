import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:infoprofile_demo/models/prefrences_settings_model.dart';
import 'package:infoprofile_demo/models/searchedusers_model.dart';
import 'package:infoprofile_demo/providers/home/search_provider.dart';
import 'package:infoprofile_demo/resources/colors.dart';
import 'package:infoprofile_demo/resources/fonts.dart';
import 'package:infoprofile_demo/resources/routes.dart';
import 'package:infoprofile_demo/resources/strings.dart';
import 'package:infoprofile_demo/viewmodels/home/search_viewmodel.dart';
import 'package:provider/provider.dart';

import '../../utils/glassmorph_container.dart';

class SearchRoute extends StatefulWidget {
  final PrefrencesSettings prefrencesSettings;
  const SearchRoute({super.key, required this.prefrencesSettings});

  @override
  State<SearchRoute> createState() => _SearchRouteState();
}

class _SearchRouteState extends State<SearchRoute> {
  final _searchController = TextEditingController();
  final _searchFocusNode = FocusNode();
  SearchProvider? searchProvider;

  @override
  void initState() {
    _searchFocusNode.requestFocus();
    searchProvider = Provider.of<SearchProvider>(context, listen: false);
    _initData(searchProvider: searchProvider!);
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    _searchController.dispose();
    _searchFocusNode.dispose();
  }

  _initData({required SearchProvider searchProvider}) {
    Future.delayed(
      Duration.zero,
      () => searchProvider.setSeachInputStatus(status: true),
    );
  }

  @override
  Widget build(BuildContext context) {
    final searchProvider = Provider.of<SearchProvider>(context, listen: false);
    final PrefrencesSettings userData = widget.prefrencesSettings;
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: true,
        title: TextField(
          controller: _searchController,
          focusNode: _searchFocusNode,
          onSubmitted: (value) {
            if (value.isNotEmpty) {
              searchProvider.setSeachInputStatus(status: false);
            }
          },
          textInputAction: TextInputAction.search,
          onChanged: (value) {
            if (value.isEmpty) {
              searchProvider.setSeachInputStatus(status: true);
            }
          },
          decoration: const InputDecoration(
            border: InputBorder.none,
            hintText: "Search",
          ),
        ),
      ),
      body: Consumer<SearchProvider>(builder: (context, value, child) {
        return SafeArea(
            child: Center(
          child: (value.isSearchInputEmpty)
              ? Text(
                  AppStrings.onEmptySearchInputField,
                  style: AppFonts.headerStyle(
                      context: context,
                      color: AppColors.grey,
                      fontWeight: FontWeight.w600),
                )
              : FutureBuilder(
                  future: SearchViewModel().onSubmitSearch(
                    accessToken: widget.prefrencesSettings.accesstoken!,
                    inputName: _searchController.text.trim(),
                    context: context,
                  ),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.done) {
                      if (snapshot.hasError) {
                        debugPrint(snapshot.data.toString());
                        return Text(
                          AppStrings.noUsersFound,
                          style: AppFonts.headerStyle(
                            context: context,
                            fontWeight: FontWeight.w600,
                            color: AppColors.grey,
                          ),
                        );
                      } else if (snapshot.hasData) {
                        SearchUserModel searchedUsersData =
                            SearchUserModel.fromJson(snapshot.data);
                        List<Datum> usersList = searchedUsersData.data;
                        return ListView.builder(
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          itemCount: usersList.length,
                          itemBuilder: (context, index) {
                            Datum currentUser = usersList[index];
                            return Padding(
                              padding: const EdgeInsets.only(bottom: 15),
                              child: InkWell(
                                borderRadius: BorderRadius.circular(10),
                                onTap: () {
                                  // open profile
                                  Navigator.pushNamed(
                                      context, Routes.userProfileView,
                                      arguments: {
                                        'param1': userData.accesstoken,
                                        'param2': currentUser.id,
                                        'param3':userData,
                                      });
                                },
                                child: GlassmorphContainer(
                                    borderRadius: 10,
                                    hzMargin: 0,
                                    color: (Theme.of(context).brightness ==
                                            Brightness.dark)
                                        ? AppColors.darkPruple
                                        : AppColors.grey,
                                    child: Row(
                                      children: [
                                        CircleAvatar(
                                          backgroundImage:
                                              (currentUser.profilePic.length >
                                                      2)
                                                  ? CachedNetworkImageProvider(
                                                      currentUser.profilePic)
                                                  : null,
                                        ),
                                        const SizedBox(
                                          width: 20,
                                        ),
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            if (currentUser.fullName.length > 2)
                                              Text(
                                                currentUser.fullName,
                                                style: AppFonts.headerStyle(
                                                    fontWeight: FontWeight.w600,
                                                    context: context),
                                              ),
                                            Text(
                                              currentUser.username,
                                              style: AppFonts.headerStyle(
                                                fontWeight: (currentUser
                                                            .fullName.length >
                                                        2)
                                                    ? FontWeight.w400
                                                    : FontWeight.w600,
                                                context: context,
                                              ),
                                            ),
                                          ],
                                        ),
                                        const Spacer(),
                                        FaIcon(
                                          FontAwesomeIcons.caretRight,
                                          color: Theme.of(context).brightness ==
                                                  Brightness.dark
                                              ? AppColors.white
                                              : AppColors.black,
                                        ),
                                        const SizedBox(
                                          width: 10,
                                        ),
                                      ],
                                    )),
                              ),
                            );
                          },
                        );
                      } else {
                        return Text(
                          AppStrings.userSearchError,
                          style: AppFonts.headerStyle(
                            context: context,
                            fontWeight: FontWeight.w600,
                            color: AppColors.grey,
                          ),
                        );
                      }
                    } else {
                      return CircularProgressIndicator(
                        color: (Theme.of(context).brightness == Brightness.dark)
                            ? AppColors.white
                            : AppColors.grey,
                      );
                    }
                  },
                ),
        ));
      }),
    );
  }
}
