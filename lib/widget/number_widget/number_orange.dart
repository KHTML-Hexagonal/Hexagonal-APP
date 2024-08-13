import 'package:flutter/material.dart';
import 'package:hexagonal_app/manage/constants/constants.dart';

class NumberOrangeWidget extends StatelessWidget {
  final String thisText;
  final int thisNumber;

  const NumberOrangeWidget({
    super.key,
    required this.thisNumber,
    required this.thisText,
  });

  @override
  Widget build(BuildContext context) {
    List<String> digits = thisNumber.toString().split('');

    return Expanded(
      child: SizedBox(
        height: 52,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(thisText,
                style: AppTextStyles.bd5.copyWith(color: AppColors.g50)),
            Gaps.v4,
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: digits.map((digit) {
                // 각 자리수에 해당하는 AppIcon을 반환
                return SizedBox(
                  width: 18,
                  height: 30,
                  child: getIconForDigit(digit),
                );
              }).toList(),
            ),
          ],
        ),
      ),
    );
  }

  // 자리수에 맞는 AppIcon을 반환하는 함수
  Widget getIconForDigit(String digit) {
    switch (digit) {
      case '0':
        return AppIcon.o_num_0;
      case '1':
        return AppIcon.o_num_1;
      case '2':
        return AppIcon.o_num_2;
      case '3':
        return AppIcon.o_num_3;
      case '4':
        return AppIcon.o_num_4;
      case '5':
        return AppIcon.o_num_5;
      case '6':
        return AppIcon.o_num_6;
      case '7':
        return AppIcon.o_num_7;
      case '8':
        return AppIcon.o_num_8;
      case '9':
        return AppIcon.o_num_9;
      default:
        return Container(); // 예외 처리용 (실제로는 발생하지 않음)
    }
  }
}
