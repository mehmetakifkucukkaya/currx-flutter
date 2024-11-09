import 'dart:async'; // Timer için gerekli import

import 'package:currx/model/crypto.dart';
import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get/get.dart';

class CryptoController extends GetxController {
  var isLoading = true.obs;
  var cryptoList = <CryptoModel>[].obs;

  var apiKey = dotenv.env['API_KEY']!;
  Timer? _timer;

  @override
  void onInit() {
    super.onInit();

    fetchCryptoData();

    //* 5 saniyede bir veriler çekiliyor
    _timer = Timer.periodic(const Duration(seconds: 5), (timer) {
      fetchCryptoData();
    });
  }

  Future<void> fetchCryptoData() async {
    try {
      isLoading(true);
      var response =
          await Dio().get('https://api.collectapi.com/economy/cripto',
              options: Options(
                headers: {
                  'Content-Type': 'application/json',
                  'authorization': apiKey
                },
              ));

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

  @override
  void onClose() {
    super.onClose();
    _timer?.cancel(); // Sayfa kapatıldığında timer'ı durdurutor
  }
}
