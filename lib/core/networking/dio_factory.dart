import 'package:bookia/core/services/locale/locale_helper.dart';
import 'package:bookia/core/utils/app_const/app_Const.dart';
import 'package:dio/dio.dart';

class DioFactory {
 static Dio? dio;
 static init(){
   dio=Dio(
     BaseOptions(
       baseUrl:"https://codingarabic.eraapro.com/api/",
       headers:{
         "Accept":"application/json",
         "Content-Type":"application/json",
         "Authorization":"Bearer ${LocaleHelper.prefs?.get(AppConst.userToken)}"
       }
     )
   );
 }

}
