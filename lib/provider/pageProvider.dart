import 'package:flutter/material.dart';

class PageProvider with ChangeNotifier {
  int _currentPage = 0;
  final PageController _pageController = PageController();

  int get currentPage => _currentPage;
  PageController get pageController => _pageController;

  void setPage(int page) {
    _currentPage = page;
    notifyListeners();
  }

  void jumpToPage(int page) {
    _currentPage = page;
    _pageController.jumpToPage(page);
    setPage(page);
  }
}