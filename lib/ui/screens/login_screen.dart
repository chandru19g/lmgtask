import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lmgtask/bloc/auth/auth_bloc.dart';
import 'package:lmgtask/ui/screens/home_screen.dart';
import 'package:lmgtask/ui/utils/Widgets/dynamicWidgets.dart';
import 'package:lmgtask/ui/utils/reset_password.dart';

import '../../controllers/field_controller.dart';
import '../utils/auth/auth_error.dart';
import 'createAccount_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool visiblePassword = true;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthBloc, AuthState>(
      builder: (context, state) {
        if (state is AuthStateLoggedIn) {
          return const HomeScreen();
        }
        if (state is AuthStateLoggedOut) {
          return Scaffold(
            backgroundColor: Colors.white,
            appBar: AppBar(
              iconTheme: const IconThemeData(color: Colors.black),
              elevation: 0,
              backgroundColor: Colors.white.withOpacity(0),
            ),
            body: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Column(
                children: [
                  const Padding(
                    padding: EdgeInsets.only(bottom: 50),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 25, bottom: 25),
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Login',
                            style: TextStyle(
                                fontSize: 35, fontWeight: FontWeight.bold),
                          ),
                          Text(
                            'Insert your E-mail and password to login',
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.grey.shade500),
                          )
                        ],
                      ),
                    ),
                  ),

                  //Email Controller
                  Padding(
                    padding: const EdgeInsets.only(left: 25),
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Row(
                        children: [
                          Icon(
                            Icons.alternate_email,
                            color: Colors.grey.shade500,
                          ),
                          const SizedBox(
                            width: 15,
                          ),
                          SizedBox(
                            height: 50,
                            width: 250,
                            child: TextField(
                              onChanged: (content) {
                                authErrorLogin = "";
                              },
                              controller: emailController,
                              autofocus: true,
                              textInputAction: TextInputAction.next,
                              decoration: InputDecoration(
                                  focusedBorder: const UnderlineInputBorder(
                                      borderSide:
                                          BorderSide(color: Colors.amber)),
                                  hintText: 'E-mail ID',
                                  hintStyle:
                                      TextStyle(color: Colors.grey.shade500),
                                  enabledBorder: UnderlineInputBorder(
                                      borderSide: BorderSide(
                                          color: Colors.grey.shade500))),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),

                  //Password Controller
                  Padding(
                    padding: const EdgeInsets.only(left: 25, top: 20),
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Row(
                        children: [
                          Icon(
                            Icons.password,
                            color: Colors.grey.shade500,
                          ),
                          const SizedBox(
                            width: 15,
                          ),
                          SizedBox(
                            height: 50,
                            width: 250,
                            child: TextField(
                              onChanged: (content) {
                                authErrorLogin = "";
                              },
                              controller: passwordController,
                              autofocus: true,
                              obscureText: visiblePassword,
                              decoration: InputDecoration(
                                  suffixIcon: IconButton(
                                    icon: Icon(
                                      visiblePassword
                                          ? Icons.visibility
                                          : Icons.visibility_off,
                                      color: visiblePassword
                                          ? Colors.grey.shade500
                                          : Colors.amber,
                                    ),
                                    onPressed: () {
                                      setState(() {
                                        visiblePassword = !visiblePassword;
                                      });
                                    },
                                  ),
                                  focusedBorder: const UnderlineInputBorder(
                                    borderSide: BorderSide(color: Colors.amber),
                                  ),
                                  hintText: 'Password',
                                  hintStyle:
                                      TextStyle(color: Colors.grey.shade500),
                                  enabledBorder: UnderlineInputBorder(
                                      borderSide: BorderSide(
                                          color: Colors.grey.shade500))),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),

                  //Auth Error
                  Padding(
                    padding: const EdgeInsets.only(top: 15),
                    child: authErrorLogin != ''
                        ? Text(
                            textAlign: TextAlign.center,
                            authErrorLogin.split(']')[1],
                            style: const TextStyle(
                                color: Colors.red, fontWeight: FontWeight.bold),
                          )
                        : null,
                  ),

                  //Login Button
                  Padding(
                    padding: const EdgeInsets.only(
                      top: 25,
                    ),
                    child: Align(
                      alignment: Alignment.center,
                      child: Column(
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(12),
                            child: SizedBox(
                              width: 250,
                              height: 50,
                              child: MaterialButton(
                                onPressed: () {
                                  if (emailController.text == '') {
                                    validationAlert(context, "Error",
                                        "Email should not be empty");
                                  } else if (passwordController.text == "") {
                                    validationAlert(context, "Error",
                                        "Password should not be empty");
                                  } else {
                                    context.read<AuthBloc>().add(AuthEventLogin(
                                        email: emailController.text,
                                        password: passwordController.text));

                                    emailController.text = "";
                                    passwordController.text = "";
                                  }
                                },
                                color: Colors.amber,
                                child: state.isLoading
                                    ? const Center(
                                        child: CircularProgressIndicator(
                                        backgroundColor: Colors.white,
                                      ))
                                    : const Text('Login'),
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 10),
                            child: TextButton(
                                style: ButtonStyle(
                                  overlayColor:
                                      MaterialStateProperty.resolveWith<Color>(
                                          (Set<MaterialState> states) {
                                    if (states
                                        .contains(MaterialState.focused)) {
                                      return Colors.transparent;
                                    }
                                    if (states
                                        .contains(MaterialState.hovered)) {
                                      return Colors.transparent;
                                    }
                                    if (states
                                        .contains(MaterialState.pressed)) {
                                      return Colors.transparent;
                                    }
                                    return Colors
                                        .transparent; // Defer to the widget's default.
                                  }),
                                ),
                                onPressed: () {
                                  authErrorRegister = "";
                                  emailController.text = "";
                                  passwordController.text = "";
                                  Navigator.pushReplacement(context,
                                      MaterialPageRoute(builder: (context) {
                                    return const CreateAccountScreen();
                                  }));
                                },
                                child: const Text(
                                  'Create Account',
                                  style: TextStyle(
                                      color: Colors.orange,
                                      fontWeight: FontWeight.w500),
                                )),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 10),
                            child: TextButton(
                                style: ButtonStyle(
                                  overlayColor:
                                      MaterialStateProperty.resolveWith<Color>(
                                          (Set<MaterialState> states) {
                                    if (states
                                        .contains(MaterialState.focused)) {
                                      return Colors.transparent;
                                    }
                                    if (states
                                        .contains(MaterialState.hovered)) {
                                      return Colors.transparent;
                                    }
                                    if (states
                                        .contains(MaterialState.pressed)) {
                                      return Colors.transparent;
                                    }
                                    return Colors
                                        .transparent; // Defer to the widget's default.
                                  }),
                                ),
                                onPressed: () {
                                  authErrorLogin = "";
                                  resetPassword(context);
                                },
                                child: const Text('Forgot your password?')),
                          )
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
          );
        } else {
          return Container();
        }
      },
    );
  }
}
