// ignore_for_file: non_constant_identifier_names

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class AppIcon {
  static Widget get grey_pin =>
      SvgPicture.asset('assets/icon/grey_pin.svg', fit: BoxFit.scaleDown);
  static Widget get back_arrow =>
      SvgPicture.asset('assets/icon/back_arrow.svg', fit: BoxFit.scaleDown);

  // 새로운 phone 이미지 추가
  static Widget get phone =>
      Image.asset('assets/images/phone.png', fit: BoxFit.scaleDown);
  static Widget get notice =>
      Image.asset('assets/images/notice.png', fit: BoxFit.scaleDown);

//숫자 이미지_Grey
  static Widget get g_num_0 =>
      Image.asset('assets/images/num/0.png', fit: BoxFit.scaleDown);
  static Widget get g_num_1 =>
      Image.asset('assets/images/num/1.png', fit: BoxFit.scaleDown);
  static Widget get g_num_2 =>
      Image.asset('assets/images/num/2.png', fit: BoxFit.scaleDown);
  static Widget get g_num_3 =>
      Image.asset('assets/images/num/3.png', fit: BoxFit.scaleDown);
  static Widget get g_num_4 =>
      Image.asset('assets/images/num/4.png', fit: BoxFit.scaleDown);
  static Widget get g_num_5 =>
      Image.asset('assets/images/num/5.png', fit: BoxFit.scaleDown);
  static Widget get g_num_6 =>
      Image.asset('assets/images/num/6.png', fit: BoxFit.scaleDown);
  static Widget get g_num_7 =>
      Image.asset('assets/images/num/7.png', fit: BoxFit.scaleDown);
  static Widget get g_num_8 =>
      Image.asset('assets/images/num/8.png', fit: BoxFit.scaleDown);
  static Widget get g_num_9 =>
      Image.asset('assets/images/num/9.png', fit: BoxFit.scaleDown);

  //숫자 이미지_Orange
  static Widget get o_num_0 =>
      Image.asset('assets/images/num_orange/0.png', fit: BoxFit.scaleDown);
  static Widget get o_num_1 =>
      Image.asset('assets/images/num_orange/1.png', fit: BoxFit.scaleDown);
  static Widget get o_num_2 =>
      Image.asset('assets/images/num_orange/2.png', fit: BoxFit.scaleDown);
  static Widget get o_num_3 =>
      Image.asset('assets/images/num_orange/3.png', fit: BoxFit.scaleDown);
  static Widget get o_num_4 =>
      Image.asset('assets/images/num_orange/4.png', fit: BoxFit.scaleDown);
  static Widget get o_num_5 =>
      Image.asset('assets/images/num_orange/5.png', fit: BoxFit.scaleDown);
  static Widget get o_num_6 =>
      Image.asset('assets/images/num_orange/6.png', fit: BoxFit.scaleDown);
  static Widget get o_num_7 =>
      Image.asset('assets/images/num_orange/7.png', fit: BoxFit.scaleDown);
  static Widget get o_num_8 =>
      Image.asset('assets/images/num_orange/8.png', fit: BoxFit.scaleDown);
  static Widget get o_num_9 =>
      Image.asset('assets/images/num_orange/9.png', fit: BoxFit.scaleDown);
}
