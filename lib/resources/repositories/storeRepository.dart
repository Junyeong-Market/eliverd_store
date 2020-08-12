import 'dart:async';
import 'dart:convert';

import 'package:meta/meta.dart';

import 'package:Eliverd/resources/providers/providers.dart';
import 'package:Eliverd/models/models.dart';

class StoreRepository {
  final StoreAPIClient storeAPIClient;

  StoreRepository({@required this.storeAPIClient})
      : assert(storeAPIClient != null);

  Future<Store> createStore(Map<String, dynamic> store) async {
    final data = await storeAPIClient.createStore(store);

    return data;
  }

  Future<Store> getStore(int storeId) async {
    final store = await storeAPIClient.getStore(storeId);

    return store;
  }

  Future<List<Stock>> fetchStock(Store store) async {
    final stocks = await storeAPIClient.fetchStock(store);

    return stocks;
  }

  Future<void> addStock(
      int storeId, Map<String, dynamic> product) async {
    await storeAPIClient.upsertStock(storeId, product);
  }

  Future<void> updateStock(
      int storeId, Map<String, dynamic> product) async {
    final updateJson = {
      'ian': product['ian'],
      'price': product['price'],
      'amount': product['amount'],
    };

    await storeAPIClient.upsertStock(storeId, updateJson);
  }

  Future<void> removeStock(
      int storeId, Map<String, dynamic> product) async {
    final removeJson = {
      'ian': product['ian'],
      'amount': (-(json.decode(product['amount']) as int)).toString(),
    };

    await storeAPIClient.upsertStock(storeId, removeJson);
  }

  Future<List<Manufacturer>> searchManufacturer(String keyword) async {
    final manufacturers = await storeAPIClient.searchManufacturer(keyword);

    return manufacturers;
  }
}
