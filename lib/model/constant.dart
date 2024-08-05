import 'package:dio/dio.dart';

const baseUrl='https://habittracker.liara.run/';
final option =BaseOptions(
  baseUrl: baseUrl,
  connectTimeout: const Duration(seconds: 15),
  receiveTimeout: const Duration(seconds: 3),
  validateStatus: (status) => true,
  contentType: 'application/json'
);

final dio=Dio(option);