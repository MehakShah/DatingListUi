import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:task/models/userData.dart';

class UserProvider extends ChangeNotifier {
  List<UserData> users = [];
  final Dio _dio = Dio();

  Future<List<UserData>?> fetchDatingList(int results) async {
    try {
      final response =
          await _dio.get('https://randomuser.me/api/?results=$results');
      if (response.statusCode == 200) {
        var res = response.data['results'] as List;
        return res.map(
          (e) {
            return UserData.fromJson(e);
          },
        ).toList();
      } else {
        throw Exception('Failed to load data');
      }
    } on DioException catch (e) {
      throw Exception('API Error: ${e.message}');
    }
  }
}
