import 'package:currx/model/currency.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class CurrencyListTile extends StatelessWidget {
  final Currency currency;

  const CurrencyListTile({super.key, required this.currency});

  @override
  Widget build(BuildContext context) {
    final timeString = DateFormat('HH:mm').format(currency.dateTime);
    final dateString = DateFormat('dd/MM/yyyy').format(currency.dateTime);

    return Card(
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
                  currency.name,
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
                      '${currency.buyingPrice.toStringAsFixed(4)} ₺',
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
                      '${currency.sellingPrice.toStringAsFixed(4)} ₺',
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
                    color: currency.isIncreasing
                        ? Colors.green[50]
                        : Colors.red[50],
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Row(
                    children: [
                      Icon(
                        currency.isIncreasing
                            ? Icons.arrow_upward
                            : Icons.arrow_downward,
                        color:
                            currency.isIncreasing ? Colors.green : Colors.red,
                        size: 16,
                      ),
                      const SizedBox(width: 4),
                      Text(
                        '%${currency.rate.abs().toStringAsFixed(2)}',
                        style: TextStyle(
                          color:
                              currency.isIncreasing ? Colors.green : Colors.red,
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
