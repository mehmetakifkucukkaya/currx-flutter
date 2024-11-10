import 'dart:async';

import 'package:currx/model/currency.dart';
import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get/get.dart';

class CurrencyController extends GetxController {
  var currencies = <Currency>[].obs;
  var filteredCurrencies = <Currency>[].obs;
  var isLoading = true.obs;
  RxString searchQuery = ''.obs;

  final apiKey = dotenv.env['API_KEY']!;

  @override
  void onInit() {
    super.onInit();
    fetchCurrencies();

    //! Her 5 dakikada bir güncelleme yapıyoruz ve apiden verileri çekeren güncelliyoruz
    Timer.periodic(const Duration(minutes: 5), (_) => fetchCurrencies());

    debounce(
      searchQuery,
      (_) => filterCurrencies(),
      time: const Duration(milliseconds: 300),
    );
  }

  void filterCurrencies() {
    if (searchQuery.value.isEmpty) {
      filteredCurrencies.value = currencies;
    } else {
      filteredCurrencies.value = currencies.where((currency) {
        return currency.code
                .toLowerCase()
                .contains(searchQuery.value.toLowerCase()) ||
            currency.name
                .toLowerCase()
                .contains(searchQuery.value.toLowerCase());
      }).toList();
    }
  }

  Future<void> fetchCurrencies() async {
    try {
      Dio dio = Dio();
      var response = await dio.get(
        'https://api.collectapi.com/economy/allCurrency',
        options: Options(
          headers: {
            'content-type': 'application/json',
            'authorization': apiKey
          },
        ),
      );

      var data = response.data['result'];

      // API'den gelen veriyi direk Currency listesine çeviriyoruz
      var newCurrencies = List<Currency>.from(
        data.map((currency) => Currency.fromJson(currency)),
      );

      currencies.value = newCurrencies;
      filterCurrencies();
    } catch (e) {
      print("API isteği başarısız: $e");
    } finally {
      isLoading(false);
    }
  }
}
