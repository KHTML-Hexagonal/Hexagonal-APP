import 'package:flutter/material.dart';
import 'package:hexagonal_app/manage/constants/constants.dart';

class MaterialRegComplete extends StatefulWidget {
  const MaterialRegComplete({super.key});

  @override
  State<MaterialRegComplete> createState() => _MaterialRegCompleteState();
}

class _MaterialRegCompleteState extends State<MaterialRegComplete> {
  final List<String> imageUrls = [
    'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTXZh3-jbP0MTAbsWXm5SjX_tSYLYxWkrSnWg&s',
    'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQk5M5twYO4OrM_JGeJXMd2MsU9Xk9JdLE1mg&s',
    'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRzCk4Xm2Xo0Xdo5f34uw-svRzqSKAOhxqMFQ&s'
  ]; // 여러 개의 이미지 URL

  final List<String> listText = ['안녕', '하늘', '곰마', '안녕', '하늘', '곰마', '안녕'];

  @override
  Widget build(BuildContext context) {
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
                          itemCount: imageUrls.length,
                          itemBuilder: (context, index) {
                            return Image.network(
                              imageUrls[index],
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
                      Text('처인구 삼가동, 185-7',
                          style:
                              AppTextStyles.st2.copyWith(color: AppColors.g80)),
                      Gaps.v16,
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
                                  child: Text('하하호호\najajjaj\n먼엄넝ㅁ너ㅓ',
                                      style: AppTextStyles.bd4
                                          .copyWith(color: AppColors.g80))),
                            )
                          ]),
                      Gaps.v16,
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
                                      borderRadius: BorderRadius.circular(8)),
                                  child: Text('집주인님 전화번호',
                                      style: AppTextStyles.bd4
                                          .copyWith(color: AppColors.g80))),
                            )
                          ]),
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
                const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 12),
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          NumberWidget(thisNumber: 97, thisText: '균열'),
                          NumberWidget(thisNumber: 97, thisText: '누수'),
                          NumberWidget(thisNumber: 97, thisText: '부식'),
                          NumberWidget(thisNumber: 97, thisText: '노후화'),
                          NumberOrangeWidget(thisNumber: 97, thisText: '총점')
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
                          children: listText.map((text) {
                            return OrangeChips(thisText: text);
                          }).toList()),
                      Gaps.v24,
                      const CustomDivider(thisHeight: 2),
                      Gaps.v20,
                      Gaps.v20,
                      Text('건물 구조',
                          style:
                              AppTextStyles.bd5.copyWith(color: AppColors.g40)),
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
