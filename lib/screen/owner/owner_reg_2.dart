import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_naver_map/flutter_naver_map.dart';
import 'package:hexagonal_app/manage/constants/constants.dart';
import '../../manage/data/yongin_cords.dart';

class OwnerReg2 extends StatefulWidget {
  final VoidCallback onNavigateForward;
  final Function(Map<String, dynamic>) saveUniqueIdandLocation;

  const OwnerReg2({
    super.key,
    required this.onNavigateForward,
    required this.saveUniqueIdandLocation,
  });

  @override
  State<OwnerReg2> createState() => _OwnerReg2State();
}

class _OwnerReg2State extends State<OwnerReg2> {
  final Completer<NaverMapController> mapControllerCompleter = Completer();
  String addressText = '';

  final List<List<double>> coords = yonginCoords;
  List<YonginBuildingModel> yongingBuilding = [];

  //좌표, 주소저장 변수
  String uniqueId = '';
  int let = 0;
  int lon = 0;

  @override
  void initState() {
    super.initState();
    _loadAndAddOldBuilding();
    _addPolygonOverlay();
  }

  Future<void> _loadAndAddOldBuilding() async {
    yongingBuilding = await _loadOldBuildingData();
    _addOldBuilding();
  }

  Future<void> _addOldBuilding() async {
    final mapController = await mapControllerCompleter.future;
    final markerManager = MapMarkerManager(context, mapController, onMarkerTap);
    await markerManager.addMarkersToMapForObject(yongingBuilding);
  }

  Future<List<YonginBuildingModel>> _loadOldBuildingData() async {
    final String jsonString =
        await rootBundle.loadString('lib/manage/data/old_building.json');
    final List<dynamic> jsonResponse = json.decode(jsonString);

    return jsonResponse
        .map((data) => YonginBuildingModel.fromJson(data))
        .toList();
  }

  // Marker가 탭되었을 때 호출되는 콜백 함수
  void onMarkerTap(String markerInfo) {
    try {
      String uniqueId = markerInfo.split(',')[0];
      String latLngString = markerInfo.substring(
          markerInfo.indexOf('{') + 1, markerInfo.indexOf('}'));
      double lat =
          double.parse(latLngString.split('lat: ')[1].split(',')[0].trim());
      double lng = double.parse(latLngString.split('lng: ')[1].trim());

      setState(() {
        this.uniqueId = uniqueId.trim();
        let = lat.toInt();
        lon = lng.toInt();
      });

      // 주소 가져오기
      NaverMapAPI.getAddressFromLatLng(lat, lng).then((address) {
        setState(() {
          addressText = address; // 상태 업데이트로 화면에 주소 표시
        });
      }).catchError((error) {
        print('Error fetching address: $error');
      });
    } catch (e) {
      print('Error parsing markerInfo: $e');
    }
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
    );
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
      appBar: const BackAppBar(),
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
                    '지도를 움직여 위치를 지정할 수 있습니다',
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
                      color: uniqueId.isNotEmpty && addressText.isNotEmpty
                          ? AppColors.or40
                          : AppColors.g30,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: TextButton(
                      onPressed: () {
                        if (uniqueId.isNotEmpty && addressText.isNotEmpty) {
                          print('보낼 데이터: $uniqueId, $addressText');
                          widget.saveUniqueIdandLocation({
                            'uniqueId': uniqueId,
                            'address': addressText,
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
