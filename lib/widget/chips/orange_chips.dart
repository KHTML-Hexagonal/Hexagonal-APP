import 'package:flutter/material.dart';
import 'package:hexagonal_app/manage/constants/constants.dart';

class OrangeChips extends StatelessWidget {
  final String thisText;

  const OrangeChips({
    super.key,
    required this.thisText,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 4),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(2),
        color: AppColors.salmon.withOpacity(0.1),
      ),
      child: Text(thisText,
          style: AppTextStyles.btn2.copyWith(
            color: AppColors.salmon,
          )),
    );
  }
}
