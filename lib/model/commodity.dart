class Commodity {
  final String name;
  final String text;
  final String buyingStr;
  final String sellingStr;
  final double rate;
  final String? date;  // Make the date field nullable

  Commodity({
    required this.name,
    required this.text,
    required this.buyingStr,
    required this.sellingStr,
    required this.rate,
    this.date,  // Allow date to be null
  });

  factory Commodity.fromJson(Map<String, dynamic> json) {
    return Commodity(
      name: json['name'],
      text: json['text'],
      buyingStr: json['buyingstr'] ?? '0',
      sellingStr: json['sellingstr'],
      rate: double.tryParse(json['rate'].toString()) ?? 0.0,
      date: json['date'] as String?,  // Handle null values gracefully
    );
  }
}
