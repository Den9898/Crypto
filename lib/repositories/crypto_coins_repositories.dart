import 'package:dio/dio.dart';
import 'package:new2/repositories/abstract_coins_repository.dart';
import 'package:new2/repositories/crypto_coin.dart';

class CryptoCoinsRepository implements AbstractCoinsRepository {
  final Dio dio;

  CryptoCoinsRepository({required  this.dio});
  @override
  Future<List<CryptoCoin>> getCoinsList() async {
    final response = await Dio().get(
      'https://min-api.cryptocompare.com/data/pricemultifull?fsyms=BTC,ETH,BNX,BNB&tsyms=USD,,',
    );
    final data = response.data as Map<String, dynamic>;
    final dataRaw = data['RAW'] as Map<String, dynamic>;
    final cryptoCoinsList = dataRaw.entries.map((e) {
      final usdData = (e.value as Map<String, dynamic>)['USD'] as Map<String, dynamic>;
      final price = usdData['PRICE'];
      final imagesUrl = usdData['IMAGEURL'];
      return CryptoCoin(
        name: e.key, 
        priceInUSD: price,
        imagelUrl: 'https://www.cryptocompare.com/$imagesUrl',
      );
    }).toList();
    return cryptoCoinsList;
  }
}
