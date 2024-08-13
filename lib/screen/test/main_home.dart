import 'package:flutter/material.dart';
import 'package:hexagonal_app/manage/constants/constants.dart';

class SearchHome extends StatefulWidget {
  const SearchHome({super.key});

  @override
  SearchHomeState createState() => SearchHomeState();
}

class SearchHomeState extends State<SearchHome> {
  final TextEditingController _controller = TextEditingController();
  String _result = '';

  void _searchAddress() async {
    final address = _controller.text;
    if (address.isNotEmpty) {
      try {
        final latLng = await NaverMapAPI.getLatLngFromAddress(address);
        setState(() {
          _result = '위도: ${latLng['latitude']}, 경도: ${latLng['longitude']}';
        });
      } catch (e) {
        setState(() {
          _result = '오류 발생: $e';
        });
      }
    } else {
      setState(() {
        _result = '주소를 입력하세요.';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('주소 검색'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              controller: _controller,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: '주소를 입력하세요',
              ),
            ),
            const SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: _searchAddress,
              child: const Text('검색'),
            ),
            const SizedBox(height: 16.0),
            Text(
              _result,
              style: const TextStyle(fontSize: 16.0),
            ),
          ],
        ),
      ),
    );
  }
}
