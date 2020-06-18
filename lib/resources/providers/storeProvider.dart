import 'dart:convert';

import 'package:meta/meta.dart';
import 'package:http/http.dart' as http;

import 'package:Eliverd/models/product.dart';
import 'package:Eliverd/models/store.dart';

class StoreAPIClient {
  // TO-DO: 백엔드 API 공식 배포 후 수정
  static const baseUrl = 'http://localhost:8000';
  final http.Client httpClient;

  StoreAPIClient({
    @required this.httpClient,
  }) : assert(httpClient != null);

  Future<Store> createStore(Map<String, dynamic> jsonifiedStore) async {
    final url = '$baseUrl/store';
    final res = await this.httpClient.post(url,
        body: jsonifiedStore,
        encoding: Encoding.getByName('application/json; charset=\'utf-8\''));

    if (res.statusCode != 201) {
      throw Exception('Error occurred while creating your store');
    }

    final data = json.decode(res.body) as Store;

    return data;
  }

  Future<List<Stock>> fetchStock(Store store) async {
    final storeId = store.id;
    final url = '$baseUrl/store/$storeId/stocks';
    final res = await this.httpClient.get(url);

    if (res.statusCode != 200) {
      throw Exception('Error occurred while fetching all stocks on your store');
    }

    final data = json.decode(res.body) as List;

    return data.map((rawStock) {
      return Stock(
        store: store,
        product: rawStock['product'],
        price: rawStock['price'],
        amount: rawStock['number'],
      );
    }).toList();
  }

  Future<Product> upsertStock(
      int storeId, Map<String, dynamic> jsonifiedStock) async {
    final url = '$baseUrl/store/$storeId/stock';
    final res = await this.httpClient.post(
          url,
          body: jsonifiedStock,
          encoding: Encoding.getByName('application/json; charset=\'utf-8\''),
        );

    if (res.statusCode != 201) {
      throw Exception(
          'Error occurred while adding/updating/deleting stock on your store');
    }

    final data = json.decode(res.body) as Product;

    return data;
  }

  Future<Product> getProduct(int productId) async {
    final url = '$baseUrl/product/$productId';
    final res = await this.httpClient.get(url);

    if (res.statusCode != 200) {
      throw Exception('Error occurred while fetching a product');
    }

    final data = json.decode(res.body) as Product;

    return data;
  }

  Future<Store> getStore(int storeId) async {
    final url = '$baseUrl/store/$storeId';
    final res = await this.httpClient.get(url);

    if (res.statusCode != 200) {
      throw Exception('Error occurred while fetching a product');
    }

    final data = json.decode(res.body) as Store;

    return data;
  }
}
