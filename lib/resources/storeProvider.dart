import 'dart:convert';

import 'package:meta/meta.dart';
import 'package:http/http.dart' as http;

import 'package:Eliverd/models/product.dart';
import 'package:Eliverd/models/store.dart';

class StoreAPIClient {
  // TO-DO: 백엔드 API 공식 배포 후 수정
  static const baseUrl = 'http://localhost:8080';
  final http.Client httpClient;

  StoreAPIClient({
    @required this.httpClient,
  }) : assert(httpClient != null);

  Future<List<Stock>> fetchStock(String storeId) async {
    final stockFetchURL = '$baseUrl/store/$storeId/stock';
    final stockResponse = await this.httpClient.get(stockFetchURL);

    if (stockResponse.statusCode != 200) {
      throw Exception('Error occurred while fetching all stocks on your store');
    }

    final data = json.decode(stockResponse.body) as List;

    return data.map((rawStock) {
      return Stock(
        store: rawStock['store'],
        product: rawStock['product'],
        price: rawStock['price'],
        amount: rawStock['amount'],
      );
    }).toList();
  }

  Future<Product> addStock(String storeId, Product product) async {
    final stockAdditionURL = '$baseUrl/store/$storeId/stock';
    final stockResponse = await this.httpClient.post(stockAdditionURL);

    if (stockResponse.statusCode != 201) {
      throw Exception('Error occurred while adding stock on your store');
    }

    final resultJson = jsonDecode(stockResponse.body);
    return Product.fromJson(resultJson);
  }

  Future<Product> removeStock(String stockId, String productId) async {
    throw new UnimplementedError();
  }
}
