import 'package:flutter/material.dart';

abstract final class SupportedBanks {
  static const List<Map<String, dynamic>> list = [
    {
      'id': 'mbbank',
      'name': 'MBBank',
      'short': 'MB',
      'color': Color(0xFF1E3A8A),
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
      'color': Color(0xFFDC2626),
      'appId': 'tcb',
      'scheme': 'tcb',
      'package': 'vn.com.techcombank.bb.app',
    },
    {
      'id': 'acb',
      'name': 'ACB',
      'short': 'ACB',
      'color': Color(0xFF2563EB),
      'appId': 'acb',
      'scheme': 'acbone',
      'package': 'mobile.acb.com.vn',
    },
    {
      'id': 'vpbank',
      'name': 'VPBank',
      'short': 'VPB',
      'color': Color(0xFF059669),
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
      'color': Color(0xFF0284C7),
      'appId': 'bidv',
      'scheme': 'bidv.smartbanking.partner',
      'package': 'com.vnpay.bidv',
    },
    {
      'id': 'agribank',
      'name': 'Agribank',
      'short': 'AGR',
      'color': Color(0xFFB45309),
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
