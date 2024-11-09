class CryptoModel {
  final String currency;
  final double changeWeek;
  final String changeWeekstr;
  final double changeDay;
  final String changeDaystr;
  final double changeHour;
  final String changeHourstr;
  final String volumestr;
  final double volume;
  final String pricestr;
  final double price;
  final String circulatingSupply;
  final String marketCapstr;
  final double marketCap;
  final String code;
  final String name;

  CryptoModel({
    required this.currency,
    required this.changeWeek,
    required this.changeWeekstr,
    required this.changeDay,
    required this.changeDaystr,
    required this.changeHour,
    required this.changeHourstr,
    required this.volumestr,
    required this.volume,
    required this.pricestr,
    required this.price,
    required this.circulatingSupply,
    required this.marketCapstr,
    required this.marketCap,
    required this.code,
    required this.name,
  });

  factory CryptoModel.fromJson(Map<String, dynamic> json) {
    return CryptoModel(
      currency: json['currency']?.toString() ?? 'N/A',
      changeWeek: (json['changeWeek'] as num?)?.toDouble() ?? 0.0,
      changeWeekstr: json['changeWeekstr']?.toString() ?? 'N/A',
      changeDay: (json['changeDay'] as num?)?.toDouble() ?? 0.0,
      changeDaystr: json['changeDaystr']?.toString() ?? 'N/A',
      changeHour: (json['changeHour'] as num?)?.toDouble() ?? 0.0,
      changeHourstr: json['changeHourstr']?.toString() ?? 'N/A',
      volumestr: json['volumestr']?.toString() ?? 'N/A',
      volume: (json['volume'] as num?)?.toDouble() ?? 0.0,
      pricestr: json['pricestr']?.toString() ?? 'N/A',
      price: (json['price'] as num?)?.toDouble() ?? 0.0,
      circulatingSupply: json['circulatingSupply']?.toString() ?? 'N/A',
      marketCapstr: json['marketCapstr']?.toString() ?? 'N/A',
      marketCap: (json['marketCap'] as num?)?.toDouble() ?? 0.0,
      code: json['code']?.toString() ?? 'N/A',
      name: json['name']?.toString() ?? 'Unknown',
    );
  }
}
