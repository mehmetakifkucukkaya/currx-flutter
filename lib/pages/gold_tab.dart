import 'package:currx/controllers/gold_controllers.dart';
import 'package:currx/model/gold.dart';
import 'package:currx/widgets/list_tile.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class GoldTab extends StatelessWidget {
  const GoldTab({super.key});

  @override
  Widget build(BuildContext context) {
    final GoldController controller = Get.find<GoldController>();

    return Obx(() {
      if (controller.isLoading.value) {
        return const Center(child: CircularProgressIndicator());
      }

      if (controller.filteredGoldList.isEmpty) {
        return const Center(child: Text('Altın verisi bulunamadı.'));
      }

      return ListView.builder(
        padding: const EdgeInsets.all(10),
        itemCount: controller.filteredGoldList.length,
        itemBuilder: (context, index) {
          var gold = controller.filteredGoldList[index];

          return ListTileWidget<Gold>(
            data: gold,
            name: gold.name,
            dateTime: gold.dateTime,
            buyingPrice: gold.buying,
            sellingPrice: gold.selling,
            rate: gold.rate,
            isIncreasing: gold.rate > 0,
          );
        },
      );
    });
  }
}
