import 'package:flutter/material.dart';
import 'package:hexagonal_app/manage/constants/constants.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

class OwnerRegComplete extends StatefulWidget {
  final BuildingRegistrationResponse response;
  final List<XFile> storedImages;
  final String thisUniqueId;
  final String addressText;

  const OwnerRegComplete({
    super.key,
    required this.response,
    required this.thisUniqueId,
    required this.storedImages,
    required this.addressText,
  });

  @override
  State<OwnerRegComplete> createState() => _OwnerRegCompleteState();
}

class _OwnerRegCompleteState extends State<OwnerRegComplete> {
  @override
  Widget build(BuildContext context) {
    final buildingData = widget.response.data;

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
                      height:
                          MediaQuery.of(context).size.width, // 1:1 비율을 위한 설정
                      child: PageView.builder(
                          itemCount: widget.storedImages.length,
                          itemBuilder: (context, index) {
                            return Image.file(
                              File(widget.storedImages[index].path),
                              fit: BoxFit.cover,
                            );
                          })),
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
                                  end: Alignment.topCenter),
                            )),
                      ))
                ]),
                Container(
                  padding: const EdgeInsets.all(24),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(widget.addressText,
                          style:
                              AppTextStyles.st2.copyWith(color: AppColors.g80)),
                      Gaps.v16,
                      if (buildingData.conditionReason.isNotEmpty)
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
                                      borderRadius: BorderRadius.circular(8)),
                                  child: Text(buildingData.conditionReason,
                                      style: AppTextStyles.bd4
                                          .copyWith(color: AppColors.g80))),
                            )
                          ],
                        ),
                      Gaps.v16,
                      // if (buildingData.phoneNumber?.isNotEmpty ?? false)
                      //   Row(
                      //     crossAxisAlignment: CrossAxisAlignment.start,
                      //     children: [
                      //       SizedBox(
                      //         width: 24,
                      //         child: AppIcon.phone,
                      //       ),
                      //       Gaps.h8,
                      //       Expanded(
                      //         child: Container(
                      //             width: double.infinity,
                      //             padding: const EdgeInsets.all(10),
                      //             decoration: BoxDecoration(
                      //                 color: AppColors.g10,
                      //                 borderRadius: BorderRadius.circular(8)),
                      //             child: Text(buildingData.phoneNumber!,
                      //                 style: AppTextStyles.bd4
                      //                     .copyWith(color: AppColors.g80))),
                      //       )
                      //     ],
                      //   ),
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
                    )),
                Gaps.v16,
                Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 12),
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          NumberWidget(
                              thisNumber: buildingData.crackScore,
                              thisText: '균열'),
                          NumberWidget(
                              thisNumber: buildingData.leakScore,
                              thisText: '누수'),
                          NumberWidget(
                              thisNumber: buildingData.corrosionScore,
                              thisText: '부식'),
                          NumberWidget(
                              thisNumber: buildingData.agingScore,
                              thisText: '노후화'),
                          NumberOrangeWidget(
                              thisNumber: buildingData.totalScore,
                              thisText: '총점')
                        ])),
                Container(
                  padding: const EdgeInsets.all(24),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const CustomDivider(thisHeight: 2),
                      Gaps.v20,
                      Text('보수 필요 항목',
                          style:
                              AppTextStyles.bd5.copyWith(color: AppColors.g40)),
                      Gaps.v12,
                      Wrap(
                          spacing: 4,
                          runSpacing: 4,
                          children:
                              buildingData.repairList.split(', ').map((text) {
                            return OrangeChips(thisText: text);
                          }).toList()),
                      Gaps.v24,
                      const CustomDivider(thisHeight: 2),
                      Gaps.v20,
                      if (buildingData.roofMaterial.isNotEmpty ||
                          buildingData.wallMaterial.isNotEmpty ||
                          buildingData.windowDoorMaterial.isNotEmpty)
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('건물 구조',
                                style: AppTextStyles.bd5
                                    .copyWith(color: AppColors.g40)),
                            Gaps.v8,
                            if (buildingData.roofMaterial.isNotEmpty)
                              Row(children: [
                                Text('지붕의 형태: ',
                                    style: AppTextStyles.bd4
                                        .copyWith(color: AppColors.g80)),
                                Text(buildingData.roofMaterial,
                                    style: AppTextStyles.bd4
                                        .copyWith(color: AppColors.g80))
                              ]),
                            Gaps.v8,
                            if (buildingData.wallMaterial.isNotEmpty)
                              Row(children: [
                                Text('외벽의 재질: ',
                                    style: AppTextStyles.bd4
                                        .copyWith(color: AppColors.g80)),
                                Text(buildingData.wallMaterial,
                                    style: AppTextStyles.bd4
                                        .copyWith(color: AppColors.g80))
                              ]),
                            Gaps.v8,
                            if (buildingData.windowDoorMaterial.isNotEmpty)
                              Row(children: [
                                Text('창문 및 문의 형태: ',
                                    style: AppTextStyles.bd4
                                        .copyWith(color: AppColors.g80)),
                                Text(buildingData.windowDoorMaterial,
                                    style: AppTextStyles.bd4
                                        .copyWith(color: AppColors.g80))
                              ]),
                          ],
                        ),
                      Gaps.v50,
                    ],
                  ),
                )
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
                      child: AppIcon.back_arrow))),
        ],
      ),
    );
  }
}
