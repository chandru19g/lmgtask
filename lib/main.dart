import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lmgtask/bloc/auth/auth_bloc.dart';
import 'package:lmgtask/bloc/newsbloc/news_bloc.dart';
import 'package:lmgtask/repository/news_repository.dart';
import 'package:lmgtask/ui/screens/login_screen.dart';

import 'bloc/newsbloc/news_states.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => AuthBloc(),
        ),
        BlocProvider(
          create: (context) => NewsBloc(
            newsRepository: NewsRepositoryImpls(),
            initialState: NewsInitState(),
          ),
        ),
      ],
      child: MaterialApp(
        title: "News App",
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primaryColor: Colors.orange,
          appBarTheme: const AppBarTheme(
            titleTextStyle: TextStyle(
              color: Colors.white,
            ),
            backgroundColor: Colors.orange,
          ),
        ),
        home: const LoginScreen(),
      ),
    );
  }
}
