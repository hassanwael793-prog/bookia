import '../../../../core/networking/dio_factory.dart';
import '../model/book_details_model.dart';

class BookDetailsRepo {

  static GetBookDetails(int id)async{
    try {
      final response = await DioFactory.dio?.get("products/$id");
      if (response?.statusCode == 200 || response?.statusCode == 201) {
        BookDetailsModel details = BookDetailsModel.fromJson(response?.data);
        return details;
      }else{
        return null;
      }

    }
    catch(e){
        return null;
    }
  }


}