import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_news_apps/models/news_models.dart';
import 'package:http/http.dart' as http;

const _URL_NEWS = 'https://newsapi.org/v2';
const _APIKEY = '';
const Category = 'general';

class NewsServices with ChangeNotifier {
  List<Article> headlines = [];

  final Map<String, List<Article>> categoryArticles = {};

  NewsServices() {
    getTopHeadlines();
  }

  Future<void> getTopHeadlines() async {
    final url =
        Uri.parse('$_URL_NEWS/top-headlines?country=us&apiKey=$_APIKEY');
    headlines = [];
    try {
      final resp = await http.get(url);

      if (resp.statusCode == 200) {
        final newResponse = reqResListadoFromJson(resp.body);
        headlines.addAll(newResponse.articles);
        notifyListeners();
      } else {
        debugPrint('Error al cargar las noticias ${resp.statusCode}');
      }
    } catch (e) {
      debugPrint('Excepcion al cargar las noticias $e');
    }
  }

  Future<void> getArticlesByCategory(String category) async {
    final url = Uri.parse(
        '$_URL_NEWS/top-headlines?country=us&category=$category&apiKey=$_APIKEY');

    try {
      final resp = await http.get(url);

      if (resp.statusCode == 200) {
        final newResponse = reqResListadoFromJson(resp.body);
        categoryArticles[category] = newResponse.articles;
        notifyListeners();
      } else {
        debugPrint('Error al cargar noticias de $category ${resp.statusCode}');
      }
    } catch (e) {
      debugPrint('Excepción al cargar noticias de $category $e');
    }
  }

  List<Article> getArticles(String category) {
    return categoryArticles[category] ?? [];
  }
}
