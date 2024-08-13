import 'package:flutter/material.dart';
import 'package:hexagonal_app/manage/constants/constants.dart';
import 'package:hexagonal_app/manage/constants/screen_manage.dart';

class MaterialMain extends StatelessWidget {
  const MaterialMain({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 16),
            child: SizedBox(
              width: 24,
              height: 24,
              child: AppIcon.search,
            ),
          ),
        ],
      ),
      body: Stack(
        children: [
          Positioned.fill(
              top: 0,
              // 화면 전체를 채우도록 Positioned.fill 사용
              child: Image.asset(
                  'assets/images/screen_image/material_screen.png',
                  fit: BoxFit.cover)),
          Positioned(
            bottom: 16,
            right: 24,
            child: GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const MaterialIntergrate()),
                );
              },
              child: Container(
                padding: const EdgeInsets.fromLTRB(14, 11, 16, 11),
                decoration: BoxDecoration(
                    color: AppColors.or40,
                    borderRadius: BorderRadius.circular(30)),
                child: Row(
                  children: [
                    SizedBox(
                        width: 20, height: 20, child: AppIcon.write_swhite),
                    Gaps.h4,
                    Text(
                      '글쓰기',
                      style: AppTextStyles.bd1.copyWith(color: AppColors.g00),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
