import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_naver_map/flutter_naver_map.dart';
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
          zoom: 10,
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

    // NLatLng 리스트로 변환 (정방향)
    List<NLatLng> latLngCoords =
        coords.map((coord) => NLatLng(coord[1], coord[0])).toList();

    // NLatLng 리스트로 변환 (반대 방향)
    // List<NLatLng> reversedLatLngCoords = latLngCoords.reversed.toList();

    // NPolygonOverlayCustom을 생성하고 지도에 추가
    final polygonOverlay = NPolygonOverlay(
      id: 'maskOverlay',
      coords: latLngCoords, // yourCoords는 다각형의 경계선 좌표들
      color: Colors.black.withOpacity(0.5), // 전체 영역의 색상 (반투명 검정)
      outlineColor: Colors.red, // 외곽선 색상
      outlineWidth: 3, // 외곽선 두께
    );

    polygonOverlay.createMaskOverlay(); // 다각형 내부를 비우고 나머지를 채움
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
