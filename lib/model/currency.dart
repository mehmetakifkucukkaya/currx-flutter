class Currency {
  final String name;
  final String code;
  final double buyingPrice;
  final double sellingPrice;
  final String flagUrl;

  Currency({
    required this.name,
    required this.code,
    required this.buyingPrice,
    required this.sellingPrice,
    required this.flagUrl,
  });

  //  JSON verisini modele dönüştürme metodumuz
  factory Currency.fromJson(Map<String, dynamic> json) {
    double buying = double.tryParse(json['buying'].toString()) ?? 0.0;
    double selling = double.tryParse(json['selling'].toString()) ?? 0.0;
    String code = json['name'].toString().split(' ').last;

    // Ülke bayrağını almak için ülke kodunu eşliyorz
    String countryCode = _getCountryCodeFromCurrency(code);

    return Currency(
      name: json['name'],
      code: code,
      buyingPrice: buying,
      sellingPrice: selling,
      flagUrl:
          'https://restcountries.com/v3.1/alpha/$countryCode/flags', // Ülke koduna göre bayrak URL'si
    );
  }

  // Döviz koduna göre ülke kodunu eşlemek için  fonksiyon
  static String _getCountryCodeFromCurrency(String currencyCode) {
    switch (currencyCode) {
      case 'USD':
        return 'US';
      case 'EUR':
        return 'DE';
      case 'GBP':
        return 'GB';
      case 'JPY':
        return 'JP';

      default:
        return 'US';
    }
  }
}
