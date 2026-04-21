import 'dart:convert';
import 'package:flutter/services.dart';

class SchoolService {
  static List<String>? _cachedSchools;

  Future<List<String>> loadSchools() async {
    if (_cachedSchools != null) {
      return _cachedSchools!;
    }

    try {
      final String response = await rootBundle.loadString('assets/data/schools.json');
      final List<dynamic> data = json.decode(response);

      _cachedSchools = data.map((e) => e['name'].toString()).toList();
      return _cachedSchools!;
    } catch (e) {
      print("Error: Can't load school of data");
      return [];
    }
  }


}