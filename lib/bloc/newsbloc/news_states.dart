import 'package:equatable/equatable.dart';
import '../../models/article_model.dart';

abstract class NewsStates extends Equatable {}

class NewsInitState extends NewsStates {
  @override
  List<Object> get props => [];
}

class NewsLoadingState extends NewsStates {
  @override
  List<Object> get props => [];
}

class NewsLoadedState extends NewsStates {
  final List<ArticleModel> articles;

  NewsLoadedState({required this.articles});

  @override
  List<Object> get props => [];
}

class NewsErrorState extends NewsStates {
  final String message;

  NewsErrorState({required this.message});

  @override
  List<Object> get props => [];
}
