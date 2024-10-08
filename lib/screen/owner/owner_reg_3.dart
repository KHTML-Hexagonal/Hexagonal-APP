import 'package:flutter/material.dart';
import 'package:hexagonal_app/manage/constants/constants.dart';
import 'package:image_picker/image_picker.dart';

class OwnerReg3 extends StatefulWidget {
  final VoidCallback onNavigateForward;
  final List<XFile> storedImages;
  final String addressText;
  final BuildingRegistrationResponse response;
  final bool isLoading;

  const OwnerReg3({
    super.key,
    required this.storedImages,
    required this.addressText,
    required this.onNavigateForward,
    required this.response,
    required this.isLoading,
  });

  @override
  State<OwnerReg3> createState() => _OwnerReg3State();
}

class _OwnerReg3State extends State<OwnerReg3> {
  @override
  Widget build(BuildContext context) {
    final buildingData = widget.response.data;

    return GestureDetector(
      onTap: FocusScope.of(context).unfocus,
      child: Scaffold(
        appBar: BackTitleAppBar(
          text: '내 집 등록',
          thisTextStyle: AppTextStyles.st2.copyWith(color: AppColors.g6),
        ),
        body: widget.isLoading
            ? const Center(
                child: CircularProgressIndicator(
                    valueColor: AlwaysStoppedAnimation<Color>(AppColors.g20)))
            : SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Gaps.v16,
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Gaps.h24,
                          Container(
                              padding: const EdgeInsets.fromLTRB(20, 12, 20, 0),
                              width: 80,
                              height: 80,
                              decoration: BoxDecoration(
                                  border: Border.all(
                                    color: AppColors.g20,
                                    width: 1,
                                  ),
                                  borderRadius: BorderRadius.circular(8)),
                              child: Column(children: [
                                SizedBox(
                                    width: 40, height: 40, child: AppIcon.img),
                                Gaps.v4,
                                Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                          widget.storedImages.length.toString(),
                                          style: AppTextStyles.bd5
                                              .copyWith(color: AppColors.or40)),
                                      Gaps.h1,
                                      Text('/10',
                                          style: AppTextStyles.bd5
                                              .copyWith(color: AppColors.g30))
                                    ])
                              ])),
                          Gaps.h16,
                          ...widget.storedImages.map((file) {
                            int index = widget.storedImages.indexOf(file);
                            return RegImageList(
                              key: ValueKey(file.path),
                              file: file,
                              storeArea: widget.storedImages,
                              index: index,
                              deleteSelectedImage:
                                  (List<XFile> storeArea, int index) {
                                setState(() {
                                  storeArea.removeAt(index);
                                });
                              },
                            );
                          }),
                        ],
                      ),
                    ),
                    Gaps.v24,
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 24),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              SizedBox(
                                  height: 28,
                                  width: 28,
                                  child: AppIcon.location),
                              Gaps.h4,
                              Text(
                                widget.addressText,
                                style: AppTextStyles.bd1
                                    .copyWith(color: AppColors.g80),
                              ),
                            ],
                          ),
                          Gaps.v24,
                          const CustomDivider(thisHeight: 2),
                          Gaps.v24,
                          Row(children: [
                            SizedBox(
                              width: 28,
                              height: 28,
                              child: AppIcon.magnifier,
                            ),
                            Gaps.h2,
                            Text('AI의 내 집 상태 판단',
                                style: AppTextStyles.bd1
                                    .copyWith(color: AppColors.g50))
                          ]),
                          Gaps.v10,
                          Container(
                            decoration: BoxDecoration(
                              color: AppColors.g10,
                              borderRadius: BorderRadius.circular(8),
                            ),
                            padding:
                                const EdgeInsets.fromLTRB(12, 24.5, 12, 28.5),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
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
                                  ],
                                ),
                                Gaps.v22,
                                const CustomDividerWhite(thisHeight: 2),
                                Gaps.v22,
                                Text('보수 필요 항목',
                                    style: AppTextStyles.bd5
                                        .copyWith(color: AppColors.g40)),
                                Gaps.v12,
                                Wrap(
                                  spacing: 4,
                                  runSpacing: 4,
                                  children: buildingData.repairList
                                      .split(', ')
                                      .map((text) {
                                    return OrangeChips(thisText: text);
                                  }).toList(),
                                ),
                                Gaps.v22,
                                const CustomDividerWhite(thisHeight: 2),
                                Gaps.v22,
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
                          ),
                          Gaps.v32,
                          const CustomDivider(thisHeight: 2),
                          Gaps.v24,
                          Row(children: [
                            Text('추가 설명을 작성해 주세요',
                                style: AppTextStyles.bd1
                                    .copyWith(color: AppColors.g60)),
                            Text('(선택)',
                                style: AppTextStyles.bd1
                                    .copyWith(color: AppColors.g30))
                          ]),
                          Gaps.v10,
                          Container(
                            padding: const EdgeInsets.fromLTRB(12, 12, 12, 12),
                            decoration: BoxDecoration(
                                border: Border.all(
                                  color: AppColors.g20,
                                  width: 1,
                                ),
                                borderRadius: BorderRadius.circular(8)),
                            child: TextField(
                                maxLines: 5,
                                decoration: InputDecoration(
                                  border: InputBorder.none,
                                  hintText:
                                      '원하는 수리 항목 및 전달하고 싶은 내용 등을\n자유롭게 작성해 주세요',
                                  hintStyle: AppTextStyles.bd4
                                      .copyWith(color: AppColors.g40),
                                )),
                          ),
                          Gaps.v30,
                        ],
                      ),
                    )
                  ],
                ),
              ),
        bottomNavigationBar: BottomAppBar(
          height: 84,
          padding: const EdgeInsets.fromLTRB(24, 12, 24, 24),
          child: Container(
            height: 48,
            width: double.infinity,
            decoration: BoxDecoration(
              color: AppColors.or40,
              borderRadius: BorderRadius.circular(8),
            ),
            child: TextButton(
              onPressed: () {
                widget.onNavigateForward();
              },
              child: Text(
                '작성 완료',
                style: AppTextStyles.bd3.copyWith(color: AppColors.g00),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
