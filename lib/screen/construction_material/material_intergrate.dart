import 'package:flutter/material.dart';
import 'package:hexagonal_app/manage/constants/screen_manage.dart';
import 'package:image_picker/image_picker.dart';

class MaterialIntergrate extends StatefulWidget {
  const MaterialIntergrate({super.key});

  @override
  State<MaterialIntergrate> createState() => _MaterialIntergrateState();
}

class _MaterialIntergrateState extends State<MaterialIntergrate> {
  int _currentIndex = 0;
  List<XFile> image = [];
  String addressText = '';
  double longitude = 0.0;
  double latitude = 0.0;

  // 화면 전환 함수
  void switchScreen(int index) {
    if (index == 3) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => const MaterialRegComplete(),
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
      addressText = data['address'];
      longitude = data['longitude'];
      latitude = data['latitude'];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: _currentIndex,
        children: <Widget>[
          MaterialReg1(
            onNavigateForward: () => switchScreen(1),
            saveImages: saveImages,
          ),
          MaterialReg2(
            onNavigateForward: () => switchScreen(2),
            saveLocation: saveUniqueId,
          ),
          MaterialReg3(
            storedImages: image,
            addressText: addressText,
            onNavigateForward: () => switchScreen(3),
          ),
        ],
      ),
    );
  }
}
