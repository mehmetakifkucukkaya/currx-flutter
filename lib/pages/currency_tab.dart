import 'package:currx/controllers/currency_controller.dart';
import 'package:currx/widgets/currency_list_tile.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CurrencyTab extends StatelessWidget {
  const CurrencyTab({super.key});

  @override
  Widget build(BuildContext context) {
    final CurrencyController controller = Get.find();

    return Obx(() {
      if (controller.isLoading.value) {
        return const Center(child: CircularProgressIndicator());
      } else {
        return ListView.builder(
          itemCount: controller.filteredCurrencies.length,
          itemBuilder: (context, index) {
            var currency = controller.filteredCurrencies[index];
            return CurrencyListTile(currency: currency);
          },
        );
      }
    });
  }
}
