import 'dart:async'; // Timer için gerekli import

import 'package:currx/model/crypto.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart'; // For TextEditingController
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get/get.dart';

class CryptoController extends GetxController {
  var isLoading = true.obs;
  var cryptoList = <CryptoModel>[].obs;

  var searchQuery = ''.obs;
  TextEditingController searchController = TextEditingController(); // Add this

  var apiKey = dotenv.env['API_KEY']!;

  Timer? _timer;

  @override
  void onInit() {
    super.onInit();
    fetchCryptoData();

    // Verilerin 5 saniyede bir güncellenmesi için Timer
    _timer = Timer.periodic(const Duration(seconds: 300), (timer) {
      fetchCryptoData();
    });
  }

  // API'den veri çekme fonksiyonu
  Future<void> fetchCryptoData() async {
    try {
      isLoading(true);
      var response = await Dio().get(
        'https://api.collectapi.com/economy/cripto',
        options: Options(
          headers: {
            'Content-Type': 'application/json',
            'authorization': apiKey,
          },
        ),
      );

      if (response.statusCode == 200) {
        var data = response.data['result'] as List;
        cryptoList.value =
            data.map((crypto) => CryptoModel.fromJson(crypto)).toList();
      } else {
        throw Exception("API Error: ${response.statusCode}");
      }
    } catch (e) {
      print('Error: $e');
    } finally {
      isLoading(false);
    }
  }

  // Arama sorgusuna göre filtrelenmiş liste
  List<CryptoModel> get filteredList {
    if (searchQuery.value.isEmpty) {
      return cryptoList; // Eğer arama sorgusu boşsa, tüm listeyi döndür
    } else {
      return cryptoList
          .where((crypto) =>
              crypto.name
                  .toLowerCase()
                  .contains(searchQuery.value.toLowerCase()) ||
              crypto.code
                  .toLowerCase()
                  .contains(searchQuery.value.toLowerCase()))
          .toList(); // Arama sorgusuna uyan öğeleri döndür
    }
  }

  // Arama sorgusunu güncelleme
  void updateSearchQuery(String query) {
    searchQuery.value = query;
  }

  // Arama kutusunu temizleme fonksiyonu
  void clearSearchQuery() {
    searchQuery.value = ''; // Arama sorgusunu temizle
    searchController.clear(); // Clear the TextEditingController
  }

  @override
  void onClose() {
    super.onClose();
    _timer?.cancel(); // Sayfa kapatıldığında timer'ı durdur
    searchController.dispose(); // Dispose of the TextEditingController
  }
}
