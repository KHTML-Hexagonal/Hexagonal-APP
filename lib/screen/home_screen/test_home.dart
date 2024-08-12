import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_naver_map/flutter_naver_map.dart';
import 'package:hexagonal_app/manage/constants/color_table.dart';
import 'package:hexagonal_app/manage/data/yongin_cords.dart';

class TestHome extends StatefulWidget {
  const TestHome({super.key});

  @override
  State<TestHome> createState() => _TestHomeState();
}

class _TestHomeState extends State<TestHome> {
  final Completer<NaverMapController> mapControllerCompleter = Completer();

  // 외곽선을 그리기 위한 좌표 리스트 정의 (일반 리스트)
  final List<List<double>> coords = yonginCoords;

  @override
  void initState() {
    super.initState();
    _addPolygonOverlay();
  }

  Widget _buildNaverMap() {
    return NaverMap(
      options: const NaverMapViewOptions(
        liteModeEnable: true,
        indoorEnable: true,
        locationButtonEnable: false,
        consumeSymbolTapEvents: true,
        logoMargin: EdgeInsets.only(bottom: 30, left: 24),
        logoAlign: NLogoAlign.leftBottom,
        logoClickEnable: false,
        initialCameraPosition: NCameraPosition(
          target: NLatLng(37.2412522, 127.1774916),
          zoom: 14,
        ),
        extent: NLatLngBounds(
          southWest: NLatLng(37.0803988, 127.034457),
          northEast: NLatLng(37.3849469, 127.4282161),
        ),
      ),
      onMapReady: (naverMapController) {
        mapControllerCompleter.complete(naverMapController);
      },
    );
  }

  Future<void> _addPolygonOverlay() async {
    final mapController = await mapControllerCompleter.future;

    // 외곽선이 될 큰 사각형 좌표 설정 (화면을 모두 덮는 좌표)
    List<NLatLng> outerCoords = [
      const NLatLng(38.000000, 126.5000000), // top-left
      const NLatLng(38.000000, 128.0000000), // top-right
      const NLatLng(36.0000000, 128.0000000), // bottom-right
      const NLatLng(36.0000000, 126.5000000), // bottom-left
      const NLatLng(38.00000, 126.5000000), // close the loop
    ];

    // yonginCoords를 NLatLng 리스트로 변환
    List<NLatLng> holeCoords =
        coords.map((coord) => NLatLng(coord[1], coord[0])).toList();

    // NPolygonOverlay 생성
    final polygonOverlay = NPolygonOverlay(
      id: 'maskOverlay',
      coords: outerCoords, // 외곽선 좌표
      holes: [holeCoords], // yonginCoords를 holes로 설정
      color: AppColors.black.withOpacity(0.9),
      outlineColor: AppColors.blue.withOpacity(0.3), // 외곽선 색상
      outlineWidth: 3, // 외곽선 두께
    );

    mapController.addOverlay(polygonOverlay); // 오버레이 추가
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      behavior: HitTestBehavior.translucent,
      child: Scaffold(
        body: Stack(
          children: [
            _buildNaverMap(),
          ],
        ),
      ),
    );
  }
}
