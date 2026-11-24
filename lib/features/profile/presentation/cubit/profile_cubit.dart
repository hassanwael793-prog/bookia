import 'package:bloc/bloc.dart';
import 'package:bookia/features/profile/data/repo/profile_repo.dart';
import 'package:meta/meta.dart';
import '../../data/model/profile_model.dart'; // 👈 ضيف السطر ده هنا
part 'profile_state.dart';

class ProfileCubit extends Cubit<ProfileState> {
  ProfileCubit() : super(ProfileInitial());
  GetProfileData()async{
  emit(GetProfileLoading()) ;
    final response=await ProfileRepo.getProfileData();
    if(response is Data){
      emit(GetProfileSuccess(response));
    }else{
      emit(GetProfileError());
    }
}


}
