import 'dart:convert';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;

class NaverMapAPI {
  static Future<Map<String, double>> getLatLngFromAddress(
      String address) async {
    final String clientId = dotenv.env['NAVER_CLIENT_ID']!;
    final String clientSecret = dotenv.env['NAVER_CLIENT_SECRET']!;

    final uri = Uri.parse(
        'https://naveropenapi.apigw.ntruss.com/map-geocode/v2/geocode?query=${Uri.encodeComponent(address)}');

    final response = await http.get(
      uri,
      headers: {
        'X-NCP-APIGW-API-KEY-ID': clientId,
        'X-NCP-APIGW-API-KEY': clientSecret,
      },
    );

    if (response.statusCode == 200) {
      final json = jsonDecode(response.body);
      if (json['addresses'] != null && json['addresses'].isNotEmpty) {
        final lat = double.parse(json['addresses'][0]['y']);
        final lng = double.parse(json['addresses'][0]['x']);
        return {'latitude': lat, 'longitude': lng};
      } else {
        throw Exception('주소를 찾을 수 없습니다.');
      }
    } else {
      throw Exception('네이버 지도 API 요청에 실패했습니다. 상태 코드: ${response.statusCode}');
    }
  }

  static Future<String> getAddressFromLatLng(double lat, double lng) async {
    final String clientId = dotenv.env['NAVER_CLIENT_ID']!;
    final String clientSecret = dotenv.env['NAVER_CLIENT_SECRET']!;

    final uri = Uri.parse(
        'https://naveropenapi.apigw.ntruss.com/map-reversegeocode/v2/gc?coords=$lng,$lat&output=json&orders=addr');

    final response = await http.get(
      uri,
      headers: {
        'X-NCP-APIGW-API-KEY-ID': clientId,
        'X-NCP-APIGW-API-KEY': clientSecret,
      },
    );

    if (response.statusCode == 200) {
      final json = jsonDecode(response.body);
      if (json['results'] != null && json['results'].isNotEmpty) {
        final address = json['results'][0]['region']['area1']['name'] +
            ' ' +
            json['results'][0]['region']['area2']['name'] +
            ' ' +
            json['results'][0]['region']['area3']['name'] +
            ' ' +
            json['results'][0]['land']['number1'];
        return address;
      } else {
        throw Exception('No address found for given coordinates.');
      }
    } else {
      throw Exception(
          'Failed to fetch address from Naver API. Status code: ${response.statusCode}');
    }
  }
}
