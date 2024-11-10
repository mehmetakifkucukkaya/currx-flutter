class Gold {
  final String name;
  final double buying;
  final double selling;
  final DateTime dateTime;
  final double rate;

  Gold({
    required this.name,
    required this.buying,
    required this.selling,
    required this.dateTime,
    required this.rate,
  });

  factory Gold.fromJson(Map<String, dynamic> json) {
    // DateTime dönüşümü
    DateTime date = json['datetime'] != null
        ? DateTime.parse(json['datetime'])
        : DateTime.now();

    double buyingPrice = 0.0;
    double sellingPrice = 0.0;
    double rateValue = 0.0;

    try {
      buyingPrice = double.tryParse(json['buying'].toString()) ?? 0.0;
      sellingPrice = double.tryParse(json['selling'].toString()) ?? 0.0;
      rateValue = double.tryParse(json['rate'].toString()) ?? 0.0;
    } catch (e) {
      print("Error parsing prices: $e");
    }

    return Gold(
      name: json['name'] ?? '',
      buying: buyingPrice,
      selling: sellingPrice,
      dateTime: date,
      rate: rateValue,
    );
  }
}
