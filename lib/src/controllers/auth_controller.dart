import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:fluttertest/src/providers/service_provider.dart';

class AuthController {
  final ServiceProvider _serviceProvider = ServiceProvider();

  Future<bool> authLogin(
      String email, String password, BuildContext context) async {
    bool _access = false;
    try {
      Map<String, String> payload = {'email': email, 'password': password};

      final info = await _serviceProvider.authLogin(payload, '/login');
      _access = true;
    } catch (e) {
      print('Login Error:');
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
      return _access;
    }
  }

  Future<bool> authRegister(
      String email, String password, BuildContext context) async {
    bool _access = false;
    try {
      Map<String, String> payload = {
        'email': email,
        'password': password,
        'name': '',
        'last_name': ''
      };
      final info = await _serviceProvider.authLogin(payload, '/register');
      _access = true;
    } catch (e) {
      print('Register Error:');
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
      return _access;
    }
  }
}
