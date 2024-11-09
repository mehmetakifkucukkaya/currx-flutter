import 'package:currx/controllers/gold_controllers.dart';
import 'package:currx/model/gold.dart';
import 'package:flutter/material.dart';

class GoldTab extends StatelessWidget {
  const GoldTab({super.key});

  @override
  Widget build(BuildContext context) {
    final goldController = GoldController();

    return FutureBuilder<List<Gold>>(
      future: goldController.fetchGoldPrices(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text('Hata: ${snapshot.error}'));
        } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return const Center(child: Text('Altın verisi bulunamadı.'));
        } else {
          var goldData = snapshot.data;
          return ListView.builder(
            padding: const EdgeInsets.all(10),
            itemCount: goldData?.length ?? 0,
            itemBuilder: (context, index) {
              var gold = goldData?[index];
              String buyingPrice =
                  gold?.buying.toString() ?? 'Fiyat Bulunamadı';
              String sellingPrice =
                  gold?.selling.toString() ?? 'Fiyat Bulunamadı';

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
                    gold?.name ?? 'Altın Adı Bulunamadı',
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
        }
      },
    );
  }
}
