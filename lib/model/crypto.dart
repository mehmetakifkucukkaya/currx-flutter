class CryptoModel {
  final String name;
  final String code;
  final double price;
  final double changeDay;
  final String pricestr;
  final String changeDaystr;

  CryptoModel({
    required this.name,
    required this.code,
    required this.price,
    required this.changeDay,
    required this.pricestr,
    required this.changeDaystr,
  });

  
  factory CryptoModel.fromJson(Map<String, dynamic> json) {
    return CryptoModel(
      name: json['name'],
      code: json['code'],
      price:
          double.tryParse(json['price'].toString()) ?? 0.0, 
      changeDay: double.tryParse(json['changeDay'].toString()) ??
          0.0, // Change as double
      pricestr: json['pricestr'],
      changeDaystr: json['changeDaystr'],
    );
  }
}
