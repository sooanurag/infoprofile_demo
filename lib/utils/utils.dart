import 'dart:io';

import 'package:flutter/material.dart';

import 'package:fluttertoast/fluttertoast.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:infoprofile_demo/resources/strings.dart';


import 'package:infoprofile_demo/utils/glassmorph_container.dart';
import 'package:image_picker/image_picker.dart';
import 'package:image_cropper/image_cropper.dart';

import '../resources/fonts.dart';

class Utils {
  //textButton
  static textButton({
    required VoidCallback onPressed,
    required String buttonText,
    double? elevation = 8,
    double? fontSize = 16,
    double? hzPadding = 20,
    Color? textColor = Colors.black,
    Color? backgroundColor = Colors.white,
    VisualDensity? visualDensity,
    bool? enableFeedback,
  }) {
    return TextButton(
      onPressed: onPressed,
      style: ButtonStyle(
          enableFeedback: enableFeedback,
          visualDensity: visualDensity,
          backgroundColor: MaterialStateProperty.all(backgroundColor),
          elevation: MaterialStateProperty.all(elevation),
          shadowColor: MaterialStateProperty.all(Colors.black)),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: hzPadding!),
        child: Text(
          buttonText,
          style: TextStyle(
            color: textColor,
            fontSize: fontSize,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }
  //----------------------------

  static Widget infoprofileTypo({
    double? fontSize,
    FontWeight? fontWeight,
    required BuildContext context,
  }) =>
      Text(
        "infoprofile",
        style: AppFonts.headerStyle(
            fontSize: fontSize, fontWeight: fontWeight, context: context),
      );
  //----------------------------

// customTextFormField
  static TextFormField customTextFormField({
    required TextEditingController inputController,
    required String? invalidText,
    String? label,
    String? hint,
    Widget? prefixIcon,
    FocusNode? currentFocusNode,
    BuildContext? context,
    FocusNode? nextNode,
    bool obscure = false,
    Widget? suffixIcon,
    void Function(String)? onChanged,
    bool? isEnabled = true,
    bool? isFilled,
    Color? fillColor,
    Color? prefixIconColor,
    Color? suffixIconColor,
    Color? cursorColor = Colors.white,
    double? borderRadius = 12,
    EdgeInsetsGeometry? contentPadding,
    int? maxLength,
    TextAlign? textAlign = TextAlign.start,
    double? inputFontSize,
    TextInputType? keyboardType,
    TextInputAction? textInputAction,
  }) {
    return TextFormField(
      keyboardType: keyboardType,
      textInputAction: textInputAction,
      textAlign: textAlign!,
      style: TextStyle(fontSize: inputFontSize, color: Colors.black),
      maxLength: maxLength,
      cursorColor: cursorColor,
      enabled: isEnabled,
      onChanged: onChanged,
      controller: inputController,
      obscureText: obscure,
      focusNode: currentFocusNode,
      onFieldSubmitted: (context != null)
          ? (value) => changeFieldFocus(
              context: context,
              currentNode: currentFocusNode!,
              nextNode: nextNode!)
          : null,
      validator: (invalidText != "")
          ? (value) {
              if (value!.isEmpty) {
                return invalidText;
              } else {
                return null;
              }
            }
          : null,
      decoration: InputDecoration(
        hintStyle: const TextStyle(color: Colors.black),
        counterText: "",
        contentPadding: contentPadding,
        filled: isFilled,
        fillColor: (isEnabled!) ? fillColor : Colors.white54,
        prefixIconColor: prefixIconColor,
        suffixIconColor: suffixIconColor,
        label: (label != null) ? Text(label) : null,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(borderRadius!)),
        ),
        hintText: hint,
        prefixIcon: (prefixIcon == null)
            ? null
            : Padding(
                padding: const EdgeInsets.all(10.0),
                child: prefixIcon,
              ),
        suffixIcon: suffixIcon,
      ),
    );
  }

// changeField Focus
  static void changeFieldFocus({
    required BuildContext context,
    required FocusNode currentNode,
    required FocusNode nextNode,
  }) {
    currentNode.unfocus();
    FocusScope.of(context).requestFocus(nextNode);
  }

// -------------------------------

  static List<IconData> drawerTileIcons = [
    FontAwesomeIcons.user,
    FontAwesomeIcons.crown,
    FontAwesomeIcons.star,
    FontAwesomeIcons.bookmark,
    FontAwesomeIcons.chartLine,
    FontAwesomeIcons.gear,
  ];

  //-------------

  static customDialog({
    required BuildContext context,
    required Widget child,
    bool barrierDismissible = true,
  }) {
    showDialog(
      barrierDismissible: barrierDismissible,
      context: context,
      builder: (context) {
        return Center(child: GlassmorphContainer(child: child));
      },
    );
  }

  //============
  static alertDialog({
    required BuildContext context,
    Widget? inputTitle,
    Widget? inputContent,
    List<Widget>? inputActions,
    bool? barrierDismissible = true,
    Color? backgroundColor,
    EdgeInsetsGeometry? contentPadding,
    EdgeInsetsGeometry? actionsPadding,
    MainAxisAlignment? actionsAlignment,
    EdgeInsets insetPadding =
        const EdgeInsets.symmetric(horizontal: 80.0, vertical: 10.0),
  }) {
    showDialog(
        barrierDismissible: barrierDismissible!,
        context: context,
        builder: (context) {
          return AlertDialog(
            backgroundColor: backgroundColor,
            actionsAlignment: actionsAlignment,
            insetPadding: insetPadding,
            contentPadding: contentPadding,
            actionsPadding: actionsPadding,
            title: inputTitle,
            content: inputContent,
            actions: inputActions,
          );
        });
  }

  static showToastMessage(String message) {
    Fluttertoast.showToast(msg: message, timeInSecForIosWeb: 2);
  }

  //===============

  // select Image
  static Future<File?> selectImage({
    required ImageSource source,
  }) async {
    XFile? pickedImageFile;
    try {
      pickedImageFile = await ImagePicker().pickImage(source: source);
    } catch (e) {
      debugPrint(e.toString());
      Utils.showToastMessage(AppStrings.uploadErrorTitle);
    }

    if (pickedImageFile != null) {
      // debugPrint(pickedImageFile.path.toString());
      return await cropImage(
        pickedImageFile: pickedImageFile,
      );
    }
    return null;
  }

// crop Image
  static Future<File?> cropImage({
    required XFile pickedImageFile,
  }) async {
    CroppedFile? croppedIMageFile =
        await ImageCropper().cropImage(sourcePath: pickedImageFile.path);
    if (croppedIMageFile != null) {
      return File(croppedIMageFile.path);
    }
    return null;
  }
}
