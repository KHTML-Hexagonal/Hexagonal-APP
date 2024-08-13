import 'package:flutter/material.dart';
import 'package:hexagonal_app/manage/constants/constants.dart';
import 'package:hexagonal_app/manage/constants/screen_manage.dart';

class RecommendServiceList extends StatefulWidget {
  final String thisUniqueBuildingId;

  const RecommendServiceList({
    super.key,
    required this.thisUniqueBuildingId,
  });

  @override
  State<RecommendServiceList> createState() => _RecommendServiceListState();
}

class _RecommendServiceListState extends State<RecommendServiceList> {
  final List<String> listText = [
    '안녕',
    '하늘',
    '곰마',
    '안녕',
    '하늘',
    '곰마',
    '안녕',
  ]; // 예시 데이터

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const HomeBuildingDetail(),
          ),
        );
      },
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 16),
        child: Row(
          children: [
            Container(
              width: 88,
              height: 88,
              clipBehavior: Clip.hardEdge,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Colors.grey,
              ),
              child: Image.network(
                'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTXZh3-jbP0MTAbsWXm5SjX_tSYLYxWkrSnWg&s',
                fit: BoxFit.cover,
              ),
            ),
            Gaps.h11,
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '처인구 삼가동, 185-7',
                    style: AppTextStyles.bd1.copyWith(color: AppColors.g80),
                  ),
                  Gaps.v7,
                  Wrap(
                    spacing: 4,
                    runSpacing: 4,
                    children: listText.map((text) {
                      return RepairChips(thisText: text);
                    }).toList(),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
