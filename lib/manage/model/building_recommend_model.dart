import 'package:html/parser.dart';

class RecommendBuildingModel {
  final String buildingId;
  final String imageUrl;
  final String address;
  final String repairList;

  static String decodeHtmlEntities(String htmlString) {
    // HTML 문자열을 파싱하여 디코딩된 텍스트로 반환
    var document = parse(htmlString);
    return document.body != null ? document.body!.text : htmlString;
  }

  RecommendBuildingModel.fromJson(Map<String, dynamic> json)
      : buildingId = json['buildingId'] ?? '',
        imageUrl = json['imageUrl'] ?? '',
        address = json['address'] ?? '',
        repairList = decodeHtmlEntities(json['repairList'] ?? '');
}

class RecommendBuildingResponse {
  final List<RecommendBuildingModel> data;

  RecommendBuildingResponse.fromJson(Map<String, dynamic> json)
      : data = (json['data'] as List)
            .map((item) => RecommendBuildingModel.fromJson(item))
            .toList();
}
