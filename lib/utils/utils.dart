import 'package:flutter/material.dart';

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
  }) {
    return TextButton(
      onPressed: onPressed,
      style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all(Colors.white),
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

  static Widget infoprofileTypo() => Text(
        "infoprofile",
        style: AppFonts.headerStyle(
            color: Colors.white, fontSize: 38, fontWeight: FontWeight.bold),
      );
  //----------------------------

// customTextFormField
  static TextFormField customTextFormField({
    required TextEditingController inputController,
    required String invalidText,
    String? label,
    String? hint,
    required Widget prefixIcon,
    FocusNode? currentFocusNode,
    BuildContext? context,
    FocusNode? nextNode,
    bool obscure = false,
    Widget? suffixIcon,
    void Function(String)? onChanged,
    bool? isEnabled,
    bool? isFilled,
    Color? fillColor,
    Color? prefixIconColor,
    Color? suffixIconColor,
    Color? cursorColor = Colors.white,
    double? borderRadius = 12,
    EdgeInsetsGeometry? contentPadding,
  }) {
    return TextFormField(
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
        contentPadding: contentPadding,
        filled: isFilled,
        fillColor: fillColor,
        prefixIconColor: prefixIconColor,
        suffixIconColor: suffixIconColor,
        label: (label != null) ? Text(label) : null,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(borderRadius!)),
        ),
        hintText: hint,
        prefixIcon: Padding(
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
}
