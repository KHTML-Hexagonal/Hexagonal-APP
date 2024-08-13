import 'package:flutter/material.dart';
import 'package:hexagonal_app/manage/constants/constants.dart';

class GreyChips extends StatelessWidget {
  final String thisText;

  const GreyChips({
    super.key,
    required this.thisText,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: AppColors.g20, width: 1),
          color: AppColors.white),
      child: Text(thisText,
          style: AppTextStyles.btn2.copyWith(
            color: AppColors.black,
          )),
    );
  }
}
