import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:infoprofile_demo/models/searchedusers_model.dart';
import 'package:infoprofile_demo/providers/home/search_provider.dart';
import 'package:infoprofile_demo/providers/home/user_provider.dart';
import 'package:infoprofile_demo/resources/colors.dart';
import 'package:infoprofile_demo/resources/fonts.dart';
import 'package:infoprofile_demo/resources/strings.dart';
import 'package:infoprofile_demo/viewmodels/home/search_viewmodel.dart';
import 'package:provider/provider.dart';

import '../../utils/glassmorph_container.dart';

class SearchRoute extends StatefulWidget {
  const SearchRoute({super.key});

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
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    final searchProvider = Provider.of<SearchProvider>(context, listen: false);
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
                    accessToken: userProvider.userData.accesstoken!,
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
                        SearchedUsersModel searchedUsersData =
                            SearchedUsersModel.fromJson(snapshot.data);
                        List<dynamic> usersList = searchedUsersData.data;
                        return ListView.builder(
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          itemCount: usersList.length,
                          itemBuilder: (context, index) {
                            return Padding(
                              padding: const EdgeInsets.only(bottom: 15),
                              child: InkWell(
                                borderRadius: BorderRadius.circular(10),
                                onTap: () {
                                  // open profile
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
                                        const CircleAvatar(
                                          backgroundColor: Colors.amber,
                                          backgroundImage:
                                              CachedNetworkImageProvider(
                                                  "https://picsum.photos/200/200"),
                                        ),
                                        const SizedBox(
                                          width: 10,
                                        ),
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            if (usersList[index]['fullName'] !=
                                                null)
                                              Text(
                                                usersList[index]['fullName'],
                                                style: AppFonts.headerStyle(
                                                    fontWeight: FontWeight.w600,
                                                    context: context),
                                              ),
                                            Text(
                                              usersList[index]['username'],
                                              style: AppFonts.headerStyle(
                                                fontWeight: (usersList[index]
                                                            ['fullName'] !=
                                                        null)
                                                    ? FontWeight.w400
                                                    : FontWeight.w600,
                                                context: context,
                                              ),
                                            ),
                                          ],
                                        ),
                                        const Spacer(),
                                        IconButton(
                                            visualDensity:
                                                VisualDensity.compact,
                                            onPressed: () {
                                              // follow
                                              // change icon
                                            },
                                            icon: const Icon(Icons.person_add))
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
