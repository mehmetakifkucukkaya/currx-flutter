import 'package:currx/model/commodity.dart';
import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get/get.dart';

class CommodityController extends GetxController {
  var commodities = <Commodity>[].obs;
  var filteredCommodities = <Commodity>[].obs;
  var isLoading = true.obs;
  RxString searchQuery = ''.obs;

  late Dio _dio;

  @override
  void onInit() {
    super.onInit();
    _dio = Dio();
    fetchCommodities();

    debounce(
      searchQuery,
      (_) => filterCommodities(),
      time: const Duration(milliseconds: 300),
    );
  }

  void filterCommodities() {
    if (searchQuery.value.isEmpty) {
      filteredCommodities.value = commodities;
    } else {
      filteredCommodities.value = commodities.where((commodity) {
        return commodity.text
            .toLowerCase()
            .contains(searchQuery.value.toLowerCase());
      }).toList();
    }
  }

  Future<void> fetchCommodities() async {
    final apiKey = dotenv.env['API_KEY'];
    if (apiKey == null) {
      print('API Key not found!');
      return;
    }

    final options = Options(
      headers: {'Content-Type': 'application/json', 'Authorization': apiKey},
    );

    try {
      isLoading(true);
      final response = await _dio.get(
        'https://api.collectapi.com/economy/emtia',
        options: options,
      );

      if (response.data['success'] == true) {
        var commodityList = (response.data['result'] as List)
            .map((item) => Commodity.fromJson(item))
            .toList();
        commodities.assignAll(commodityList);
        filterCommodities(); // Filtrelenmiş listeyi güncelleyoruz
      } else {
        print('API Response success false');
      }
    } catch (e) {
      print('Error: $e');
    } finally {
      isLoading(false);
    }
  }
}
