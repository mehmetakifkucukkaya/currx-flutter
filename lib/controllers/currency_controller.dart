import 'package:currx/model/currency.dart';
import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get/get.dart';

class CurrencyController extends GetxController {
  var currencies = <Currency>[].obs; // Döviz listemiz
  var isLoading = true.obs;

  var apiKey = dotenv.env['API_KEY']!;

  @override
  void onInit() {
    super.onInit();
    fetchCurrencies();
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
    } catch (e) {
      print("API isteği başarısız: $e");
    } finally {
      isLoading(false);
    }
  }
}
