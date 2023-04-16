import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lmgtask/ui/screens/login_screen.dart';

import '../../bloc/auth/auth_bloc.dart';
import '../../controllers/field_controller.dart';
import '../utils/Widgets/dynamicWidgets.dart';
import '../utils/auth/auth_error.dart';

class CreateAccountScreen extends StatefulWidget {
  const CreateAccountScreen({Key? key}) : super(key: key);

  @override
  State<CreateAccountScreen> createState() => _CreateAccountScreenState();
}

class _CreateAccountScreenState extends State<CreateAccountScreen> {
  bool visiblePassword = true;

  @override
  Widget build(BuildContext context) {
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
                      'Create Account',
                      style:
                          TextStyle(fontSize: 35, fontWeight: FontWeight.bold),
                    ),
                    Text(
                      'Insert your E-mail and password to create account',
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
                        controller: emailController,
                        autofocus: true,
                        textInputAction: TextInputAction.next,
                        decoration: InputDecoration(
                            focusedBorder: const UnderlineInputBorder(
                                borderSide: BorderSide(color: Colors.amber)),
                            hintText: 'E-mail ID',
                            hintStyle: TextStyle(color: Colors.grey.shade500),
                            enabledBorder: UnderlineInputBorder(
                                borderSide:
                                    BorderSide(color: Colors.grey.shade500))),
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
                        controller: passwordController,
                        autofocus: true,
                        obscureText: visiblePassword,
                        decoration: InputDecoration(
                            suffixIcon: IconButton(
                              icon: Icon(
                                Icons.remove_red_eye,
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
                            hintStyle: TextStyle(color: Colors.grey.shade500),
                            enabledBorder: UnderlineInputBorder(
                                borderSide:
                                    BorderSide(color: Colors.grey.shade500))),
                      ),
                    ),
                  ],
                ),
              ),
            ),

            //Auth Error
            Padding(
              padding: const EdgeInsets.only(top: 15),
              child: authErrorRegister != ''
                  ? Text(
                      textAlign: TextAlign.center,
                      authErrorRegister.split(']')[1],
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
                              context.read<AuthBloc>().add(AuthEventRegister(
                                  email: emailController.text,
                                  password: passwordController.text));

                              emailController.text = "";
                              passwordController.text = "";

                              print("authErrorRegister $authErrorRegister");
                              Future.delayed(const Duration(seconds: 1), () {
                                authErrorRegister != ''
                                    ? setState(() {})
                                    : Navigator.pushReplacement(context,
                                        MaterialPageRoute(builder: (context) {
                                        return const LoginScreen();
                                      }));
                              });
                            }
                          },
                          color: Colors.amber,
                          child: const Text('Create Account'),
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
                              if (states.contains(MaterialState.focused)) {
                                return Colors.transparent;
                              }
                              if (states.contains(MaterialState.hovered)) {
                                return Colors.transparent;
                              }
                              if (states.contains(MaterialState.pressed)) {
                                return Colors.transparent;
                              }
                              return Colors
                                  .transparent; // Defer to the widget's default.
                            }),
                          ),
                          onPressed: () {
                            authErrorLogin = "";
                            emailController.text = "";
                            passwordController.text = "";
                            Navigator.pushReplacement(context,
                                MaterialPageRoute(builder: (context) {
                              return const LoginScreen();
                            }));
                          },
                          child: const Text(
                            'Already have an account? Login Here',
                            style: TextStyle(
                                color: Colors.orange,
                                fontWeight: FontWeight.w500),
                          )),
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
