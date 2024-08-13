import 'package:flutter/material.dart';
import 'package:hexagonal_app/manage/constants/screen_manage.dart';
import 'package:image_picker/image_picker.dart';

class OwnerIntergrate extends StatefulWidget {
  const OwnerIntergrate({super.key});

  @override
  State<OwnerIntergrate> createState() => _OwnerIntergrateState();
}

class _OwnerIntergrateState extends State<OwnerIntergrate> {
  int _currentIndex = 0;
  List<XFile> image = [];
  String uniqueId = '';
  String addressText = '';

  // 화면 전환 함수
  void switchScreen(int index) {
    if (index == 3) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => const OwnerRegComplete(),
        ),
      );
    }

    setState(() {
      _currentIndex = index;
    });
  }

  // 이미지 저장 함수
  void saveImages(Map<String, dynamic> images) {
    setState(() {
      image = images['image'];
    });
    print('이미지: $image');
  }

  // 건물 고유번호 등록 함수
  void saveUniqueId(Map<String, dynamic> data) {
    print('받은 데이터 : $data');
    setState(() {
      uniqueId = data['uniqueId'];
      addressText = data['address'];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: _currentIndex,
        children: <Widget>[
          OwnerReg1(
            onNavigateForward: () => switchScreen(1),
            saveImages: saveImages,
          ),
          OwnerReg2(
            onNavigateForward: () => switchScreen(2),
            saveUniqueIdandLocation: saveUniqueId,
          ),
          OwnerReg3(
            storedImages: image,
            addressText: addressText,
            onNavigateForward: () => switchScreen(3),
          ),
        ],
      ),
    );
  }
}
