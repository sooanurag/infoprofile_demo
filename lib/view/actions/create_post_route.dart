import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:infoprofile_demo/providers/actions/createpost_provider.dart';
import 'package:infoprofile_demo/resources/colors.dart';
import 'package:infoprofile_demo/resources/fonts.dart';
import 'package:infoprofile_demo/resources/strings.dart';
import 'package:infoprofile_demo/utils/utils.dart';
import 'package:provider/provider.dart';

class CreatePostRoute extends StatefulWidget {
  const CreatePostRoute({super.key});

  @override
  State<CreatePostRoute> createState() => _CreatePostRouteState();
}

class _CreatePostRouteState extends State<CreatePostRoute> {
  final _captionController = TextEditingController();
  final _captionFocusNode = FocusNode();
  late CreatePostProvider createPostProvider;

  @override
  void initState() {
    createPostProvider =
        Provider.of<CreatePostProvider>(context, listen: false);
    _initData(createPostProvider: createPostProvider);
    // _captionFocusNode.requestFocus();
    super.initState();
  }

  _initData({required CreatePostProvider createPostProvider}) async {
    Future.delayed(
      Duration.zero,
      () => createPostProvider.setImageFile(image: null),
    );
  }

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        actions: [
          Consumer<CreatePostProvider>(
            builder: (context, value, child) {
              return Padding(
                padding: const EdgeInsets.only(right: 12),
                child: Utils.textButton(
                  enableFeedback: value.isPostReady,
                  elevation: 0,
                  visualDensity: VisualDensity.compact,
                  onPressed: () {
                    if (value.isPostReady) {
                      // posy api
                      // post api
                      value.setIsPostReady(status: false);
                    }
                  },
                  buttonText: "Post",
                  hzPadding: 10,
                  textColor: Theme.of(context).brightness == Brightness.dark
                      ? (value.isPostReady)
                          ? AppColors.white
                          : AppColors.grey
                      : (value.isPostReady)
                          ? AppColors.black
                          : AppColors.grey,
                  backgroundColor: (value.isPostReady)
                      ? AppColors.submitButton
                      : AppColors.grey.withOpacity(0.4),
                ),
              );
            },
          )
        ],
        leading: IconButton(
            visualDensity: VisualDensity.compact,
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(Icons.close)),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12),
        child: Consumer<CreatePostProvider>(builder: (context, value, child) {
          return SingleChildScrollView(
            child: SizedBox(
              height: screenSize.height,
              child: Column(
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const CircleAvatar(), // user profile pic
                      const SizedBox(
                        width: 10,
                      ),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Utils.textButton(
                                onPressed: () {
                                  Utils.showToastMessage(
                                      AppStrings.notAvailabe);
                                },
                                buttonText: "Public",
                                visualDensity: VisualDensity.compact,
                                hzPadding: 10),
                            TextField(
                              controller: _captionController,
                              focusNode: _captionFocusNode,
                              onChanged: (inputValue) {
                                if(value.imageFile==null){
                                if (inputValue.isNotEmpty) {
                                  value.setIsPostReady(status: true);
                                } else if (inputValue.isEmpty) {
                                  value.setIsPostReady(status: false);
                                }}
                              },
                              decoration: const InputDecoration(
                                hintText: "Caption...",
                              ),
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            if (value.imageFile != null)
                              ClipRRect(
                                borderRadius: BorderRadius.circular(20),
                                child: Stack(
                                  children: [
                                    Image.file(value.imageFile!),
                                    Positioned.fill(
                                      child: Align(
                                        alignment: Alignment.topRight,
                                        child: Padding(
                                          padding: const EdgeInsets.all(12.0),
                                          child: GestureDetector(
                                            onTap: () {
                                              value.setImageFile(image: null);
                                            },
                                            child: const Icon(
                                              Icons.close,
                                              shadows: [
                                                Shadow(
                                                  blurRadius: 5,
                                                  offset: Offset(2, 2),
                                                )
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                          ],
                        ),
                      )
                    ],
                  ),
                  if (value.imageFile == null) const Spacer(),
                  if (value.imageFile == null)
                    InkWell(
                      borderRadius: BorderRadius.circular(8),
                      onTap: () {
                        // open image pickert
                        showModalBottomSheet(
                          context: context,
                          builder: (context) {
                            return Padding(
                              padding: const EdgeInsets.all(12.0),
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Divider(
                                    thickness: 5,
                                    indent: screenSize.width * 0.4,
                                    endIndent: screenSize.width * 0.4,
                                  ),
                                  ListTile(
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(22)),
                                    leading:
                                        const FaIcon(FontAwesomeIcons.camera),
                                    title: const Text("Camera"),
                                    onTap: () async {
                                      Navigator.pop(context);
                                      value.setImageFile(
                                          image: await Utils.selectImage(
                                              source: ImageSource.camera));
                                    },
                                  ),
                                  ListTile(
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(22)),
                                    leading:
                                        const FaIcon(FontAwesomeIcons.images),
                                    title: const Text("Gallery"),
                                    onTap: () async {
                                      Navigator.pop(context);
                                      value.setImageFile(
                                          image: await Utils.selectImage(
                                        source: ImageSource.gallery,
                                      ));
                                    },
                                  )
                                ],
                              ),
                            );
                          },
                        );
                      },
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const FaIcon(FontAwesomeIcons.arrowUpFromBracket),
                          const SizedBox(
                            height: 10,
                          ),
                          Text(
                            "Upload",
                            style: AppFonts.headerStyle(
                                context: context, fontWeight: FontWeight.w600),
                          ),
                        ],
                      ),
                    ),
                  if (value.imageFile == null) const Spacer(),
                ],
              ),
            ),
          );
        }),
      ),
    );
  }
}
