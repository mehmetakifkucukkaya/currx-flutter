import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get/get.dart';

import '../model/currency.dart';

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
    isLoading(true);
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
      currencies.value = List<Currency>.from(
        data.map((currency) => Currency.fromJson(currency)),
      );
      filterCurrencies();
    } catch (e) {
      print("API isteği başarısız: $e");
    } finally {
      isLoading(false);
    }
  }
}
