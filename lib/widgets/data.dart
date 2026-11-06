import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

List<Map<String, dynamic>> listOperations = [];

Future<void> saveMap(List<Map<String, dynamic>> list) async {
  final prefs = await SharedPreferences.getInstance();
///////////////////
  final data = list.map((op) {
    return {
      ...op,
      "date": (op["date"] as DateTime).toIso8601String(),
      "state": (op["state"] as Color).toARGB32(),
    };
  }).toList();
//////////////////
  await prefs.setString("user", jsonEncode(data));
}

Future<List<Map<String, dynamic>>> readMap() async {
  final prefs = await SharedPreferences.getInstance();
  final data = prefs.getString("user");

  if (data == null) return [];

  final list = List<Map<String, dynamic>>.from(jsonDecode(data));
//////////////////////
  return list.map((op) {
    return {
      ...op,
      "date": DateTime.parse(op["date"]),
      "state": Color(op["state"]),
    };
  }).toList();
  /////////////////
}

Future deleteList() async {
  final prefs = await SharedPreferences.getInstance();
  await prefs.remove("user");
}

bool isState(Map<String, dynamic> list, Color color) {
  Color operationColor = list["state"];

  return operationColor.toARGB32() == color.toARGB32();
}

num sum(List<Map<String, dynamic>> list, Color state) {
  num total = 0;

  for (var item in list) {
    if (isState(item, state)) {
      total += item["amount"] as num;
    }
  }

  return total;
}

/////////////////////////////////////////
bool theDarkMode = false;

Future<void> saveSwitches() async {
  final pref = await SharedPreferences.getInstance();
  await pref.setBool("darkMode", theDarkMode);
}

Future<bool> readSwitches() async {
  final pref = await SharedPreferences.getInstance();
  return pref.getBool("darkMode") ?? false;
}

Future<void> saveCurrency(String counts) async {
  final pref = await SharedPreferences.getInstance();
  await pref.setString("coin", counts);
}

Future<String?> readCurrency() async {
  final pref = await SharedPreferences.getInstance();

  return pref.getString("coin");
}
