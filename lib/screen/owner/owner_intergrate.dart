import 'package:flutter/material.dart';
import 'package:hexagonal_app/manage/constants/constants.dart';
import 'package:hexagonal_app/manage/constants/screen_manage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;

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
  BuildingRegistrationResponse? response;
  bool isLoading = false;

  Future<void> registerHouse() async {
    setState(() {
      isLoading = true;
    });
    try {
      // 이미지 파일들을 MultipartFile로 변환
      List<http.MultipartFile> imageFiles =
          await Future.wait(image.map((file) async {
        return await http.MultipartFile.fromPath('images', file.path);
      }));

      // ServerApi의 postOwnerHouse 메소드를 호출하여 서버에 데이터를 전송
      var thisResponse = await ServerApi.postOwnerHouse(uniqueId, imageFiles);
      response = thisResponse;

      print('데이터: $response');
      setState(() {
        isLoading = false;
      });

      // 데이터 수신 후 화면 전환
      setState(() {
        _currentIndex = 2;
      });
    } catch (e) {
      print('등록 실패: $e');
      setState(() {
        isLoading = false;
      });
      // 오류 처리 (필요 시 다이얼로그나 스낵바를 사용하여 사용자에게 알림)
    }
  }

  // 화면 전환 함수
  void switchScreen(int index) {
    if (index == 3) {
      Navigator.push(context,
          MaterialPageRoute(builder: (context) => const OwnerRegComplete()));
    } else if (index == 2) {
      if (!isLoading && response != null) {
        setState(() {
          _currentIndex = index;
        });
      }
    } else {
      setState(() {
        _currentIndex = index;
      });
    }
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
            onNavigateForward: () => registerHouse(),
            saveUniqueIdandLocation: saveUniqueId,
          ),
          if (response != null) // response가 null이 아닌 경우에만 OwnerReg3을 렌더링
            OwnerReg3(
              storedImages: image,
              addressText: addressText,
              onNavigateForward: () => switchScreen(3),
              response: response!,
              isLoading: isLoading,
            ),
          if (response == null) // response가 null이면 로딩 화면
            const Center(
              child: CircularProgressIndicator(),
            ),
        ],
      ),
    );
  }
}
