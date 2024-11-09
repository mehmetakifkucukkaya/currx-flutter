import 'package:flutter/material.dart';

import 'currency_tab.dart';
import 'gold_tab.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  // Tab sayfalarının verisi
  final List<Map<String, dynamic>> tabPages = const [
    {
      'title': 'Döviz',
      'page': CurrencyTab(),
    },
    {
      'title': 'Altın',
      'page': GoldTab(),
    },
  ];

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: tabPages.length,
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: const Text(
            'Döviz ve Altın Listesi',
            style: TextStyle(color: Colors.white),
          ),
          backgroundColor: Colors.red,
          bottom: TabBar(
            indicatorColor: Colors.white,
            labelColor: Colors.white,
            unselectedLabelColor: Colors.black,
            labelStyle: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
            unselectedLabelStyle: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.normal,
            ),
            tabs: tabPages.map((tab) {
              return Tab(text: tab['title']);
            }).toList(),
          ),
        ),
        backgroundColor: Colors.white,
        body: TabBarView(
          children: tabPages.map<Widget>((tab) => tab['page']).toList(),
        ),
      ),
    );
  }
}
