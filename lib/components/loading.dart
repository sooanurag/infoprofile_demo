import 'package:flutter/material.dart';

import '../resources/colors.dart';
import '../utils/utils.dart';

class Loading {
  final BuildContext buildContext;
  Loading({required this.buildContext});

  get loading => Utils.customDialog(
      barrierDismissible: false,
      context: buildContext,
      child: Padding(
        padding: const EdgeInsets.all(4.0),
        child: CircularProgressIndicator(
          color: AppColors.white,
        ),
      ));
}
