class Currency {
  final String name;
  final String code;
  final double buyingPrice;
  final double sellingPrice;
  final double rate;
  final DateTime dateTime;

  Currency({
    required this.name,
    required this.code,
    required this.buyingPrice,
    required this.sellingPrice,
    required this.rate,
    required this.dateTime,
  });

  factory Currency.fromJson(Map<String, dynamic> json) {
    double buying = double.tryParse(json['buying'].toString()) ?? 0.0;
    double selling = double.tryParse(json['selling'].toString()) ?? 0.0;
    String code = json['name'].toString().split(' ').last;
    double rate = double.tryParse(json['rate'].toString()) ?? 0.0;

    DateTime dateTime;
    try {
      if (json['datetime'] != null) {
        dateTime = DateTime.parse(json['datetime']);
      } else if (json['date'] != null && json['time'] != null) {
        dateTime = DateTime.parse('${json['date']}T${json['time']}:00.000Z');
      } else {
        dateTime = DateTime.now();
      }
    } catch (e) {
      dateTime = DateTime.now();
    }

    return Currency(
      name: json['name'],
      code: code,
      buyingPrice: buying,
      sellingPrice: selling,
      rate: rate,
      dateTime: dateTime,
    );
  }

  bool get isIncreasing => rate > 0;
}
