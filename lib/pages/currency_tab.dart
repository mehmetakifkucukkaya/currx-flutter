import 'package:currx/controllers/currency_controller.dart';
import 'package:currx/model/currency.dart';
import 'package:currx/widgets/list_tile.dart';
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

            // ListTileWidget'i burada kullanalım
            return ListTileWidget<Currency>(
              data: currency,
              name: currency.name,
              dateTime: currency.dateTime,
              buyingPrice: currency.buyingPrice,
              sellingPrice: currency.sellingPrice,
              rate: currency.rate,
              isIncreasing: currency.isIncreasing,
            );
          },
        );
      }
    });
  }
}
