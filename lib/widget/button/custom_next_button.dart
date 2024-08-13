import 'package:flutter/material.dart';
import 'package:hexagonal_app/manage/constants/constants.dart';

class CustomNextButton extends StatelessWidget {
  final VoidCallback onNavigateForward;
  final bool isAble;

  const CustomNextButton({
    super.key,
    required this.onNavigateForward,
    required this.isAble,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 48,
      width: double.infinity,
      decoration: BoxDecoration(
        color: isAble ? AppColors.or40 : AppColors.g30,
        borderRadius: BorderRadius.circular(8),
      ),
      child: TextButton(
        onPressed: () {
          if (isAble) {}
        },
        child: Text(
          '네, 다음으로',
          style: AppTextStyles.bd3.copyWith(color: AppColors.g00),
        ),
      ),
    );
  }
}
