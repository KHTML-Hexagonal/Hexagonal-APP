import 'package:flutter/material.dart';
import 'package:hexagonal_app/manage/constants/constants.dart';

class HomeBuildingDetail extends StatefulWidget {
  final String thisUniqueBuildingId;

  const HomeBuildingDetail({
    super.key,
    required this.thisUniqueBuildingId,
  });

  @override
  State<HomeBuildingDetail> createState() => _HomeBuildingDetailState();
}

class _HomeBuildingDetailState extends State<HomeBuildingDetail> {
  BuildingDetailModel? buildingDetail;

  @override
  void initState() {
    super.initState();
    _loadBuildingDetail();
  }

  void _loadBuildingDetail() async {
    try {
      final detail =
          await ServerApi.getBuildingDetail(widget.thisUniqueBuildingId);
      setState(() {
        buildingDetail = detail;
      });
      print('건물 정보 로드 성공: ${buildingDetail?.buildingId}');
    } catch (e) {
      print('건물 정보 로드 실패: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    if (buildingDetail == null) {
      return const Scaffold(
        body: Center(
          child: CircularProgressIndicator(),
        ),
      );
    }

    return Scaffold(
      body: Stack(
        children: [
          SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Stack(children: [
                  SizedBox(
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.width, // 1:1 비율을 위한 설정
                    child: PageView.builder(
                      itemCount: buildingDetail!.images.length,
                      itemBuilder: (context, index) {
                        return Image.network(
                          buildingDetail!.images[index],
                          fit: BoxFit.cover,
                        );
                      },
                    ),
                  ),
                  Positioned(
                    bottom: 0,
                    left: 0,
                    right: 0,
                    child: IgnorePointer(
                      child: Container(
                        width: MediaQuery.of(context).size.width,
                        height: 56,
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: [
                              AppColors.black.withOpacity(0.6),
                              AppColors.black.withOpacity(0.0)
                            ],
                            begin: Alignment.bottomCenter,
                            end: Alignment.topCenter,
                          ),
                        ),
                      ),
                    ),
                  )
                ]),
                Container(
                  padding: const EdgeInsets.all(24),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      if (buildingDetail!.address.isNotEmpty)
                        Text(buildingDetail!.address,
                            style: AppTextStyles.st2
                                .copyWith(color: AppColors.g80)),
                      Gaps.v16,
                      if (buildingDetail!.description.isNotEmpty)
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(
                              width: 24,
                              child: AppIcon.notice,
                            ),
                            Gaps.h8,
                            Expanded(
                              child: Container(
                                width: double.infinity,
                                padding: const EdgeInsets.all(10),
                                decoration: BoxDecoration(
                                  color: AppColors.g10,
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: Text(buildingDetail!.description,
                                    style: AppTextStyles.bd4
                                        .copyWith(color: AppColors.g80)),
                              ),
                            )
                          ],
                        ),
                      Gaps.v16,
                      if (buildingDetail!.phoneNumber.isNotEmpty)
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(
                              width: 24,
                              child: AppIcon.phone,
                            ),
                            Gaps.h8,
                            Expanded(
                              child: Container(
                                width: double.infinity,
                                padding: const EdgeInsets.all(10),
                                decoration: BoxDecoration(
                                  color: AppColors.g10,
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: Text(
                                  buildingDetail!.phoneNumber,
                                  style: AppTextStyles.bd4
                                      .copyWith(color: AppColors.g80),
                                ),
                              ),
                            )
                          ],
                        ),
                    ],
                  ),
                ),
                const CustomDivider(thisHeight: 4),
                Gaps.v28,
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24),
                  child: Text(
                    '이미지 기반 AI 진단',
                    style: AppTextStyles.st1.copyWith(color: AppColors.g80),
                  ),
                ),
                Gaps.v16,
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      NumberWidget(
                          thisNumber: buildingDetail!.crackScore,
                          thisText: '균열'),
                      NumberWidget(
                          thisNumber: buildingDetail!.leakScore,
                          thisText: '누수'),
                      NumberWidget(
                          thisNumber: buildingDetail!.corrosionScore,
                          thisText: '부식'),
                      NumberWidget(
                          thisNumber: buildingDetail!.agingScore,
                          thisText: '노후화'),
                      NumberOrangeWidget(
                          thisNumber: buildingDetail!.totalScore,
                          thisText: '총점'),
                    ],
                  ),
                ),
                Container(
                  padding: const EdgeInsets.all(24),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const CustomDivider(thisHeight: 2),
                      Gaps.v20,
                      if (buildingDetail!.repairList.isNotEmpty)
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('보수 필요 항목',
                                style: AppTextStyles.bd5
                                    .copyWith(color: AppColors.g40)),
                            Gaps.v12,
                            Wrap(
                              spacing: 4,
                              runSpacing: 4,
                              children: buildingDetail!.repairList
                                  .split(', ')
                                  .map((text) {
                                return OrangeChips(thisText: text);
                              }).toList(),
                            ),
                          ],
                        ),
                      Gaps.v24,
                      const CustomDivider(thisHeight: 2),
                      Gaps.v20,
                      if (buildingDetail!.roofMaterial.isNotEmpty ||
                          buildingDetail!.wallMaterial.isNotEmpty ||
                          buildingDetail!.windowDoorMaterial.isNotEmpty)
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('건물 구조',
                                style: AppTextStyles.bd5
                                    .copyWith(color: AppColors.g40)),
                            Gaps.v8,
                            if (buildingDetail!.roofMaterial.isNotEmpty)
                              Row(children: [
                                Text('지붕의 형태: ',
                                    style: AppTextStyles.bd4
                                        .copyWith(color: AppColors.g80)),
                                Text(buildingDetail!.roofMaterial,
                                    style: AppTextStyles.bd4
                                        .copyWith(color: AppColors.g80))
                              ]),
                            Gaps.v8,
                            if (buildingDetail!.wallMaterial.isNotEmpty)
                              Row(children: [
                                Text('외벽의 재질: ',
                                    style: AppTextStyles.bd4
                                        .copyWith(color: AppColors.g80)),
                                Text(buildingDetail!.wallMaterial,
                                    style: AppTextStyles.bd4
                                        .copyWith(color: AppColors.g80))
                              ]),
                            Gaps.v8,
                            if (buildingDetail!.windowDoorMaterial.isNotEmpty)
                              Row(children: [
                                Text('창문 및 문의 형태: ',
                                    style: AppTextStyles.bd4
                                        .copyWith(color: AppColors.g80)),
                                Text(buildingDetail!.windowDoorMaterial,
                                    style: AppTextStyles.bd4
                                        .copyWith(color: AppColors.g80))
                              ]),
                          ],
                        ),
                      Gaps.v50,
                    ],
                  ),
                ),
              ],
            ),
          ),
          Positioned(
            left: 20,
            top: 40,
            child: GestureDetector(
              onTap: () {
                Navigator.pop(context);
              },
              child: Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: AppColors.white,
                    boxShadow: [
                      BoxShadow(
                          color: AppColors.black.withOpacity(0.25),
                          blurRadius: 5,
                          offset: const Offset(0, 4))
                    ]),
                child: AppIcon.back_arrow,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
