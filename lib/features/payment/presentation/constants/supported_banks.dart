import 'package:flutter/material.dart';

import 'package:rental_car/core/theme/app_colors.dart';
abstract final class SupportedBanks {
  static const List<Map<String, dynamic>> list = [
    {
      'id': 'mbbank',
      'name': 'MBBank',
      'short': 'MB',
      'color': AppColors.primaryDark,
      'appId': 'mb',
      'scheme': 'mbbank',
      'package': 'com.mbmobile',
    },
    {
      'id': 'vietcombank',
      'name': 'Vietcombank',
      'short': 'VCB',
      'color': Color(0xFF047857),
      'appId': 'vcb',
      'scheme': 'vietcombankmobile',
      'package': 'com.VCB',
    },
    {
      'id': 'techcombank',
      'name': 'Techcombank',
      'short': 'TCB',
      'color': AppColors.errorForeground,
      'appId': 'tcb',
      'scheme': 'tcb',
      'package': 'vn.com.techcombank.bb.app',
    },
    {
      'id': 'acb',
      'name': 'ACB',
      'short': 'ACB',
      'color': AppColors.primaryAction,
      'appId': 'acb',
      'scheme': 'acbone',
      'package': 'mobile.acb.com.vn',
    },
    {
      'id': 'vpbank',
      'name': 'VPBank',
      'short': 'VPB',
      'color': AppColors.successDark,
      'appId': 'vpb',
      'scheme': 'vpbankneo',
      'package': 'com.vnpay.vpbankonline',
    },
    {
      'id': 'tpbank',
      'name': 'TPBank',
      'short': 'TPB',
      'color': Color(0xFF7C3AED),
      'appId': 'tpb',
      'scheme': 'hydro',
      'package': 'com.tpb.mb.gprsandroid',
    },
    {
      'id': 'bidv',
      'name': 'BIDV',
      'short': 'BIDV',
      'color': AppColors.accentDark,
      'appId': 'bidv',
      'scheme': 'bidv.smartbanking.partner',
      'package': 'com.vnpay.bidv',
    },
    {
      'id': 'agribank',
      'name': 'Agribank',
      'short': 'AGR',
      'color': AppColors.warningDark,
      'appId': 'vba',
      'scheme': 'agribankmobile',
      'package': 'com.vnpay.Agribank3g',
    },
  ];

  static Map<String, dynamic>? findById(String id) {
    for (final bank in list) {
      if (bank['id'] == id) return bank;
    }
    return null;
  }
}
