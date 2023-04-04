part of 'crypto_list_bloc.dart';

// @immutable

abstract class CryptoListState extends Equatable {
  @override
  List<Object> get props => [];
}

@override
class CryptoListInitial extends CryptoListState {
  @override
  List<Object> get props => [];
}

class CryptoListLoading extends CryptoListState {
  @override
  List<Object> get props => [];
}

class CryptoListLoaded extends CryptoListState {
  final List<CryptoCoin> coinsList;

  CryptoListLoaded({required this.coinsList});

  @override
  List<Object> get props => [coinsList];
}

class CryptoListLoadingFailure extends CryptoListState {
  CryptoListLoadingFailure({
  required  this.exception,
  });

  final Object exception;

  @override
  List<Object> get props => [exception];
}
