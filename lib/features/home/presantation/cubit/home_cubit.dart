import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../../../home/data/models/books_model.dart';
import '../../../home/data/models/repo/home_Repo.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit() : super(HomeInitial());


  getBestSellerBooks()async{
    emit(GetBestSellerBooksLoading());
    final response=await HomeRepo.getBestSellerBooks();
    if(response is BooksModel){
      emit(GetBestSellerBooksSuccess(response.data?.products));
    }else{
      emit(GetBestSellerBooksError());
    }
  }
  search(String text)async {
  emit(SearchLoading());
  final response=await HomeRepo.search(text);
  if(response is List<Products>){
    emit(SearchSuccess(response));
  }else{
    emit(SearchError());
  }

  }

  addToCart (int productId)async{
    emit(AddToCartLoading());
    final response =await HomeRepo.addToCart(productId);
    if(response){
      emit(AddToCartSuccess());
    }else{
      emit(AddToCartError());
    }
  }
}
