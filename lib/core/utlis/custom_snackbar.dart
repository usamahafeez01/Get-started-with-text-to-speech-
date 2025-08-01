

import 'package:flutter/material.dart';
import 'package:speech_to_text/core/constant/app_colors.dart';

class CustomizedSnackbar {
  static bool _isSnackbarVisible = false;

  static void show({
    required BuildContext context,
    required String label,
    required String message,
    Color backgroundColor = Colors.white,
    Color textColor = Colors.black,
    int durationInSeconds = 3,
  }) {
    if (_isSnackbarVisible) return;

    _isSnackbarVisible = true;

    ScaffoldMessenger.of(context).hideCurrentSnackBar();

    final snackBar = SnackBar(
      behavior: SnackBarBehavior.floating,
      backgroundColor: Colors.transparent,
      elevation: 0,
      duration: Duration(seconds: durationInSeconds),
      content: TweenAnimationBuilder<Offset>(
        tween: Tween(begin: const Offset(0, 1), end: Offset.zero),
        duration: const Duration(milliseconds: 400),
        curve: Curves.easeOut,
        builder: (context, value, child) {
          return Transform.translate(
            offset: value * 50,
            child: child,
          );
        },
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
          decoration: BoxDecoration(
            color: backgroundColor,
            borderRadius: BorderRadius.circular(16),
            boxShadow: [
              BoxShadow(
                color: AppColors.indigoColor.withOpacity(0.6),
                blurRadius: 2,
                spreadRadius: 1,
              ),
            ],
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: TextStyle(
                  fontSize: 14,
                  fontFamily: "OpenSans_Bold",
                  color: textColor.withOpacity(0.9),
                  fontWeight: FontWeight.bold,
                ),
              ),
SizedBox(height: 4,),             Text(
                message,
                style: TextStyle(
                  fontSize: 11,
                  color: textColor,
                  fontWeight: FontWeight.normal,
                ),
              ),
            ],
          ),
        ),
      ),
    );

    ScaffoldMessenger.of(context)
        .showSnackBar(snackBar)
        .closed
        .then((_) => _isSnackbarVisible = false);
  }
}
