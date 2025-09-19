import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_news_apps/pages/tab1_page.dart';
import 'package:flutter_news_apps/pages/tab2_page.dart';
import 'package:provider/provider.dart';

class TabsPage extends StatelessWidget {
  const TabsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => _NavegacionModel(),
      child: const Scaffold(
        body: _Paginas(),
        bottomNavigationBar: _Navegacion(),
      ),
    );
  }
}

class _Navegacion extends StatelessWidget {
  const _Navegacion();

  @override
  Widget build(BuildContext context) {
    final navegacionModel = Provider.of<_NavegacionModel>(context);

    return BottomNavigationBar(
        currentIndex: navegacionModel.paginaActual,
        onTap: (index) => navegacionModel.paginaActual = index,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Top'),
          BottomNavigationBarItem(icon: Icon(Icons.sports), label: 'Sports'),
          BottomNavigationBarItem(icon: Icon(Icons.science), label: 'Science')
        ]);
  }
}

class _Paginas extends StatelessWidget {
  const _Paginas();

  @override
  Widget build(BuildContext context) {
    final navegacionModel = Provider.of<_NavegacionModel>(context);

    return PageView(
      controller: navegacionModel.pageController,
      physics: const NeverScrollableScrollPhysics(),
      children: [
        const Tab1Page(),
        const Tab2Page(category: 'sports'),
        const Tab2Page(category: 'science'),
        Container(
          color: Colors.green,
        )
      ],
    );
  }
}

class _NavegacionModel with ChangeNotifier {
  int _paginaActual = 0;

  final PageController _pageController = PageController();

  int get paginaActual => _paginaActual;

  PageController get pageController => _pageController;

  set paginaActual(int valor) {
    _paginaActual = valor;
    _pageController.animateToPage(valor,
        duration: const Duration(milliseconds: 200), curve: Curves.easeInOut);
    notifyListeners();
  }
}
