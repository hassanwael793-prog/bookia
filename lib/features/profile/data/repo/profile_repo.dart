import 'package:bookia/core/networking/dio_factory.dart';
import 'package:bookia/features/profile/data/model/profile_model.dart';

class ProfileRepo {

  static getProfileData()async{

    try{
      final response=await DioFactory.dio?.get("profile");
      if(response?.statusCode==200) {
        ProfileResponse profileData=ProfileResponse.fromJson(response?.data);
        return profileData.data;
      }else{
    return null;

      }

    }catch(e){
      return null;
    }

  }
}