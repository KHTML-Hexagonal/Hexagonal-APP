import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_naver_map/flutter_naver_map.dart';
import 'package:hexagonal_app/manage/constants/constants.dart';
import '../../manage/data/yongin_cords.dart';

class MaterialReg2 extends StatefulWidget {
  final VoidCallback onNavigateForward;
  final Function(Map<String, dynamic>) saveLocation;

  const MaterialReg2({
    super.key,
    required this.onNavigateForward,
    required this.saveLocation,
  });

  @override
  State<MaterialReg2> createState() => _MaterialReg2State();
}

class _MaterialReg2State extends State<MaterialReg2> {
  final Completer<NaverMapController> mapControllerCompleter = Completer();
  Future<NOverlayImage>? overlayImageFuture; // 미리 생성할 마커 이미지
  Map<String, double> tappedLocation = {};
  NMarker? currentMarker; // 현재 표시된 마커를 저장할 변수
  String addressText = '';

  final List<List<double>> coords = yonginCoords;
  List<YonginBuildingModel> yongingBuilding = [];

  @override
  void initState() {
    super.initState();
    _addPolygonOverlay();
    overlayImageFuture = _createOverlayImage(); // 마커 이미지를 미리 생성
  }

  @override
  void didChangeDependencies() {
    overlayImageFuture = _createOverlayImage(); // 마커 이미지를 미리 생성
    super.didChangeDependencies();
  }

  Future<NOverlayImage> _createOverlayImage() async {
    return const NOverlayImage.fromAssetImage('assets/images/location.png');
  }

  Widget _buildNaverMap() {
    return NaverMap(
      options: const NaverMapViewOptions(
        liteModeEnable: true,
        indoorEnable: true,
        locationButtonEnable: false,
        consumeSymbolTapEvents: true,
        logoMargin: EdgeInsets.only(bottom: 50, left: 24),
        logoAlign: NLogoAlign.leftBottom,
        logoClickEnable: false,
        initialCameraPosition: NCameraPosition(
          target: NLatLng(37.2412522, 127.1774916),
          zoom: 12,
        ),
        extent: NLatLngBounds(
          southWest: NLatLng(37.0803988, 127.034457),
          northEast: NLatLng(37.3849469, 127.4282161),
        ),
      ),
      onMapReady: (naverMapController) {
        mapControllerCompleter.complete(naverMapController);
      },
      onMapTapped: (point, latLng) {
        print('Map tapped: $latLng');
        tapLocation(longitude: latLng.longitude, latitude: latLng.latitude);
      },
    );
  }

  Future<void> tapLocation(
      {required double longitude, required double latitude}) async {
    setState(() {
      tappedLocation = {'longitude': longitude, 'latitude': latitude};
    });

    final controller = await mapControllerCompleter.future;
    final overlayImage = await overlayImageFuture!; // 미리 생성한 마커 이미지 사용

    final marker = NMarker(
      id: 'selected_location',
      position: NLatLng(latitude, longitude),
      icon: overlayImage,
    );

    controller.addOverlay(marker);
    setState(() {
      currentMarker = marker;
    });

    // 네이버 API로부터 주소를 가져옵니다
    try {
      final address =
          await NaverMapAPI.getAddressFromLatLng(latitude, longitude);
      setState(() {
        addressText = address; // 주소 상태 업데이트
      });
    } catch (e) {
      print('주소를 가져오는데 실패했습니다: $e');
    }
  }

  Future<void> _addPolygonOverlay() async {
    final mapController = await mapControllerCompleter.future;

    List<NLatLng> outerCoords = [
      const NLatLng(38.000000, 126.5000000), // top-left
      const NLatLng(38.000000, 128.0000000), // top-right
      const NLatLng(36.0000000, 128.0000000), // bottom-right
      const NLatLng(36.0000000, 126.5000000), // bottom-left
      const NLatLng(38.00000, 126.5000000), // close the loop
    ];

    List<NLatLng> holeCoords =
        coords.map((coord) => NLatLng(coord[1], coord[0])).toList();

    final polygonOverlay = NPolygonOverlay(
      id: 'maskOverlay',
      coords: outerCoords,
      holes: [holeCoords],
      color: AppColors.g80.withOpacity(0.2),
      outlineColor: Colors.transparent,
      outlineWidth: 3,
    );

    mapController.addOverlay(polygonOverlay);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: BackTitleAppBar(
        text: '건축 자재 정보 등록',
        thisTextStyle: AppTextStyles.st2.copyWith(color: AppColors.g6),
      ),
      body: Stack(
        children: [
          SizedBox(child: _buildNaverMap()),
          Positioned(
              child: Container(
                  height: 46,
                  width: MediaQuery.of(context).size.width,
                  color: AppColors.black.withOpacity(0.5),
                  alignment: Alignment.center,
                  child: Text(
                    '지도를 움직여 위치를 지정하세요',
                    style: AppTextStyles.bd3.copyWith(color: AppColors.g00),
                  ))),
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Container(
              padding: const EdgeInsets.fromLTRB(24, 24, 24, 28),
              width: MediaQuery.of(context).size.width,
              decoration: const BoxDecoration(
                color: AppColors.g00,
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(20),
                    topRight: Radius.circular(20)),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('해당 주소가 맞나요?',
                      style: AppTextStyles.bd4.copyWith(color: AppColors.g60)),
                  Gaps.v2,
                  Text(addressText,
                      style: AppTextStyles.bd1.copyWith(color: AppColors.g80)),
                  Gaps.v20,
                  Container(
                    height: 48,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: addressText.isNotEmpty
                          ? AppColors.or40
                          : AppColors.g30,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: TextButton(
                      onPressed: () {
                        if (addressText.isNotEmpty) {
                          print('보낼 데이터: , $addressText');
                          widget.saveLocation({
                            'address': addressText,
                            'longitude': tappedLocation['longitude'], // 경도 전달
                            'latitude': tappedLocation['latitude'], // 위도 전달
                          });
                          widget.onNavigateForward();
                        }
                      },
                      child: Text('네, 다음으로',
                          style:
                              AppTextStyles.bd3.copyWith(color: AppColors.g00)),
                    ),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
