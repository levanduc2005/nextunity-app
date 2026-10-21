import 'package:flutter/material.dart';

abstract final class SupportedBanks {
  static const List<Map<String, dynamic>> list = [
    {
      'id': 'mbbank',
      'name': 'MBBank',
      'short': 'MB',
      'color': Color(0xFF1E3A8A),
    },
    {
      'id': 'vietcombank',
      'name': 'Vietcombank',
      'short': 'VCB',
      'color': Color(0xFF047857),
    },
    {
      'id': 'techcombank',
      'name': 'Techcombank',
      'short': 'TCB',
      'color': Color(0xFFDC2626),
    },
    {
      'id': 'acb',
      'name': 'ACB',
      'short': 'ACB',
      'color': Color(0xFF2563EB),
    },
    {
      'id': 'vpbank',
      'name': 'VPBank',
      'short': 'VPB',
      'color': Color(0xFF059669),
    },
    {
      'id': 'tpbank',
      'name': 'TPBank',
      'short': 'TPB',
      'color': Color(0xFF7C3AED),
    },
    {
      'id': 'bidv',
      'name': 'BIDV',
      'short': 'BIDV',
      'color': Color(0xFF0284C7),
    },
    {
      'id': 'agribank',
      'name': 'Agribank',
      'short': 'AGR',
      'color': Color(0xFFB45309),
    },
  ];
}
