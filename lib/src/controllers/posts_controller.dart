import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:fluttertest/src/models/posts.dart';
import 'package:fluttertest/src/providers/service_provider.dart';

class PostsController {
  final ServiceProvider _serviceProvider = ServiceProvider();

  Future<List> getPosts(BuildContext context) async {
    List<Posts> data = [];
    try {
      data = await _serviceProvider.posts();
    } catch (e) {
      print('List Posts Error:');
      print(e);
      String? message = '';

      if (e is DioError) {
        if (e.response != null) {
          message = e.response!.statusMessage == 'Unauthorized'
              ? 'Credenciales invalidas'
              : e.response!.statusMessage;
        } else {
          message = e.message;
        }
      }
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('$message'),
        duration: const Duration(milliseconds: 1500),
      ));
    } finally {
      return data;
    }
  }

  Future<Posts> postsById(int id) async {
    Posts data = await _serviceProvider.postsById(id);
    return data;
  }
}
