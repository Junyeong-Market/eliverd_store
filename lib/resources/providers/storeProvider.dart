import 'dart:convert';

import 'package:meta/meta.dart';
import 'package:http/http.dart' as http;

import 'package:Eliverd/models/product.dart';
import 'package:Eliverd/models/store.dart';

class StoreAPIClient {
  static const baseUrl = 'SECRET:8000';
  final http.Client httpClient;

  StoreAPIClient({
    @required this.httpClient,
  }) : assert(httpClient != null);

  Future<Store> createStore(Map<String, dynamic> jsonifiedStore) async {
    final url = '$baseUrl/store/';
    final res = await this.httpClient.post(
          url,
          body: jsonifiedStore,
          encoding: Encoding.getByName('application/json; charset=\'utf-8\''),
        );

    if (res.statusCode != 201) {
      throw Exception('Error occurred while creating your store');
    }

    final jsonData = utf8.decode(res.bodyBytes);

    final data = json.decode(jsonData) as Store;

    return data;
  }

  Future<List<Stock>> fetchStock(Store store) async {
    final storeId = store.id;
    final url = '$baseUrl/store/$storeId/stocks/';
    final res = await this.httpClient.get(url);

    if (res.statusCode != 200) {
      throw Exception('Error occurred while fetching all stocks on your store');
    }

    final jsonData = utf8.decode(res.bodyBytes);

    final data = json.decode(jsonData)['results'] as List;

    final stocks = data.map((rawStock) {
      return Stock(
        store: store,
        product: Product.fromJson(rawStock['product']),
        price: rawStock['price'],
        amount: rawStock['number'],
      );
    }).toList();

    return stocks;
  }

  Future<Product> upsertStock(
      int storeId, Map<String, dynamic> jsonifiedStock) async {
    final url = '$baseUrl/store/$storeId/stock/';
    final res = await this.httpClient.post(
          url,
          body: jsonifiedStock,
          encoding: Encoding.getByName('application/json; charset=\'utf-8\''),
        );

    if (res.statusCode != 201) {
      throw Exception(
          'Error occurred while adding/updating/deleting stock on your store');
    }

    final jsonData = utf8.decode(res.bodyBytes);

    final data = json.decode(jsonData);

    return Product.fromJson(data);
  }

  Future<Product> getProduct(int productId) async {
    final url = '$baseUrl/product/$productId/';
    final res = await this.httpClient.get(url);

    if (res.statusCode != 200) {
      throw Exception('Error occurred while fetching a product');
    }

    final jsonData = utf8.decode(res.bodyBytes);

    final data = json.decode(jsonData);

    return Product.fromJson(data);
  }

  Future<Store> getStore(int storeId) async {
    final url = '$baseUrl/store/$storeId/';
    final res = await this.httpClient.get(url);

    if (res.statusCode != 200) {
      throw Exception('Error occurred while fetching a store');
    }

    final jsonData = utf8.decode(res.bodyBytes);

    final data = json.decode(jsonData);

    final store = Store(
      id: storeId,
      name: data['name'],
      description: data['description'],
      registerers: data['registerer'],
      registeredNumber: data['registered_number'],
    );

    // TO-DO: location 필드 추출 로직 구성하기

    return store;
  }
}
