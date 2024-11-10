import 'package:currx/controllers/commodity_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CommodityTab extends StatelessWidget {
  const CommodityTab({super.key});

  @override
  Widget build(BuildContext context) {
    final CommodityController controller = Get.find<CommodityController>();

    return Obx(() {
      if (controller.isLoading.value) {
        return const Center(child: CircularProgressIndicator());
      }

      if (controller.filteredCommodities.isEmpty) {
        return const Center(child: Text('Emtia verisi bulunamadı.'));
      }

      return ListView.builder(
        itemCount: controller.filteredCommodities.length,
        itemBuilder: (context, index) {
          final commodity = controller.filteredCommodities[index];
          return Card(
            color: Colors.white,
            elevation: 2.0,
            margin: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
            child: ListTile(
              title: Text(
                commodity.text,
                style: const TextStyle(
                  color: Colors.red,
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                ),
              ),
              subtitle: Text(
                'Alış: ${commodity.buyingStr}\nSatış: ${commodity.sellingStr}',
                style: const TextStyle(
                  color: Colors.grey,
                  fontWeight: FontWeight.w800,
                ),
              ),
            ),
          );
        },
      );
    });
  }
}
