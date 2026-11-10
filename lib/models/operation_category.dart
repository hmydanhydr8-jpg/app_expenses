import 'package:flutter/material.dart';

class OperationCategory {
  final String text;
  final IconData icon;
  final Color color;
  final int id;

  const OperationCategory({
    required this.text,
    required this.icon,
    required this.color,
    required this.id,
  });
}

const List<OperationCategory> categories = [
  // الأنواع الحالية
  OperationCategory(
    id: 0,
    text: 'طعام',
    icon: Icons.restaurant_rounded,
    color: Color(0xFFE53935),
  ),
  OperationCategory(
    id: 1,
    text: 'مواصلات',
    icon: Icons.directions_bus_rounded,
    color: Color(0xFF1E88E5),
  ),
  OperationCategory(
    id: 2,
    text: 'راتب',
    icon: Icons.account_balance_wallet_outlined,
    color: Color(0xFF2E9560),
  ),
  OperationCategory(
    id: 3,
    text: 'تسوق',
    icon: Icons.shopping_bag_outlined,
    color: Color(0xFF8E24AA),
  ),
  OperationCategory(
    id: 4,
    text: 'فواتير',
    icon: Icons.lightbulb_outline_rounded,
    color: Color(0xFFF9A825),
  ),
  OperationCategory(
    id: 5,
    text: 'هاتف',
    icon: Icons.smartphone_rounded,
    color: Color(0xFF1976D2),
  ),

  // مصاريف إضافية
  OperationCategory(
    id: 6,
    text: 'صحة',
    icon: Icons.medical_services_outlined,
    color: Color(0xFFE91E63),
  ),
  OperationCategory(
    id: 7,
    text: 'إيجار',
    icon: Icons.home_outlined,
    color: Color(0xFF795548),
  ),
  OperationCategory(
    id: 8,
    text: 'تعليم',
    icon: Icons.school_outlined,
    color: Color(0xFF5C6BC0),
  ),
  OperationCategory(
    id: 9,
    text: 'ترفيه',
    icon: Icons.sports_esports_outlined,
    color: Color(0xFF00ACC1),
  ),
  OperationCategory(
    id: 10,
    text: 'اشتراكات',
    icon: Icons.subscriptions_outlined,
    color: Color(0xFF7E57C2),
  ),

  // أنواع دخل إضافية
  OperationCategory(
    id: 11,
    text: 'عمل حر',
    icon: Icons.laptop_mac_outlined,
    color: Color(0xFF00897B),
  ),
  OperationCategory(
    id: 12,
    text: 'هدايا',
    icon: Icons.card_giftcard_rounded,
    color: Color(0xFFFF7043),
  ),
  OperationCategory(
    id: 13,
    text: 'دخل آخر',
    icon: Icons.attach_money_rounded,
    color: Color(0xFF43A047),
  ),
  OperationCategory(
    id: 14,
    text: 'مصروف آخر',
    icon: Icons.more_horiz_rounded,
    color: Color(0xFF607D8B),
  ),
];
