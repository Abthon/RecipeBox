import 'package:flutter/material.dart';
import 'package:riverpod/riverpod.dart';

final pageControllerProvider =
    StateNotifierProvider<PageControllerProvider, int>((ref) {
  return PageControllerProvider();
});

class PageControllerProvider extends StateNotifier<int> {
  PageControllerProvider() : super(0);

  void setPage(int index) {
    state = index;
  }
}
