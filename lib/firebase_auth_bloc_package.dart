library firebase_auth_bloc_package;

import 'package:rxdart/rxdart.dart';

import 'package:bloc_package/bloc_package.dart';
import 'package:firebase_auth_package/firebase_auth_package.dart';

enum AuthView { Login, Register, PasswordRecovery }

class AuthBloc extends BaseLoadingBloc {
  final _authView = BehaviorSubject<AuthView>();
  Stream<AuthView> get authViewStream => _authView.stream;
  final _authFunctions = AuthFunctions();

  void setAuthView(AuthView authView) {
    _authView.sink.add(authView);
  }

  Future<void> register(
      String email, String password, String passwordConfirmation) async {
    setLoading(true);
    return await _authFunctions
        .register(email, password, passwordConfirmation)
        .whenComplete(() {
      setLoading(false);
    });
  }

  Future<void> login(String email, String password) async {
    setLoading(true);
    return await _authFunctions.login(email, password).whenComplete(() {
      setLoading(false);
    });
  }

  Future<void> loginByGoogle() async {
    setLoading(true);
    return await _authFunctions.loginByGoogle().whenComplete(() {
      setLoading(false);
    });
  }

  Future<void> loginByFacebook() async {
    setLoading(true);
    return await _authFunctions.loginByFacebook().whenComplete(() {
      setLoading(false);
    });
  }

  Future<void> recoverPassword(String email) async {
    setLoading(true);
    return await _authFunctions.recoverPassword(email).whenComplete(() {
      setLoading(false);
    });
  }

  Future<void> logout() async {
    await _authFunctions.logout();
  }

  @override
  void dispose() {
    _authView?.close();
    super.dispose();
  }

  static final AuthBloc _authBloc = AuthBloc._internal();

  factory AuthBloc() {
    return _authBloc;
  }

  AuthBloc._internal();
}
