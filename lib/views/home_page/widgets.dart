import 'package:flutter/material.dart';

List<Widget> getCategories() {
  return const [
    Tab(
      text: 'History',
      icon: Icon(Icons.history_edu),
    ),
    Tab(
      text: 'Books',
      icon: Icon(Icons.auto_stories),
    ),
    Tab(
      text: 'World News',
      icon: Icon(Icons.newspaper),
    ),
    Tab(
      text: 'Technology',
      icon: Icon(Icons.smart_toy),
    ),
    Tab(
      text: 'Economy',
      icon: Icon(Icons.currency_bitcoin),
    ),
  ];
}
