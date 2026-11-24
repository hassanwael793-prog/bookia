part of 'auth_cubit.dart';

@immutable
sealed class AuthState {}

final class AuthInitial extends AuthState {}
final class loginLoadingState extends AuthState {}
final class loginSuccessState extends AuthState {}
final class loginErrorState extends AuthState {
  new(String serverMessage);
}
