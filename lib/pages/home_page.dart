import 'package:currx/controllers/commodity_controller.dart';
import 'package:currx/controllers/crypto_controller.dart';
import 'package:currx/controllers/currency_controller.dart';
import 'package:currx/controllers/gold_controllers.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'commodity_tab.dart';
import 'crypto_tab.dart';
import 'currency_tab.dart';
import 'gold_tab.dart';

class HomePage extends StatelessWidget {
  HomePage({super.key});

  // Tab kontrolü için RxInt ekleyelim
  final RxInt currentTab = 0.obs;

  final List<Map<String, dynamic>> tabPages = const [
    {
      'title': 'Döviz',
      'page': CurrencyTab(),
    },
    {
      'title': 'Altın',
      'page': GoldTab(),
    },
    {
      'title': 'Emtia',
      'page': CommodityTab(),
    },
    {
      'title': 'Kripto',
      'page': CryptoTab(),
    },
  ];

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: tabPages.length,
      child: Scaffold(
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(110),
          child: AppBar(
            elevation: 0,
            centerTitle: true,
            backgroundColor: Colors.red,
            title: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Container(
                height: 40,
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: TextField(
                  style: const TextStyle(color: Colors.white),
                  decoration: InputDecoration(
                    hintText: 'Ara...',
                    hintStyle: TextStyle(color: Colors.white.withOpacity(0.7)),
                    border: InputBorder.none,
                    contentPadding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 8,
                    ),
                    prefixIcon: const Icon(
                      Icons.search,
                      color: Colors.white,
                    ),
                  ),
                  onChanged: (value) {
                    //! Aktif tab'a göre o tabın controller'ıni çağırıp arama sorgusunu yapıyoruz
                    switch (currentTab.value) {
                      case 0:
                        final controller = Get.find<CurrencyController>();
                        controller.searchQuery.value = value;
                        break;
                      case 1:
                        final controller = Get.find<GoldController>();
                        controller.searchQuery.value = value;
                        break;
                      case 2:
                        final controller = Get.find<CommodityController>();
                        controller.searchQuery.value = value;
                        break;
                      case 3:
                        final controller = Get.find<CryptoController>();
                        controller.searchQuery.value = value;
                        break;
                    }
                  },
                ),
              ),
            ),
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
              onTap: (index) {
                //* Tab değiştiğinde index'i günceliyoruz
                currentTab.value = index;

                final searchController = TextEditingController();
                searchController.clear();

                switch (index) {
                  case 0:
                    final controller = Get.find<CurrencyController>();
                    controller.searchQuery.value = '';
                    break;
                }
              },
              tabs: tabPages.map((tab) {
                return Tab(text: tab['title']);
              }).toList(),
            ),
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
