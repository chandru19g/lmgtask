import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lmgtask/bloc/auth/auth_bloc.dart';
import 'package:lmgtask/ui/screens/search_screen.dart';

import '../../bloc/newsbloc/news_bloc.dart';
import '../../bloc/newsbloc/news_events.dart';
import '../../bloc/newsbloc/news_states.dart';
import '../utils/Widgets/dynamicWidgets.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late NewsBloc newsBloc;

  @override
  void initState() {
    super.initState();
    newsBloc = BlocProvider.of<NewsBloc>(context);
    newsBloc.add(FetchNewsEvent());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Center(
          child: Text(
            "Daily News",
            style: TextStyle(
              fontSize: 24.0,
              letterSpacing: 1.0,
            ),
          ),
        ),
        actions: [
          IconButton(
            onPressed: () {
              showSearch(
                  context: context,
                  delegate: SearchScreen(
                      newsBloc: BlocProvider.of<NewsBloc>(context)));
            },
            icon: const Icon(Icons.search),
          ),
          IconButton(
            onPressed: () {
              context.read<AuthBloc>().add(const AuthEventLogout());
            },
            icon: const Icon(Icons.logout_outlined),
          )
        ],
        elevation: 3.0,
      ),
      body: BlocListener<NewsBloc, NewsStates>(
        listener: (context, state) {
          if (state is NewsErrorState) {
            ScaffoldMessenger.of(context)
                .showSnackBar(SnackBar(content: Text(state.message)));
          }
        },
        child: BlocBuilder<NewsBloc, NewsStates>(
          builder: (BuildContext context, NewsStates state) {
            if (state is NewsLoadingState) {
              return const Center(
                child: CircularProgressIndicator(
                  color: Colors.amber,
                ),
              );
            } else if (state is NewsLoadedState) {
              return buildNewsList(state.articles);
            } else if (state is NewsErrorState) {
              String error = state.message;
              return Center(child: Text(error));
            } else {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
          },
        ),
      ),
    );
  }
}
