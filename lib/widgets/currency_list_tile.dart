import 'package:currx/model/currency.dart';
import 'package:flutter/material.dart';

//TODO: Ülke bayrakları gelmiyor. Ülke bayrağı gelecek şekilde ayarlarnacak

class CurrencyListTile extends StatelessWidget {
  final Currency currency;

  const CurrencyListTile({super.key, required this.currency});

  @override
  Widget build(BuildContext context) {
    // Günlük değişimi hesaplıyoruz
    double changePercentage = ((currency.sellingPrice - currency.buyingPrice) /
            currency.buyingPrice) *
        100;

    // Değişim oranına göre renk belirliyoruz (Yükseliş veya düşüş durummu)
    String changeColor = changePercentage >= 0 ? 'green' : 'red';

    return Card(
      color: Colors.white,
      elevation: 2.0,
      margin: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
      child: ListTile(
        //* Bayrak
        // leading: currency.flagUrl.isNotEmpty
        //     ? SizedBox(
        //         width: 40,
        //         height: 40,
        //         child: Image.network(
        //           currency.flagUrl,
        //           fit: BoxFit
        //               .cover, // Görüntünün kutuya tam oturmasını sağlıyoruz
        //         ),
        //       )
        //     : Container(width: 40, height: 40, color: Colors.grey),
        //* Döviz ismi
        title: Text(
          currency.name,
          style: const TextStyle(
            color: Colors.red, // Kırmızı renk başlıklar için
            fontWeight: FontWeight.bold,
          ),
        ),
        subtitle: Row(
          children: [
            //* Döviz fiyatı

            Text(
              'Fiyat: ${currency.sellingPrice.toStringAsFixed(2)} ₺',
              style: const TextStyle(
                color: Colors.black,
              ),
            ),
            const SizedBox(width: 10),
            //* Döviz değişim oranı
            Text(
              "${changePercentage.toStringAsFixed(2)}%",
              style: TextStyle(
                color: changeColor == 'green' ? Colors.green : Colors.red,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
        //* Değişim yönü
        trailing: Icon(
          changeColor == 'green' ? Icons.arrow_upward : Icons.arrow_downward,
          color: changeColor == 'green' ? Colors.green : Colors.red,
        ),
      ),
    );
  }
}
