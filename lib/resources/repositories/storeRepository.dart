import 'dart:async';
import 'dart:convert';

import 'package:meta/meta.dart';

import 'package:Eliverd/resources/providers/providers.dart';
import 'package:Eliverd/models/models.dart';

class StoreRepository {
  final StoreAPIClient storeAPIClient;

  StoreRepository({@required this.storeAPIClient})
      : assert(storeAPIClient != null);

  Future<Store> createStore(Map<String, dynamic> jsonifiedStore) async {
    final store = await storeAPIClient.createStore(jsonifiedStore);

    return store;
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
      int storeId, Map<String, dynamic> jsonifiedProduct) async {
    await storeAPIClient.upsertStock(storeId, jsonifiedProduct);
  }

  Future<void> updateStock(
      int storeId, Map<String, dynamic> jsonifiedProduct) async {
    final updateJson = {
      'ian': jsonifiedProduct['ian'],
      'price': jsonifiedProduct['price'],
      'amount': jsonifiedProduct['amount'],
    };

    await storeAPIClient.upsertStock(storeId, updateJson);
  }

  Future<void> removeStock(
      int storeId, Map<String, dynamic> jsonifiedProduct) async {
    final removeJson = {
      'ian': jsonifiedProduct['ian'],
      'amount': (-(json.decode(jsonifiedProduct['amount']) as int)).toString(),
    };

    await storeAPIClient.upsertStock(storeId, removeJson);
  }

  Future<List<Manufacturer>> searchManufacturer(String keyword) async {
    final manufacturers = await storeAPIClient.searchManufacturer(keyword);

    return manufacturers;
  }
}
