import 'dart:convert';
import 'package:flutter/material.dart';
// ignore: depend_on_referenced_packages
import 'package:http/http.dart' as http;
import 'package:test/models/user_model.dart';
import 'package:test/varbles.dart';

class UserController {
  Future<UserModel> createUser(BuildContext context,
      {required String userPrefix,
      required String userFname,
      required String userLname,
      required String userName,
      required String password,
      required String role,
      required String userPhone,
      required String userEmail}) async {
    final Map<String, dynamic> userData = {
      'userPrefix': userPrefix,
      'userFname': userFname,
      'userLname': userLname,
      'userName': userName,
      'password': password,
      'role': role,
      'userPhone': userPhone,
      'userEmail': userEmail,
    };

    final response = await http.post(
      Uri.parse('$apiURL/api/admin/user/newuser'),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode(userData),
    );

    print('Response status: ${response.statusCode}');
    print('Response body: ${response.body}');

    if (response.statusCode == 201) {
      return UserModel.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('สร้างผู้ใช้ไม่สำเร็จ');
    }
  }

  // Other methods...

  Future<List<UserModel>> getUsers(BuildContext context) async {
    final response =
        await http.get(Uri.parse('$apiURL/api/admin/user/viewusers'));

    if (response.statusCode == 200) {
      List<dynamic> data = jsonDecode(response.body);
      return data.map((item) => UserModel.fromJson(item)).toList();
    } else {
      throw Exception('ไม่สามารถโหลดข้อมูลผู้ใช้ได้');
    }
  }

  Future<UserModel> getUser(BuildContext context, String userId) async {
    final response =
        await http.get(Uri.parse('$apiURL/api/admin/user/viewuser$userId'));

    if (response.statusCode == 200) {
      return UserModel.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('ไม่สามารถโหลดข้อมูลผู้ใช้ได้');
    }
  }

  Future<UserModel> updateUser(
      BuildContext context, String userId, UserModel user) async {
    final response = await http.put(
      Uri.parse('$apiURL/api/admin/user/$userId'),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode(user.toJson()),
    );

    if (response.statusCode == 200) {
      return UserModel.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('ไม่สามารถอัปเดตข้อมูลผู้ใช้ได้');
    }
  }

  Future<void> deleteUser(BuildContext context, String userId) async {
    final response =
        await http.delete(Uri.parse('$apiURL/api/admin/user/$userId'));

    if (response.statusCode == 200) {
      return;
    } else {
      throw Exception('ไม่สามารถลบผู้ใช้ได้');
    }
  }
}
