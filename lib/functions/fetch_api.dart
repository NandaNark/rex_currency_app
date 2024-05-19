import 'package:http/http.dart' as http;
import 'package:rex_currency_app/models/api_url.dart';
import 'package:rex_currency_app/models/currency_model.dart';
import 'package:rex_currency_app/models/rate_model.dart';

Future<RateModel> fetchRate() async {
  var response = await http.get(Uri.parse(ApiUrl.rateUrl));
  final rateModel = rateModelFromJson(response.body);
  return rateModel;

  // try {
  //   var response = await http.get(Uri.parse(ApiUrl.rateUrl));
  //   if (response.statusCode == 200) {
  //     final rateModel = rateModelFromJson(response.body);
  //     return rateModel;
  //   } else {
  //     throw Exception(
  //         'Failed to fetch rates: ${response.statusCode} \n Please switch on your mobile data and restart the app.');
  //   }
  // } catch (e) {
  //   throw Exception(
  //       'Failed to connect to server: $e \n Please switch on your mobile data and restart the app. ');
  // }
}

Future<Map> fetchCurrency() async {
  var response = await http.get(Uri.parse(ApiUrl.currencyUrl));
  final allCurrency = allCurrencyFromJson(response.body);
  return allCurrency;

  // try {
  //   var response = await http.get(Uri.parse(ApiUrl.currencyUrl));
  //   if (response.statusCode == 200) {
  //     final allCurrency = allCurrencyFromJson(response.body);
  //     return allCurrency;
  //   } else {
  //     throw Exception(
  //         'Failed to fetch currency: ${response.statusCode} \n Please switch on your mobile data and restart the app.');
  //   }
  // } catch (e) {
  //   throw Exception(
  //       'Failed to connect to server: $e \n Please switch on your mobile data and restart the app. ');
  // }
}

String convertIdr(Map exchangeRate, String idr, String currency) {
  String outputIdr =
      ((exchangeRate[currency] * double.parse(idr).toStringAsFixed(2)))
          .toString();
  return outputIdr;
}

String convertAny(Map exchangeRate, String amount, String from, String to) {
  String outputAny =
      (double.parse(amount) / exchangeRate[from] * exchangeRate[to])
          .toStringAsFixed(2)
          .toString();
  return outputAny;
}
