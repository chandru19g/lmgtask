part of 'auth_bloc.dart';

abstract class AuthState extends Equatable {
  final bool isLoading;
  final bool successful;

  const AuthState({required this.isLoading, required this.successful});
}

@immutable
class AuthStateLoggedIn extends AuthState {
  const AuthStateLoggedIn({required isLoading, required successful})
      : super(isLoading: isLoading, successful: successful);

  @override
  List<Object?> get props => [isLoading, successful];
}

@immutable
class AuthStateLoggedOut extends AuthState {
  const AuthStateLoggedOut({required isLoading, required successful})
      : super(isLoading: isLoading, successful: successful);

  @override
  List<Object?> get props => [isLoading, successful];
}

