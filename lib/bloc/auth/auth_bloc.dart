import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../ui/utils/auth/auth.dart';
import '../../ui/utils/auth/auth_error.dart';

part 'auth_event.dart';

part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc()
      : super(const AuthStateLoggedOut(isLoading: false, successful: false)) {

    on<AuthEventLogin>((event, emit) async {
      emit(const AuthStateLoggedOut(isLoading: true, successful: false));
      try {
        await Auth().signInWithEmailAndPassword(email: event.email, password: event.password);
        emit(const AuthStateLoggedIn(isLoading: false, successful: true));
      } on FirebaseAuthException catch (e) {
        print(e);
        authErrorLogin = e.toString();
        emit(const AuthStateLoggedOut(isLoading: false, successful: false));
      }
    });

    on<AuthEventLogout>((event, emit) async {
      emit(const AuthStateLoggedOut(isLoading: true, successful: false));
      try{
        await Auth().signOut();
        emit(const AuthStateLoggedOut(isLoading: false, successful: true));
      }on FirebaseAuthException catch(e) {
        throw e.toString();
      }
    });

    on<AuthEventRegister>((event, emit) async {
      emit(const AuthStateLoggedOut(isLoading: true, successful: false));
      try{
        await Auth().createUserWithEmailAndPassword(email: event.email, password: event.password);
        emit(const AuthStateLoggedIn(isLoading: false, successful: true));
      }on FirebaseAuthException catch(e) {
        print(e);
        authErrorRegister = e.toString();
        emit(const AuthStateLoggedOut(isLoading: false, successful: false));
      }
    });

    on<AuthEventResetPassword>((event, emit) async {
      emit(const AuthStateLoggedOut(isLoading: true, successful: false));
      try{
        await Auth().sendResetPasswordEmail(email: event.email);
        emit(const AuthStateLoggedOut(isLoading: false, successful: true));
      }on FirebaseAuthException catch(e) {
        print(e);
        authErrorRegister = e.toString();
        emit(const AuthStateLoggedOut(isLoading: false, successful: false));
      }
    });
  }
}
