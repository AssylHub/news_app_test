import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/cubit/news_state.dart';
import 'package:news_app/news_service.dart';

class NewsCubit extends Cubit<NewsState> {
  final NewsService _newsService = NewsService();
  List<dynamic> _allNews = [];
  List<dynamic> _filteredNews = [];

  NewsCubit() : super(NewsInitial());

  void fetchNews() async {
    try {
      emit(NewsLoading());
      _allNews = await _newsService.fetchNews();
      _filteredNews = List.from(_allNews);
      emit(NewsLoaded(_filteredNews));
    } catch (e) {
      emit(NewsError(e.toString()));
    }
  }

  void searchNews(String query) {
    if (query.isEmpty) {
      _filteredNews = List.from(_allNews);
    } else {
      _filteredNews =
          _allNews.where((news) {
            return news['title'].toLowerCase().contains(query.toLowerCase());
          }).toList();
    }
    emit(NewsLoaded(_filteredNews));
  }
}
