import 'package:currx/model/gold.dart';
import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get/get.dart';

class GoldController extends GetxController {
  var isLoading = true.obs;
  var goldList = <Gold>[].obs;
  var filteredGoldList = <Gold>[].obs;
  RxString searchQuery = ''.obs;

  final apiKey = dotenv.env['API_KEY']!;

  @override
  void onInit() {
    super.onInit();
    fetchGoldPrices();

    debounce(
      searchQuery,
      (_) => filterGold(),
      time: const Duration(milliseconds: 300),
    );
  }

  void filterGold() {
    if (searchQuery.value.isEmpty) {
      filteredGoldList.value = goldList;
    } else {
      filteredGoldList.value = goldList.where((gold) {
        return gold.name
            .toLowerCase()
            .contains(searchQuery.value.toLowerCase());
      }).toList();
    }
  }

  Future<void> fetchGoldPrices() async {
    isLoading(true);
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
        var data = response.data['result'] as List;
        goldList.value = data.map((item) => Gold.fromJson(item)).toList();
        filterGold(); // İlk yüklemede filtrelenmiş listeyi güncelle
      } else {
        throw Exception('Altın fiyatları yüklenemedi');
      }
    } catch (e) {
      print('Altın fiyatları alınırken bir hata oluştu: $e');
    } finally {
      isLoading(false);
    }
  }
}
