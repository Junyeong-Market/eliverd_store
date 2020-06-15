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
    final createStoreURL = '$baseUrl/store';

    final storeResponse = await this.httpClient.post(
      createStoreURL,
      body: jsonifiedStore,
      encoding: Encoding.getByName('application/json; charset=\'utf-8\'')
    );

    if (storeResponse.statusCode != 201) {
      throw Exception('Error occurred while creating your store');
    }

    final data = json.decode(storeResponse.body) as Store;

    return data;
  }

  Future<List<Stock>> fetchStock(int storeId) async {
    final stockFetchURL = '$baseUrl/store/$storeId/stocks';
    final stockResponse = await this.httpClient.get(stockFetchURL);

    if (stockResponse.statusCode != 200) {
      throw Exception('Error occurred while fetching all stocks on your store');
    }

    final data = json.decode(stockResponse.body) as List;

    return data.map((rawStock) {
      return Stock(
        storeId: storeId,
        productId: rawStock['productId'],
        price: rawStock['price'],
        amount: rawStock['number'],
      );
    }).toList();
  }

  Future<Product> addStock(String storeId, Map<String, dynamic> jsonifiedStock) async {
    final stockAdditionURL = '$baseUrl/store/$storeId/stock';
    final stockResponse = await this.httpClient.post(
      stockAdditionURL,
      body: jsonifiedStock,
      encoding: Encoding.getByName('application/json; charset=\'utf-8\''),
    );

    if (stockResponse.statusCode != 201) {
      throw Exception('Error occurred while adding stock on your store');
    }

    final data = json.decode(stockResponse.body) as Product;

    return data;
  }

  Future<Product> removeStock(String stockId, String productId) async {
    throw new UnimplementedError();
  }

  Future<Product> getProduct(String productId) async {
    final getProductURL = '$baseUrl/product/$productId';
    final productResponse = await this.httpClient.get(getProductURL);

    if (productResponse.statusCode != 200) {
      throw Exception('Error occurred while fetching a product');
    }

    final data = json.decode(productResponse.body) as Product;

    return data;
  }

  Future<Store> getStore(String storeId) async {
    final getStoreURL = '$baseUrl/store/$storeId';
    final storeResponse = await this.httpClient.get(getStoreURL);

    if (storeResponse.statusCode != 200) {
      throw Exception('Error occurred while fetching a product');
    }

    final data = json.decode(storeResponse.body) as Store;

    return data;
  }
}
