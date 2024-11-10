import 'package:currx/controllers/gold_controllers.dart';
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
          String buyingPrice = gold.buying.toString();
          String sellingPrice = gold.selling.toString();

          return Card(
            elevation: 5,
            margin: const EdgeInsets.symmetric(vertical: 8),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15),
            ),
            child: ListTile(
              contentPadding: const EdgeInsets.all(15),
              leading: const Icon(
                Icons.attach_money,
                color: Colors.amber,
                size: 30,
              ),
              title: Text(
                gold.name,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Alış: $buyingPrice ₺',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      color: Colors.green[700],
                    ),
                  ),
                  Text(
                    'Satış: $sellingPrice ₺',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      color: Colors.red[700],
                    ),
                  ),
                ],
              ),
              trailing: Icon(
                Icons.arrow_forward_ios,
                size: 20,
                color: Colors.grey[700],
              ),
            ),
          );
        },
      );
    });
  }
}
