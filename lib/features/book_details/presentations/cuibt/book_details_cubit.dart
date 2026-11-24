import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../../data/model/book_details_model.dart';
import '../../data/repo/book_details_repo.dart';

part 'book_details_state.dart';

class BookDetailsCubit extends Cubit<BookDetailsState> {
  BookDetailsCubit() : super(BookDetailsInitial());

  int? currentBookId;

  Future<void> GetDetails(int id) async {
    currentBookId = id;
    try {
      emit(BookDetailsLoading());
      final details = await BookDetailsRepo.GetBookDetails(id);
      if (details != null && details is BookDetailsModel) {
        emit(BookDetailsSuccess(details));
      } else {
        emit(BookDetailsError());
      }
    } catch (e) {
      emit(BookDetailsError());
    }
  }
}
