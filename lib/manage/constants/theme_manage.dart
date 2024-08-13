import 'package:flutter/material.dart';
import 'package:hexagonal_app/manage/constants/constants.dart';

class ThemeManage {
  static ThemeData get theme {
    return ThemeData(
      scaffoldBackgroundColor: AppColors.g00,
      bottomAppBarTheme: const BottomAppBarTheme(
        padding: EdgeInsets.zero,
        height: 72,
        color: AppColors.g00,
      ),
    );
  }
}
