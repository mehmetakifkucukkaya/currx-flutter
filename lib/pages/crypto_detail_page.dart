import 'package:currx/model/crypto.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class CryptoDetailPage extends StatefulWidget {
  final CryptoModel crypto;

  const CryptoDetailPage({super.key, required this.crypto});

  @override
  _CryptoDetailPageState createState() => _CryptoDetailPageState();
}

class _CryptoDetailPageState extends State<CryptoDetailPage> {
  final TextEditingController _quantityController = TextEditingController();
  double _totalCost = 0;

  String formatNumber(double number) {
    return NumberFormat.compact(locale: 'tr_TR').format(number);
  }

  // Sayılardaki sembolleri ve virgülleri temizleme fonksiyonu
  double cleanNumber(String number) {
    return double.tryParse(number.replaceAll(RegExp(r'[^\d.]'), '')) ?? 0;
  }

  void _calculateTotalCost() {
    double price = cleanNumber(widget.crypto.pricestr);
    double quantity = double.tryParse(_quantityController.text) ?? 0;
    setState(() {
      _totalCost = price * quantity;
    });
  }

  // Piyasa bilgilerini gösteren widget
  Widget _buildMarketInfo() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.grey.withOpacity(0.1),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(
            child: Text(
              '${widget.crypto.pricestr} \$',
              style: const TextStyle(
                fontSize: 32,
                fontWeight: FontWeight.bold,
                color: Colors.blueAccent,
              ),
            ),
          ),
          const SizedBox(height: 10),
          _buildTextInfo('Piyasa Değeri: ', widget.crypto.marketCapstr),
          const SizedBox(height: 10),
          _buildTextInfo('İşlem Hacmi: ', widget.crypto.volumestr),
          const SizedBox(height: 10),
          _buildTextInfo('Dolaşımdaki Arz: ', widget.crypto.circulatingSupply),
        ],
      ),
    );
  }

  // Değişim oranları bilgilerini gösteren widget
  Widget _buildChangeInfo(String title, String changeStr, double changeValue) {
    return Row(
      children: [
        Icon(
          Icons.arrow_upward,
          color: changeValue < 0 ? Colors.red : Colors.green,
        ),
        const SizedBox(width: 10),
        Text(
          '$title: % $changeStr',
          style: TextStyle(
            fontSize: 18,
            color: changeValue < 0 ? Colors.red : Colors.green,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }

  // Genel bilgi metinlerini düzenleyen widget
  Widget _buildTextInfo(String label, String value) {
    return Text.rich(
      TextSpan(
        text: label,
        style: const TextStyle(fontSize: 18, color: Colors.blueGrey),
        children: [
          TextSpan(
            text: '${formatNumber(cleanNumber(value))} \$',
            style: const TextStyle(
                color: Colors.black, fontWeight: FontWeight.w500),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.crypto.name),
        backgroundColor: Colors.red,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Center(
                child: Padding(
              padding: EdgeInsets.only(bottom: 8.0),
              child: Text(
                "Piyasa Verileri",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700),
              ),
            )),
            _buildMarketInfo(),
            const SizedBox(height: 20),
            const Center(
                child: Padding(
              padding: EdgeInsets.only(bottom: 8.0),
              child: Text(
                "Değişim Oranları",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700),
              ),
            )),
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.grey.withOpacity(0.1),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildChangeInfo('1 Saatlik Değişim',
                      widget.crypto.changeHourstr, widget.crypto.changeHour),
                  const SizedBox(height: 10),
                  _buildChangeInfo('1 Haftalık Değişim',
                      widget.crypto.changeWeekstr, widget.crypto.changeWeek),
                  const SizedBox(height: 10),
                  _buildChangeInfo('24 Saat Değişim',
                      widget.crypto.changeDaystr, widget.crypto.changeDay),
                ],
              ),
            ),
            const SizedBox(height: 20),
            const Center(
              child: Padding(
                padding: EdgeInsets.only(bottom: 8.0),
                child: Text(
                  "Coin Alımı Hesapla",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700),
                ),
              ),
            ),
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.grey.withOpacity(0.1),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TextField(
                    controller: _quantityController,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      labelText: 'Almak İstediğiniz Miktar',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  Center(
                    child: ElevatedButton(
                      onPressed: _calculateTotalCost,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.red[400],
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(vertical: 14),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      child: const Text('Hesapla'),
                    ),
                  ),
                  const SizedBox(height: 16),
                  if (_totalCost > 0)
                    Text(
                      'Toplam Tutar: ${_totalCost.toStringAsFixed(2)} \$',
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
