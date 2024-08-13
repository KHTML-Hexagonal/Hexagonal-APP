import 'package:flutter/material.dart';
import 'package:hexagonal_app/manage/constants/constants.dart';
import 'package:image_picker/image_picker.dart';

class OwnerReg3 extends StatefulWidget {
  final VoidCallback onNavigateForward;

  final List<XFile> storedImages;
  final String addressText;

  const OwnerReg3({
    super.key,
    required this.storedImages,
    required this.addressText,
    required this.onNavigateForward,
  });

  @override
  State<OwnerReg3> createState() => _OwnerReg3State();
}

class _OwnerReg3State extends State<OwnerReg3> {
  final List<String> listText = ['안녕', '하늘', '곰마', '안녕', '하늘', '곰마', '안녕'];
  bool isLoading = true;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: FocusScope.of(context).unfocus,
      child: Scaffold(
        appBar: BackTitleAppBar(
          text: '내 집 등록',
          thisTextStyle: AppTextStyles.st2.copyWith(color: AppColors.g6),
        ),
        body: isLoading
            ? const Center(
                child: CircularProgressIndicator(
                    valueColor: AlwaysStoppedAnimation<Color>(AppColors.g20)))
            : SingleChildScrollView(
                child: Column(
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
                            // 스프레드 연산자 사용
                            int index = widget.storedImages.indexOf(file);
                            return RegImageList(
                              key: ValueKey(file
                                  .path), // key를 파일 경로로 설정하여 더 나은 성능과 구분을 제공
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
                            color: AppColors.g10,
                            padding:
                                const EdgeInsets.fromLTRB(12, 24.5, 12, 28.5),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      NumberWidget(
                                          thisNumber: 97, thisText: '균열'),
                                      NumberWidget(
                                          thisNumber: 97, thisText: '누수'),
                                      NumberWidget(
                                          thisNumber: 97, thisText: '부식'),
                                      NumberWidget(
                                          thisNumber: 97, thisText: '노후화'),
                                      NumberOrangeWidget(
                                          thisNumber: 97, thisText: '총점')
                                    ]),
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
                                    children: listText.map((text) {
                                      return OrangeChips(thisText: text);
                                    }).toList()),
                                Gaps.v22,
                                const CustomDividerWhite(thisHeight: 2),
                                Gaps.v22,
                                Text('건물 구조',
                                    style: AppTextStyles.bd5
                                        .copyWith(color: AppColors.g40)),
                                Gaps.v8,
                                //조건문 추가 필요
                                Row(children: [
                                  Text('지붕의 형태: ',
                                      style: AppTextStyles.bd4
                                          .copyWith(color: AppColors.g80)),
                                  Text('호호',
                                      style: AppTextStyles.bd4
                                          .copyWith(color: AppColors.g80))
                                ]),
                                Row(children: [
                                  Text('외벽의 재질: ',
                                      style: AppTextStyles.bd4
                                          .copyWith(color: AppColors.g80)),
                                  Text('호호',
                                      style: AppTextStyles.bd4
                                          .copyWith(color: AppColors.g80))
                                ]),
                                //조건문 추가 필요
                                Row(children: [
                                  Text('창문 및 문의 형태: ',
                                      style: AppTextStyles.bd4
                                          .copyWith(color: AppColors.g80)),
                                  Text('호호',
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
                                  hintText: '추가 설명을 작성해 주세요',
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
