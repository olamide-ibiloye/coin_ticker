import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'coin_data.dart';
import 'dart:io' show Platform;
import 'crypto_card.dart';

class PriceScreen extends StatefulWidget {
  @override
  _PriceScreenState createState() => _PriceScreenState();
}

class _PriceScreenState extends State<PriceScreen> {
  String selectedCurrency = 'AUD';
  CoinData coinData = CoinData();
  String btcPrice = '?';
  String ethPrice = '?';
  String ltcPrice = '?';

  DropdownButton<String> androidDropdown() {
    List<DropdownMenuItem<String>> dropdownItems = [];
    for (String currency in currenciesList) {
      var newItem = DropdownMenuItem(
        child: Text(currency),
        value: currency,
      );
      dropdownItems.add(newItem);
    }

    return DropdownButton<String>(
      value: selectedCurrency,
      items: dropdownItems,
      onChanged: (value) {
        setState(() {
          selectedCurrency = value;
        });
      },
    );
  }

  CupertinoPicker iOSPicker() {
    List<Text> pickerItems = [];
    for (String currency in currenciesList) {
      pickerItems.add(Text(currency));
    }

    return CupertinoPicker(
      backgroundColor: Colors.lightBlue,
      itemExtent: 32.0,
      onSelectedItemChanged: (selectedIndex) {
        selectedCurrency = pickerItems[selectedIndex].data;
        getData();
      },
      children: pickerItems,
    );
  }

  Future<dynamic> getData() async{
    Map coinLiveData = await coinData.getCoinData(selectedCurrency);
    updateUI(coinLiveData);
  }

  @override
  void initState() {
    super.initState();
    getData();
  }

  void updateUI(Map liveData) {
    try {
      setState(() {
        dynamic btcLiveData = liveData['BTC'];
        btcPrice = btcLiveData['rate'].toStringAsFixed(0);

        dynamic ethLiveData = liveData['ETH'];
        ethPrice = ethLiveData['rate'].toStringAsFixed(0);

        dynamic ltcLiveData = liveData['LTC'];
        ltcPrice = ltcLiveData['rate'].toStringAsFixed(0);
      });
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('🤑 Coin Ticker'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              cryptoCard(
                  crypto: 'BTC',
                  coinPrice: btcPrice,
                  selectedCurrency: selectedCurrency),
              cryptoCard(
                  crypto: 'ETH',
                  coinPrice: ethPrice,
                  selectedCurrency: selectedCurrency),
              cryptoCard(
                  crypto: 'LTC',
                  coinPrice: ltcPrice,
                  selectedCurrency: selectedCurrency),
            ],
          ),
          Container(
            height: 150.0,
            alignment: Alignment.center,
            padding: EdgeInsets.only(bottom: 30.0),
            color: Colors.lightBlue,
            child: Platform.isIOS ? iOSPicker() : androidDropdown(),
          ),
        ],
      ),
    );
  }
}
