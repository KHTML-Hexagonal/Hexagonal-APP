import 'package:flutter/material.dart';
import 'package:hexagonal_app/manage/constants/constants.dart';

class LocationBody2 extends StatelessWidget {
  const LocationBody2({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned.fill(
            top: 0,
            // 화면 전체를 채우도록 Positioned.fill 사용
            child: Image.asset('assets/images/screen_image/myplace_screen.png',
                fit: BoxFit.cover)),
        Positioned.fill(
            child: Image.asset('assets/images/screen_image/effect_layer.png',
                fit: BoxFit.cover)),
        Positioned(
          right: 20,
          top: 16,
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 3),
            decoration: BoxDecoration(
              color: AppColors.g80.withOpacity(0.7),
              borderRadius: BorderRadius.circular(30),
            ),
            child: Text(
              '?',
              style: AppTextStyles.bd4.copyWith(color: AppColors.g00),
            ),
          ),
        )
      ],
    );
  }
}
