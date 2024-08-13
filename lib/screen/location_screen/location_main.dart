// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:hexagonal_app/manage/constants/constants.dart';
import 'package:hexagonal_app/screen/location_screen/location_body_1.dart';
import 'package:hexagonal_app/screen/location_screen/location_body_2.dart';

class LocationMain extends StatefulWidget {
  const LocationMain({super.key});

  @override
  _LocationMainState createState() => _LocationMainState();
}

class _LocationMainState extends State<LocationMain>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this); // 2개의 탭
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 52,
        centerTitle: false,
        titleSpacing: 24,
        title: Text('러셔들의 발자취',
            style: AppTextStyles.st2.copyWith(color: AppColors.g6)),
        bottom: TabBar(
          controller: _tabController,
          tabs: const [
            Tab(text: '둘러보기'),
            Tab(text: '내 지역 변화도'),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: const [
          LocationBody1(),
          LocationBody2(),
        ],
      ),
    );
  }
}
