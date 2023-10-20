import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

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
  }) {
    return TextButton(
      onPressed: onPressed,
      style: ButtonStyle(
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
        style: AppFonts.headerStyle(fontSize: fontSize, fontWeight: fontWeight,context: context),
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
  static alertDialog({
    required BuildContext context,
    Widget? inputTitle,
    Widget? inputContent,
    List<Widget>? inputActions,
  }) {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            contentPadding: EdgeInsets.zero,
            title: inputTitle,
            content: inputContent,
            actions: inputActions,
          );
        });
  }
}
