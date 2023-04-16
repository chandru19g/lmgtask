import 'package:equatable/equatable.dart';

abstract class NewsEvent extends Equatable {}

class FetchNewsEvent extends NewsEvent {
  @override
  List<Object> get props => [];
}


class SearchNewsEvent extends NewsEvent {
  final String query;

  SearchNewsEvent({required this.query});

  @override
  List<Object> get props => [];
}