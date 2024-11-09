import 'package:currx/model/gold.dart';
import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get/get.dart';

class GoldController extends GetxController {
  var isLoading = true.obs;
  var goldPrices = <Map<String, dynamic>>[].obs; // Altın fiyat listemiz

  var apiKey = dotenv.env['API_KEY']!;

  // Altın fiyatlarını çeken metod
  Future<List<Gold>> fetchGoldPrices() async {
    try {
      var dio = Dio();
      var response = await dio.get(
        'https://api.collectapi.com/economy/goldPrice',
        options: Options(
          headers: {
            'content-type': 'application/json',
            'authorization': apiKey,
          },
        ),
      );

      if (response.statusCode == 200) {
        List<Gold> goldList = (response.data['result'] as List)
            .map((item) => Gold.fromJson(item))
            .toList();
        return goldList;
      } else {
        throw Exception('Altın fiyatları yüklenemedi');
      }
    } catch (e) {
      throw Exception('Altın fiyatları alınırken bir hata oluştu: $e');
    }
  }
}
