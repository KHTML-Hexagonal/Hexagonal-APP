import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class OwnerReg1 extends StatefulWidget {
  final VoidCallback onNavigateForward;
  final Function(Map<String, dynamic>) saveImages;

  const OwnerReg1({
    super.key,
    required this.onNavigateForward,
    required this.saveImages,
  });

  @override
  State<OwnerReg1> createState() => _OwnerReg1State();
}

class _OwnerReg1State extends State<OwnerReg1> {
  List<XFile>? image = [];
  final ImagePicker _picker = ImagePicker();

  @override
  void initState() {
    super.initState();
    getImages(ImageSource.gallery);
  }

  // 이미지를 가져오는 함수
  Future<void> getImages(ImageSource source) async {
    final List<XFile> pickedFiles = await _picker.pickMultiImage();
    setState(() {
      image!.addAll(pickedFiles); // 선택된 여러 이미지 저장
    });
    widget.saveImages({'image': image});
    widget.onNavigateForward();
  }

  @override
  Widget build(BuildContext context) {
    return const SizedBox();
  }
}
