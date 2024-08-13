import 'package:flutter/material.dart';
import 'package:hexagonal_app/manage/constants/constants.dart';

class RepairChips extends StatelessWidget {
  final String thisText;

  const RepairChips({
    super.key,
    required this.thisText,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 4),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(2),
        color: AppColors.g10,
      ),
      child: Text(thisText,
          style: AppTextStyles.caption.copyWith(
            color: AppColors.g5,
          )),
    );
  }
}
