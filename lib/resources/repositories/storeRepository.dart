import 'dart:async';

import 'package:meta/meta.dart';

import 'package:Eliverd/resources/providers/providers.dart';
import 'package:Eliverd/models/models.dart';

class StoreRepository {
  final StoreAPIClient storeAPIClient;

  StoreRepository({@required this.storeAPIClient})
      : assert(storeAPIClient != null);

  Future<Store> createStore(Store store) async {
    final data = await storeAPIClient.createStore(store);

    return data;
  }

  Future<Store> getStore(int storeId) async {
    final store = await storeAPIClient.getStore(storeId);

    return store;
  }

  Future<List<Stock>> fetchStock(Store store,
      [String name, String category, String orderBy]) async {
    final stocks =
        await storeAPIClient.fetchStock(store, name, category, orderBy);

    return stocks;
  }

  Future<void> addStock(int storeId, Map<String, dynamic> product) async {
    await storeAPIClient.upsertStock(storeId, product);
  }

  Future<void> updateStock(Stock stock) async {
    final updateJson = {
      'ian': stock.product.ian,
      'price': stock.price,
      'amount': stock.amount,
    };

    await storeAPIClient.upsertStock(stock.store.id, updateJson);
  }

  Future<void> removeStock(Stock stock) async {
    final removeJson = {
      'ian': stock.product.ian,
      'amount': (-stock.amount).toString(),
    };

    await storeAPIClient.upsertStock(stock.store.id, removeJson);
  }

  Future<List<Manufacturer>> searchManufacturer(String keyword) async {
    final manufacturers = await storeAPIClient.searchManufacturer(keyword);

    return manufacturers;
  }
}
