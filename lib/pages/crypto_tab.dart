import 'package:currx/controllers/crypto_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class CryptoTab extends StatelessWidget {
  const CryptoTab({super.key});

  @override
  Widget build(BuildContext context) {
    // Get the CryptoController instance
    final cryptoController = Get.find<CryptoController>();

    // Format price for better UI consistency
    String formatPrice(double price) {
      return price.toStringAsFixed(2);
    }

    return Obx(() {
      if (cryptoController.filteredList.isEmpty) {
        return const Center(child: Text('No crypto data available.'));
      }

      return ListView.builder(
        itemCount: cryptoController.filteredList.length,
        itemBuilder: (context, index) {
          final crypto = cryptoController.filteredList[index];
          final timeString = DateFormat('HH:mm').format(DateTime.now());
          final dateString = DateFormat('dd/MM/yyyy').format(DateTime.now());

          return Card(
            margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            color: crypto.isIncreasing ? Colors.green[50] : Colors.red[50],
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Üst kısım: Başlık ve Saat
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        crypto.name,
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.black87,
                        ),
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text(
                            timeString,
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                              color: Colors.black87,
                            ),
                          ),
                          Text(
                            dateString,
                            style: TextStyle(
                              fontSize: 12,
                              color: Colors.grey[600],
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  // Alt kısım: Fiyatlar ve Değişim
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      // Alış Fiyatı
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            '${formatPrice(crypto.price)} \$',
                            style: const TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Colors.black87,
                            ),
                          ),
                        ],
                      ),

                      // Değişim Oranı
                      Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 12, vertical: 6),
                        decoration: BoxDecoration(
                          color: crypto.isIncreasing
                              ? Colors.green[100]
                              : Colors.red[100],
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Row(
                          children: [
                            Icon(
                              crypto.isIncreasing
                                  ? Icons.arrow_upward
                                  : Icons.arrow_downward,
                              color: crypto.isIncreasing
                                  ? Colors.green
                                  : Colors.red,
                              size: 16,
                            ),
                            const SizedBox(width: 4),
                            Text(
                              '%${crypto.changeDay.abs().toStringAsFixed(2)}',
                              style: TextStyle(
                                color: crypto.isIncreasing
                                    ? Colors.green
                                    : Colors.red,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          );
        },
      );
    });
  }
}
