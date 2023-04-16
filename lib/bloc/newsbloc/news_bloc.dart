import '../../models/article_model.dart';
import '../../repository/news_repository.dart';

import '../../bloc/newsbloc/news_events.dart';
import '../../bloc/newsbloc/news_states.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class NewsBloc extends Bloc<NewsEvent, NewsStates> {
  NewsRepository newsRepository;

  NewsStates get initialState => NewsInitState();

  NewsBloc({required this.newsRepository, required NewsStates initialState})
      : super(initialState) {
    on<FetchNewsEvent>((event, emit) async {
      emit(NewsLoadingState());
      try {
        List<ArticleModel> articles = await newsRepository.fetchNews();
        emit(NewsLoadedState(articles: articles));
      } catch (e) {
        emit(NewsErrorState(message: e.toString()));
      }
    });

    on<SearchNewsEvent>((event, emit) async {
      emit(NewsLoadingState());
      try {
        List<ArticleModel> articles = await newsRepository.searchNews(event.query);
        emit(NewsLoadedState(articles: articles));
      } catch (e) {
        emit(NewsErrorState(message: e.toString()));
      }
    });
  }
}
