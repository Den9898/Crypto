import 'package:equatable/equatable.dart';

class CryptoCoin extends Equatable {
  final String name;
  final double priceInUSD;
  final String imagelUrl;

  CryptoCoin({
    required this.imagelUrl,
    required this.name,
    required this.priceInUSD,
  });

  @override
  // TODO: implement props
  List<Object?> get props => [imagelUrl, name, priceInUSD];
}
