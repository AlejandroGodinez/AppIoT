import 'dart:async';

import 'package:app_iot/auth/user_auth_provider.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc() : super(AuthInitial());
  // auth provider
  UserAuthProvider _authProvider = UserAuthProvider();

  @override
  Stream<AuthState> mapEventToState(
    AuthEvent event,
  ) async* {
    if (event is SplashScreenEvent) {
      yield AuthInitial();
    }
    if (event is ShowRegisterEvent) {
      yield RegisterState();
    }
    if (event is ShowLoginEvent) {
      yield UnAuthState();
    }
    if (event is VerifyAuthenticationEvent) {
      if (_authProvider.isAlreadyLogged()){
        if(_authProvider.isGoogleLogin())
          yield AdminAuthState();
        else
          yield NormalAuthState();
      }
      else
        yield UnAuthState();
    }
    if (event is SignOutAuthenticationEvent) {
      if (FirebaseAuth.instance.currentUser.isAnonymous) {
        await _authProvider.signOutFirebase();
      } else {
        await _authProvider.signOutFirebase();
        await _authProvider.signOutGoogle();
      }
      yield UnAuthState();
    }
  }
}
