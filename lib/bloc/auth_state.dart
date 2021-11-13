part of 'auth_bloc.dart';

abstract class AuthState extends Equatable {
  const AuthState();
  
  @override
  List<Object> get props => [];
}

class AuthInitial extends AuthState {}

class RegisterState extends AuthState {}

class AdminAuthState extends AuthState {
  @override
  List<Object> get props => [];
}

class NormalAuthState extends AuthState {
  @override
  List<Object> get props => [];
}

class UnAuthState extends AuthState {
  @override
  List<Object> get props => [];
}