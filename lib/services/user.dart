import 'package:flutter/material.dart';
import 'package:gym_app/models/user.dart';
import 'package:gym_app/utils/http_client.dart';

class UserService {
  static ValueNotifier<List<User>> usersList = ValueNotifier([]);
// گرفتن کاربران
  static Future<List<User>> getUsers() async {
    var response = await httpClinet.get("nA99OP/gym");
    if (response.statusCode == 201 || response.statusCode == 200) {
      usersList.value = [];
      for (var element in response.data) {
        usersList.value.add(User.fromJson(element));
      }
      return usersList.value;
    }
    throw Exception("Eroor");
  }

// گرفتن کاربران براساس نام و نام خانوادگی
  static Future<List<User>> getUsersByFullName(String fullName) async {
    var response = await httpClinet.get("nA99OP/gym?FullName=$fullName");
    if (response.statusCode == 201 || response.statusCode == 200) {
      usersList.value = [];
      for (var element in response.data) {
        usersList.value.add(User.fromJson(element));
      }
      return usersList.value;
    }
    throw Exception("Eroor");
  }

// اضافه کردن کاربر
  static Future<User> addUser(User user) async {
    var response = await httpClinet.post("nA99OP/gym", data: user.toJson());
    if (response.statusCode == 201 || response.statusCode == 200) {
      await getUsers();
      return User.fromJson(response.data);
    }
    throw Exception("Eroor");
  }

// ویرایش کاربر
  static Future<User> updateUser(
      {required User user, required int userId}) async {
    var response =
        await httpClinet.put("nA99OP/gym/$userId", data: user.toJson());
    if (response.statusCode == 201 || response.statusCode == 200) {
      await getUsers();
      return User.fromJson(response.data);
    }
    throw Exception("Eroor");
  }

// حذف کاربر
  static Future<User> deleteUser(int userId) async {
    var response = await httpClinet.delete("nA99OP/gym/$userId");
    if (response.statusCode == 201 || response.statusCode == 200) {
      await getUsers();
      return User.fromJson(response.data);
    }
    throw Exception("Eroor");
  }
}
