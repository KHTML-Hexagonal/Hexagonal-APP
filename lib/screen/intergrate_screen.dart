// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:hexagonal_app/manage/constants/constants.dart';
import 'package:hexagonal_app/manage/constants/screen_manage.dart';

enum SwitchIndex {
  none,
  toZero,
  toOne,
  toTwo,
  toThree,
}

class IntergrateScreen extends StatefulWidget {
  final SwitchIndex switchIndex;

  const IntergrateScreen({
    super.key,
    this.switchIndex = SwitchIndex.none,
  });

  // 외부에서 접근 가능한 함수를 정의_교외지원사업 탭
  static void setSelectedIndexToZero(BuildContext context) {
    final state = context.findAncestorStateOfType<_IntergrateScreenState>();
    state?.setSelectedIndexToZero();
  }

  // 외부에서 접근 가능한 함수를 정의_교내지원사업 탭
  static void setSelectedIndexToOne(BuildContext context) {
    final state = context.findAncestorStateOfType<_IntergrateScreenState>();
    state?.setSelectedIndexToOne();
  }

  @override
  State<IntergrateScreen> createState() => _IntergrateScreenState();
}

class _IntergrateScreenState extends State<IntergrateScreen> {
  int _selectedIndex = 1;

  @override
  void initState() {
    super.initState();

    switch (widget.switchIndex) {
      case SwitchIndex.none:
        // 초기 설정이 필요 없는 경우
        break;
      case SwitchIndex.toZero:
        _selectedIndex = 0;
        break;
      case SwitchIndex.toOne:
        _selectedIndex = 1;
        break;
      case SwitchIndex.toTwo:
        _selectedIndex = 2;
        break;
      case SwitchIndex.toThree:
        _selectedIndex = 3;
        break;
    }
  }

  void _onTap(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  void setSelectedIndexToZero() {
    setState(() {
      _selectedIndex = 0;
    });
  }

  void setSelectedIndexToOne() {
    setState(() {
      _selectedIndex = 1;
    });
  }

  Widget _getCurrentScreen() {
    switch (_selectedIndex) {
      case 0:
        return const HomeMain();
      case 1:
        return const LocationMain();

      case 2:
        return const MaterialMain();
      case 3:
        return const MypageMain();
      case 4:
      default:
        return const HomeMain();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _getCurrentScreen(),
      bottomNavigationBar: BottomAppBar(
        height: 56,
        elevation: 0,
        child: Column(
          children: [
            Gaps.v8,
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // 각 탭 구성
                GnbTap(
                  text: '홈',
                  isSelected: _selectedIndex == 0,
                  onTap: () => _onTap(0),
                  selectedIndex: _selectedIndex,
                  selecetedIcon: AppIcon.home_active,
                  unselecetedIcon: AppIcon.home_inactive,
                ),
                GnbTap(
                  text: '내 지역',
                  isSelected: _selectedIndex == 1,
                  onTap: () => _onTap(1),
                  selectedIndex: _selectedIndex,
                  selecetedIcon: AppIcon.location_active,
                  unselecetedIcon: AppIcon.location_inactive,
                ),
                GnbTap(
                  text: '건축 자제',
                  isSelected: _selectedIndex == 2,
                  onTap: () => _onTap(2),
                  selectedIndex: _selectedIndex,
                  selecetedIcon: AppIcon.inter_active,
                  unselecetedIcon: AppIcon.inter_inactive,
                ),
                GnbTap(
                  text: '마이페이지',
                  isSelected: _selectedIndex == 3,
                  onTap: () => _onTap(3),
                  selectedIndex: _selectedIndex,
                  selecetedIcon: AppIcon.my_active,
                  unselecetedIcon: AppIcon.my_inactive,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
