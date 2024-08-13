import 'package:flutter/material.dart';
import 'package:hexagonal_app/manage/constants/constants.dart';
import 'package:hexagonal_app/manage/constants/font_table.dart';

class ThemeManage {
  static ThemeData get theme {
    return ThemeData(
      primaryColor: AppColors.g40,
      scaffoldBackgroundColor: AppColors.g00,
      bottomAppBarTheme: const BottomAppBarTheme(
        padding: EdgeInsets.zero,
        height: 72,
        color: AppColors.g00,
      ),
      appBarTheme: const AppBarTheme(
        backgroundColor: AppColors.g00,
        surfaceTintColor: Colors.transparent,
        foregroundColor: AppColors.white,
        elevation: 0,
        centerTitle: false,
        titleTextStyle: TextStyle(
          color: AppColors.g6,
          fontSize: 18,
          fontWeight: FontWeight.w700,
        ),
      ),
      tabBarTheme: TabBarTheme(
          indicator: const BoxDecoration(
            border: Border(bottom: BorderSide(color: AppColors.g6, width: 2)),
          ),
          indicatorSize: TabBarIndicatorSize.tab,
          labelColor: AppColors.g6,
          unselectedLabelColor: AppColors.g5,
          labelStyle: AppTextStyles.bd1.copyWith(color: AppColors.g6),
          unselectedLabelStyle:
              AppTextStyles.bd2.copyWith(color: AppColors.g4)),
    );
  }
}
