import 'package:dio/dio.dart';

final Dio httpClinet = Dio(
  BaseOptions(
    baseUrl: "https://retoolapi.dev/",
  ),
);
