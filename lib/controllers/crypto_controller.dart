import 'dart:async';

import 'package:currx/model/crypto.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get/get.dart';

class CryptoController extends GetxController {
  var isLoading = true.obs;
  var cryptoList = <CryptoModel>[].obs;

  var searchQuery = ''.obs;
  TextEditingController searchController = TextEditingController();

  var apiKey = dotenv.env['API_KEY']!;

  Timer? _timer;

  @override
  void onInit() {
    super.onInit();
    fetchCryptoData();

    _timer = Timer.periodic(const Duration(seconds: 300), (timer) {
      fetchCryptoData();
    });

    searchController.addListener(() {
      updateSearchQuery(searchController.text);
    });
  }

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

  List<CryptoModel> get filteredList {
    if (searchQuery.value.isEmpty) {
      return cryptoList;
    } else {
      return cryptoList
          .where((crypto) =>
              crypto.name
                  .toLowerCase()
                  .contains(searchQuery.value.toLowerCase()) ||
              crypto.code
                  .toLowerCase()
                  .contains(searchQuery.value.toLowerCase()))
          .toList();
    }
  }

  void updateSearchQuery(String query) {
    searchQuery.value = query;
  }

  void clearSearchQuery() {
    searchQuery.value = '';
    searchController.clear();
  }

  @override
  void onClose() {
    super.onClose();
    _timer?.cancel();
    searchController.dispose();
  }
}
