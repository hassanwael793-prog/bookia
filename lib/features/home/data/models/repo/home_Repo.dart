import 'package:bookia/core/networking/dio_factory.dart';
import 'package:bookia/features/home/data/models/books_model.dart';
import 'package:dio/dio.dart';

class HomeRepo {
  static getBestSellerBooks() async {
    try {
      final response = await DioFactory.dio?.get("products-bestseller");
      if (response?.statusCode == 200) {
        BooksModel books = BooksModel.fromJson(response?.data);
        return books;
      } else {
        return null;
      }
    } catch (e) {
      return null;
    }
  }

  static Future<List<Products>?> search(String text) async {
    try {
      final responce = await DioFactory.dio?.get(
        "products-search",
        queryParameters: {"name": text},
      );
      if (responce?.statusCode == 200) {
        BooksModel booksModel = BooksModel.fromJson(responce?.data);
        return booksModel.data?.products;
      } else {
        return null;
      }
    } catch (e) {
      return null;
    }
  }

  static Future<bool> addToCart(int productId) async {
    try {
      final response = await DioFactory.dio?.post(
        "add-to-cart",
        data: {"product_id": productId},
      );
      if (response?.statusCode==201){
        return true;
      }else{
        return false;
      }
    } catch (e) {
      return false;
    }
  }
}
