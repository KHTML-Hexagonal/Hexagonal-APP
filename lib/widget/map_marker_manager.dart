import 'package:flutter/material.dart';
import 'package:flutter_naver_map/flutter_naver_map.dart';
import 'package:hexagonal_app/manage/constants/constants.dart';

class MapMarkerManager {
  final BuildContext context;
  final NaverMapController naverMapController;
  final Function(String) onMarkerTap;

  MapMarkerManager(this.context, this.naverMapController, this.onMarkerTap);

  Future<void> addMarkersToMapForObject(
      List<YonginBuildingModel> objectList) async {
    for (var place in objectList) {
      const NOverlayImage objectMarker =
          NOverlayImage.fromAssetImage('assets/images/grey_pin.png');
      final marker = NMarker(
        id: place.gisBuildingId!,
        position: NLatLng(place.latitude!, place.longitude!),
        icon: objectMarker,
      );

      marker.setOnTapListener((NMarker marker) {
        onMarkerTap('${marker.info.id}, ${marker.position}');
      });

      naverMapController.addOverlay(marker);
    }
  }

  Future<void> addMarkersToMapForPlace(
      List<YonginBuildingModel> placeList) async {
    for (var place in placeList) {
      final NOverlayImage placeMarker = await NOverlayImage.fromWidget(
        widget: AppIcon.grey_pin,
        size: const Size(24, 24),
        context: context,
      );

      final marker = NMarker(
        id: place.gisBuildingId!,
        position: NLatLng(place.latitude!, place.longitude!),
        icon: placeMarker,
      );

      marker.setOnTapListener((NMarker marker) {
        print('Tapped marker ID: ${marker.info.id}');
      });

      naverMapController.addOverlay(marker);
    }
  }
}
