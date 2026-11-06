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
];
