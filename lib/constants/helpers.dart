import 'package:flutter/material.dart';

import '../utils/app_colors.dart';

class Helpers {
  static PageRoute pageRouteBuilder(widget) {
    return MaterialPageRoute(builder: (context) => widget);
  }

  static void showSnackbar(BuildContext context, String msg,
      {bool isError = false}) {
    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(
        SnackBar(
          backgroundColor: isError ? Colors.red : Colors.green,
          content: Text(
            msg,
            style: TextStyle(color: AppColors.whiteColor),
          ),
          behavior: SnackBarBehavior.floating,
        ),
      );
  }
}
