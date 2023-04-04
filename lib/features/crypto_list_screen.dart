import 'dart:async';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:new2/features/bloc/crypto_list_bloc.dart';
import 'package:new2/features/bloc/crypto_list_bloc.dart';
import 'package:new2/features/bloc/crypto_list_bloc.dart';
import 'package:new2/repositories/abstract_coins_repository.dart';
import 'package:new2/repositories/crypto_coin.dart';
import 'package:new2/repositories/crypto_coins_repositories.dart';

import 'bloc/crypto_list_bloc.dart';

class CryptoListScreen extends StatefulWidget {
  const CryptoListScreen({Key? key}) : super(key: key);

  @override
  State<CryptoListScreen> createState() => _CryptoListScreenState();
}

class _CryptoListScreenState extends State<CryptoListScreen> {
  final _cryptoListBloc = CryptoListBloc(
    GetIt.I<AbstractCoinsRepository>(),
  );

  @override
  void initState() {
    _cryptoListBloc.add(LoadCryptoList());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'CryptoCurrenciesList',
        ),
      ),
      body: RefreshIndicator(
        onRefresh: () async {
          final completer = Completer();
          _cryptoListBloc.add(LoadCryptoList(completer: completer));
          return completer.future;
        },
        child: BlocBuilder<CryptoListBloc, CryptoListState>(
          bloc: _cryptoListBloc,
          builder: (context, state) {
            if (state is CryptoListLoaded) {
              return ListView.separated(
                separatorBuilder: (context, i) => const Divider(),
                itemCount: state.coinsList.length,
                itemBuilder: (context, i) {
                  final coin = state.coinsList[i];
                  final theme = Theme.of(context);
                  return ListTile(
                    title: Text(
                      coin.name,
                      style: theme.textTheme.bodyMedium,
                    ),
                    subtitle: Text(
                      '${coin.priceInUSD} \$',
                      style: theme.textTheme.labelSmall,
                    ),
                    leading: Image.network(
                      coin.imagelUrl,
                    ),
                    trailing: const Icon(
                      Icons.arrow_forward,
                    ),
                    onTap: () {
                      Navigator.of(context).pushNamed(
                        '/coin',
                        arguments: coin,
                      );
                    },
                  );
                },
              );
            }
            if (state is CryptoListLoadingFailure) {
              return Center(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('Error'),
                    TextButton(
                      onPressed: () {
                        _cryptoListBloc.add(LoadCryptoList());
                      },
                      child: Text('try again'),
                    )
                  ],
                ),
              );
            }
            return const Center(
              child: CircularProgressIndicator(),
            );
          },
        ),
      ),

      // (_cryptoCoinsList == null)
      //     ? const SizedBox()
      //
      // floatingActionButton: FloatingActionButton(
      //   child: const Icon(Icons.download),
      //   onPressed: () async {},
      // ),
    );
  }
}
