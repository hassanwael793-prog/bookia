import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

import '../../../../core/networking/dio_factory.dart';
import '../../../../core/services/locale/locale_helper.dart';
import '../../../../core/utils/app_const/app_Const.dart';

class AuthRepo {
  Future<bool> login({required String email, required String password}) async {
    try {
      final response = await DioFactory.dio?.post(
        "login",
        data: {"email": email, "password": password},
      );

      if (response?.statusCode == 200 || response?.statusCode == 201) {
        String? token = response?.data["data"]?["token"];

          await saveToken(token);
          return true;


      }
      return false;
    } catch (e) {
      return false;
    }
  }

  Future<void> saveToken(String? token) async {
    await LocaleHelper.prefs?.setString(AppConst.userToken, token ?? "");
  }
}
