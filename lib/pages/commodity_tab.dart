import 'package:currx/controllers/commodity_controller.dart';
import 'package:currx/model/commodity.dart';
import 'package:currx/widgets/list_tile.dart';
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

          // Parse the buying and selling prices as doubles
          final buyingPrice = double.tryParse(commodity.buyingStr) ?? 0.0;
          final sellingPrice = double.tryParse(commodity.sellingStr) ?? 0.0;

          // Handle null date values gracefully by using a default value
          final commodityDate =
              commodity.date ?? ''; // Default to empty string if date is null

          return ListTileWidget<Commodity>(
            data: commodity,
            name: commodity.text,
            dateTime: commodityDate.isNotEmpty
                ? DateTime.parse(commodityDate)
                : DateTime.now(), // Parse date or use current date
            buyingPrice: buyingPrice,
            sellingPrice: sellingPrice,
            rate: commodity.rate,
            isIncreasing: commodity.rate > 0,
          );
        },
      );
    });
  }
}
