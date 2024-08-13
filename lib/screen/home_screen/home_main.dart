import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_naver_map/flutter_naver_map.dart';
import 'package:hexagonal_app/manage/constants/constants.dart';
import 'package:hexagonal_app/manage/data/yongin_cords.dart';

class HomeMain extends StatefulWidget {
  const HomeMain({super.key});

  @override
  State<HomeMain> createState() => _HomeMainState();
}

class _HomeMainState extends State<HomeMain> {
  final Completer<NaverMapController> mapControllerCompleter = Completer();

  // 외곽선을 그리기 위한 좌표 리스트 정의 (일반 리스트)
  final List<List<double>> coords = yonginCoords;
  List<YonginBuildingModel> yongingBuilding = [];
  int itemCount = 4;

  @override
  void initState() {
    super.initState();
    _loadAndAddOldBuilding();
    _addPolygonOverlay();
  }

  Future<void> _loadAndAddOldBuilding() async {
    // JSON 데이터를 불러와 yongingBuilding 변수에 할당
    yongingBuilding = await _loadOldBuildingData();
    // 데이터를 로드한 후, 마커를 지도에 추가
    _addOldBuilding();
  }

  void onMarkerTap(dynamic markerInfo) {
    print('Tapped marker ID 집: $markerInfo');
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
      color: AppColors.g80.withOpacity(0.2),
      outlineColor: Colors.transparent,
      outlineWidth: 3, // 외곽선 두께
    );

    mapController.addOverlay(polygonOverlay); // 오버레이 추가
  }

  Widget dangerListModal() {
    return DraggableScrollableSheet(
      snap: true,
      minChildSize: 0.35,
      maxChildSize: 0.9,
      initialChildSize: 0.35,
      builder: (BuildContext context, ScrollController scrollController) {
        return Container(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          height: MediaQuery.of(context).size.height * 0.9,
          width: MediaQuery.of(context).size.width,
          decoration: const BoxDecoration(
            color: AppColors.g00,
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20), topRight: Radius.circular(20)),
          ),
          child: Stack(
            children: [
              SingleChildScrollView(
                controller: scrollController,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Gaps.v44,
                    Text('추천 봉사 장소 ',
                        style:
                            AppTextStyles.st2.copyWith(color: AppColors.g80)),
                    Gaps.v8,
                    ...List.generate(
                      itemCount,
                      (index) => Column(
                        children: [
                          const RecommendServiceList(
                            thisUniqueBuildingId: '123123',
                          ),
                          if (index < itemCount - 1)
                            const CustomDivider(thisHeight: 1)
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              IgnorePointer(
                child: Container(
                  decoration: const BoxDecoration(
                    color: AppColors.g00,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(16),
                      topRight: Radius.circular(16),
                    ),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        margin: const EdgeInsets.symmetric(vertical: 16),
                        height: 4,
                        width: 32,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: AppColors.g20,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      behavior: HitTestBehavior.translucent,
      child: Scaffold(
        body: Stack(
          children: [
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.65,
              child: _buildNaverMap(),
            ),
            dangerListModal(),
          ],
        ),
      ),
    );
  }
}
