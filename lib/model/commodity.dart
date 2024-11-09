class Commodity {
  final String name;
  final String text;
  final String buyingStr;
  final String sellingStr;
  final double rate;

  Commodity({
    required this.name,
    required this.text,
    required this.buyingStr,
    required this.sellingStr,
    required this.rate,
  });

  factory Commodity.fromJson(Map<String, dynamic> json) {
    return Commodity(
      name: json['name'],
      text: json['text'],
      buyingStr: json['buyingstr'] ?? '0',
      sellingStr: json['sellingstr'],
      // rate'yi string'ten double'a çevirmek için tryParse kullanıyoruz
      rate: double.tryParse(json['rate'].toString()) ?? 0.0,
    );
  }
}
