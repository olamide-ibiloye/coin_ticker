import 'networking.dart';
import 'api_key.dart';

const List<String> currenciesList = [
  'AUD',
  'BRL',
  'CAD',
  'CNY',
  'EUR',
  'GBP',
  'HKD',
  'IDR',
  'ILS',
  'INR',
  'JPY',
  'MXN',
  'NOK',
  'NZD',
  'PLN',
  'RON',
  'RUB',
  'SEK',
  'SGD',
  'USD',
  'ZAR'
];

const List<String> cryptoList = [
  'BTC',
  'ETH',
  'LTC',
];

const coinAPIURL = 'https://rest.coinapi.io/v1/exchangerate';



class CoinData {

  Future<dynamic> getCoinData(String selectedCurrency) async{
    Map allLiveCoinsData = <String, dynamic>{};

    for (String crypto in cryptoList) {
      NetworkHelper networkHelper = NetworkHelper(
          url:
          '$coinAPIURL/$crypto/$selectedCurrency?apikey=$apiKey');

      allLiveCoinsData[crypto] = await networkHelper.getData();
    }

    return allLiveCoinsData;
  }
}
