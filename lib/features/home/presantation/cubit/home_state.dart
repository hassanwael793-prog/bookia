part of 'home_cubit.dart';

@immutable
sealed class HomeState {}

final class HomeInitial extends HomeState {}
final class GetBestSellerBooksLoading extends HomeState {}
final class GetBestSellerBooksSuccess extends HomeState {
  final List<Products>? products;
  GetBestSellerBooksSuccess(this.products);
}
final class GetBestSellerBooksError extends HomeState {}

final class SearchLoading extends HomeState {}
final class SearchSuccess extends HomeState {
  final List<Products>? products;
  SearchSuccess(this.products);
}
final class SearchError extends HomeState {}


final class AddToCartLoading extends HomeState {}
final class AddToCartSuccess extends HomeState {}
final class AddToCartError extends HomeState {}
