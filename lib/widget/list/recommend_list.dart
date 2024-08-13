import 'package:flutter/material.dart';
import 'package:hexagonal_app/manage/constants/constants.dart';
import 'package:hexagonal_app/manage/constants/screen_manage.dart';

class RecommendServiceList extends StatelessWidget {
  final String thisUniqueBuildingId;
  final String thisImageUrl;
  final String thisBuildingName;
  final List<String> listText;

  const RecommendServiceList({
    super.key,
    required this.thisUniqueBuildingId,
    required this.thisImageUrl,
    required this.thisBuildingName,
    required this.listText,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => HomeBuildingDetail(
              thisUniqueBuildingId: thisUniqueBuildingId,
            ),
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
                thisImageUrl,
                fit: BoxFit.cover,
              ),
            ),
            Gaps.h11,
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    thisBuildingName,
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
