import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:new2/crypto_coins_list.dart';
import 'package:get_it/get_it.dart';
import 'package:new2/repositories/abstract_coins_repository.dart';
import 'package:new2/repositories/crypto_coins_repositories.dart';

void main() {
  GetIt.I.registerLazySingleton<AbstractCoinsRepository>(() => CryptoCoinsRepository(dio: Dio()));
  runApp(const CryptoCurrenciesListApp());
}
