library firebase_auth_bloc_package;

import 'package:flutter/material.dart';
import 'package:rxdart/rxdart.dart';

import 'package:bloc_package/bloc_package.dart';
import 'package:firebase_auth_package/firebase_auth_package.dart';

enum AuthState { Uninitialized, Unauthenticated, Authenticated }

class AuthBloc extends BlocBase {
  final AuthFunctions _authFunctions;

  final _authState = BehaviorSubject<AuthState>.seeded(AuthState.Uninitialized);
  Stream<AuthState> get authStateStream => _authState.stream;
  Sink<AuthState> get _authStateSink => _authState.sink;

  AuthBloc({@required AuthFunctions authFunctions})
      : assert(authFunctions != null),
        _authFunctions = authFunctions;

  void setAuthState({@required AuthState authState}) {
    _authStateSink.add(authState);
  }

  Future<void> startApp() async {
    if (await _authFunctions.isLoggedIn()) {
      return setAuthState(authState: AuthState.Authenticated);
    }

    return setAuthState(authState: AuthState.Unauthenticated);
  }

  @override
  void dispose() {
    _authState.close();
  }
}