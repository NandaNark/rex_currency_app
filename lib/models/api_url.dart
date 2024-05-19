import 'package:rex_currency_app/models/key.dart';

class ApiUrl {
  static const String rateUrl =
      'https://openexchangerates.org/api/latest.json?app_idd=$apiKey';
  static const String currencyUrl =
      'https://openexchangerates.org/api/currencies.json?app_id=$apiKey';
}
