import 'package:flutter/material.dart';
import 'package:hexagonal_app/manage/constants/color_table.dart';

class CustomDivider extends StatelessWidget {
  final double thisHeight;
  const CustomDivider({super.key, required this.thisHeight});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: thisHeight,
      width: double.infinity,
      color: AppColors.g10,
    );
  }
}

class CustomDividerWhite extends StatelessWidget {
  final double thisHeight;
  const CustomDividerWhite({super.key, required this.thisHeight});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: thisHeight,
      width: double.infinity,
      color: AppColors.g00,
    );
  }
}
