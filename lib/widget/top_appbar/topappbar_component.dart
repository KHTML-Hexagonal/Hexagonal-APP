// ignore_for_file: prefer_typing_uninitialized_variables, use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:hexagonal_app/manage/constants/constants.dart';

class BackAppBar extends StatelessWidget implements PreferredSizeWidget {
  final state, thisBgColor;

  const BackAppBar({
    super.key,
    this.state,
    this.thisBgColor,
  });

  @override
  Size get preferredSize => const Size.fromHeight(56);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: thisBgColor ?? AppColors.white,
      leading: GestureDetector(
        behavior: HitTestBehavior.translucent,
        onTap: () {
          Navigator.pop(context, state);
        },
        child: AppIcon.back_arrow,
      ),
    );
  }
}

class BackTitleAppBar extends StatelessWidget implements PreferredSizeWidget {
  final thisTextStyle;
  final String text;
  final thisOnTap;
  final state;

  const BackTitleAppBar({
    super.key,
    this.thisTextStyle,
    required this.text,
    this.thisOnTap,
    this.state,
  });

  @override
  Size get preferredSize => const Size.fromHeight(56);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      centerTitle: false,
      leading: GestureDetector(
        behavior: HitTestBehavior.translucent,
        onTap: () {
          Navigator.pop(context, state);
        },
        child: AppIcon.back_arrow,
      ),
      title: Text(
        text,
        style: thisTextStyle,
      ),
    );
  }
}

class TitleAppBar extends StatelessWidget implements PreferredSizeWidget {
  final thisTextStyle;
  final String text;
  final thisOnTap;
  final state;

  const TitleAppBar({
    super.key,
    this.thisTextStyle,
    required this.text,
    this.thisOnTap,
    this.state,
  });

  @override
  Size get preferredSize => const Size.fromHeight(56);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      centerTitle: false,
      titleSpacing: 24,
      title: Text(
        text,
        style: thisTextStyle,
      ),
    );
  }
}
