import 'dart:async';

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

  Future<Product> addStock(
      int storeId, Map<String, dynamic> jsonifiedProduct) async {
    final product = await storeAPIClient.upsertStock(storeId, jsonifiedProduct);

    return product;
  }

  Future<Product> updateStock(
      int storeId, Map<String, dynamic> jsonifiedProduct) async {
    final product = await storeAPIClient.upsertStock(storeId, jsonifiedProduct);

    return product;
  }

  Future<Product> removeStock(
      int storeId, Map<String, dynamic> jsonifiedProduct) async {
    final product = await storeAPIClient.upsertStock(storeId, jsonifiedProduct);

    return product;
  }

  Future<List<Manufacturer>> searchManufacturer(String keyword) async {
    final manufacturers = await storeAPIClient.searchManufacturer(keyword);

    return manufacturers;
  }
}
