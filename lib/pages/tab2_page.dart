import 'package:flutter/material.dart';
import 'package:flutter_news_apps/services/new_services.dart';
import 'package:flutter_news_apps/widgets/lista_noticias.dart';
import 'package:provider/provider.dart';

class Tab2Page extends StatefulWidget {
  final String category;

  const Tab2Page({super.key, required this.category});
  @override
  State<Tab2Page> createState() => _Tab2PageState();
}

class _Tab2PageState extends State<Tab2Page>
    with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    super.build(context);

    final newsService = Provider.of<NewsServices>(context);

    newsService.getArticlesByCategory(widget.category);

    final categoryNews = newsService.getArticles(widget.category);

    return Scaffold(
      body: (categoryNews.isEmpty)
          ? const Center(child: CircularProgressIndicator())
          : ListaNoticias(categoryNews),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
