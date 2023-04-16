import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lmgtask/bloc/newsbloc/news_bloc.dart';
import 'package:lmgtask/bloc/newsbloc/news_states.dart';

import '../../bloc/newsbloc/news_events.dart';
import '../utils/Widgets/dynamicWidgets.dart';

class SearchScreen extends SearchDelegate<List> {
  NewsBloc newsBloc;

  SearchScreen({required this.newsBloc});

  String queryString = '';

  @override
  String get searchFieldLabel => "Search by category";

  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
        onPressed: () {
          query = '';
          Navigator.pop(context);
        },
        icon: const Icon(Icons.clear),
      )
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
        onPressed: () {
          close(context, []);
        },
        icon: const Icon(Icons.arrow_back));
  }

  @override
  Widget buildResults(BuildContext context) {
    queryString = query;
    newsBloc.add(SearchNewsEvent(query: query));
    return BlocBuilder<NewsBloc, NewsStates>(
        builder: (BuildContext context, NewsStates state) {
      if (state is NewsLoadingState) {
        return const Center(
          child: CircularProgressIndicator(),
        );
      } else if (state is NewsErrorState) {
        return const Center(
          child: Text("No Results Found"),
        );
      } else if (state is NewsLoadedState) {
        if (state.articles.isEmpty) {
          return const Center(
            child: Text("No Results Found"),
          );
        } else {
          return buildNewsList(state.articles);
        }
      } else {
        return const Center(
          child: CircularProgressIndicator(),
        );
      }
    });
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return Container();
  }
}
