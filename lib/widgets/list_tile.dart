import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ListTileWidget<T> extends StatelessWidget {
  final T data;
  final String name;
  final DateTime dateTime;
  final double buyingPrice;
  final double sellingPrice;
  final double rate;
  final bool isIncreasing;

  const ListTileWidget({
    super.key,
    required this.data,
    required this.name,
    required this.dateTime,
    required this.buyingPrice,
    required this.sellingPrice,
    required this.rate,
    required this.isIncreasing,
  });

  @override
  Widget build(BuildContext context) {
    final timeString = DateFormat('HH:mm').format(dateTime);
    final dateString = DateFormat('dd/MM/yyyy').format(dateTime);

    String formatPrice(double price) {
      return price.toStringAsFixed(2);
    }

    return Card(
      color: isIncreasing ? Colors.green[50] : Colors.red[50],
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            // Üst kısım: Başlık ve Saat
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  name,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
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
                    const Text(
                      'ALIŞ',
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.grey,
                      ),
                    ),
                    Text(
                      '${formatPrice(buyingPrice)} ₺',
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                // Satış Fiyatı
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'SATIŞ',
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.grey,
                      ),
                    ),
                    Text(
                      '${formatPrice(sellingPrice)} ₺',
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                // Değişim Oranı
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  decoration: BoxDecoration(
                    color: isIncreasing ? Colors.green[50] : Colors.red[50],
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Row(
                    children: [
                      Icon(
                        isIncreasing
                            ? Icons.arrow_upward
                            : Icons.arrow_downward,
                        color: isIncreasing ? Colors.green : Colors.red,
                        size: 16,
                      ),
                      const SizedBox(width: 4),
                      Text(
                        '%${rate.abs().toStringAsFixed(2)}',
                        style: TextStyle(
                          color: isIncreasing ? Colors.green : Colors.red,
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
  }
}
