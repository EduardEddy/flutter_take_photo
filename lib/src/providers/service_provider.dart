import 'package:dio/dio.dart';
import 'package:fluttertest/src/models/posts.dart';
import 'package:fluttertest/src/utils/constans.dart';

class ServiceProvider {
  final Dio _dio = Dio();

  Future authLogin(Map<String, String> payload, String endPoint) async {
    final response =
        await _dio.post('${Constans.API_AUTH}$endPoint', data: payload);
    return response;
  }

  Future authRegister(Map<String, String> payload, String endPoint) async {
    final response = await _dio
        .post('https://dev-fabume.herokuapp.com/api/managers', data: payload);
    return response;
  }

  Future posts() async {
    final response = await _dio.get(Constans.API_LIST);
    List<Posts> list =
        (response.data as List).map((e) => Posts.fromJson(e)).toList();

    return list;
  }

  Future postsById(int id) async {
    final response = await _dio.get("${Constans.API_LIST}/$id");
    Posts data = Posts(
        userId: response.data['userId'],
        id: response.data['id'],
        title: response.data['title'],
        body: response.data['body']);
    return data;
  }
}
