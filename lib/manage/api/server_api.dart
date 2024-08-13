import 'dart:convert';
import 'package:hexagonal_app/manage/constants/constants.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_dotenv/flutter_dotenv.dart';

class ServerApi {
  static Future<Map<String, String>> getHeaders() async {
    String accessToken = dotenv.env['ACCESS_TOKEN']!;
    return {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $accessToken'
    };
  }

  static String baseUrl = 'http://52.231.105.228';

  // 건물주 등록 API
  static Future<BuildingRegistrationResponse> postOwnerHouse(
      String buildingId, List<http.MultipartFile> images) async {
    Map<String, String> headers = await getHeaders();

    final url = Uri.parse('$baseUrl/api/v1/buildings/$buildingId/register');

    var request = http.MultipartRequest('POST', url)
      ..headers.addAll(headers)
      ..files.addAll(images);

    print('요청 헤더: ${request.headers}, 요청 파일: ${request.files}');

    final streamedResponse = await request.send();
    final response = await http.Response.fromStream(streamedResponse);

    if (response.statusCode == 200) {
      final String responseBody = utf8.decode(response.bodyBytes); // UTF-8로 파싱
      final Map<String, dynamic> jsonResponse = jsonDecode(responseBody);
      return BuildingRegistrationResponse.fromJson(jsonResponse);
    } else {
      throw Exception('Failed to register building: ${response.statusCode}');
    }
  }

  // 추천 건물 데이터 가져오기
  static Future<List<RecommendBuildingModel>> getRecommendData() async {
    Map<String, String> headers = await getHeaders();

    final url = Uri.parse('$baseUrl/api/v1/buildings/recommend');
    final response = await http.get(url, headers: headers);
    print('응답: ${response.body}');

    if (response.statusCode == 200) {
      final String responseBody = utf8.decode(response.bodyBytes); // UTF-8로 파싱
      final Map<String, dynamic> jsonResponse = jsonDecode(responseBody);
      return RecommendBuildingResponse.fromJson(jsonResponse).data;
    } else {
      throw Exception(
          'Failed to load recommended buildings: ${response.statusCode}');
    }
  }

  // 건물 상세 정보 가져오기
  static Future<BuildingDetailModel> getBuildingDetail(
      String buildingNumber) async {
    Map<String, String> headers = await getHeaders();

    final url = Uri.parse('$baseUrl/api/v1/buildings/$buildingNumber');
    final response = await http.get(url, headers: headers);

    if (response.statusCode == 200) {
      final String responseBody = utf8.decode(response.bodyBytes);
      final Map<String, dynamic> jsonResponse = jsonDecode(responseBody);
      return BuildingDetailModel.fromJson(jsonResponse['data']);
    } else {
      throw Exception('Failed to load building detail: ${response.statusCode}');
    }
  }
}
