part of 'auth_bloc.dart';

abstract class AuthEvent extends Equatable {
  const AuthEvent();
}

@immutable
class AuthEventLogout extends AuthEvent {
  const AuthEventLogout();

  @override
  List<Object?> get props => throw UnimplementedError();
}

@immutable
class AuthEventLogin extends AuthEvent {
  final String email;
  final String password;

  const AuthEventLogin({required this.email, required this.password});

  @override
  List<Object?> get props => [email, password];
}

class AuthEventRegister extends AuthEvent {
  final String email;
  final String password;

  const AuthEventRegister({required this.email, required this.password});

  @override
  List<Object?> get props => [email, password];
}

class AuthEventResetPassword extends AuthEvent {
  final String email;

  const AuthEventResetPassword({required this.email});

  @override
  List<Object?> get props => [email];
}