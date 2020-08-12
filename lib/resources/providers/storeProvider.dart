import 'dart:convert';
import 'dart:io';

import 'package:meta/meta.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import 'package:Eliverd/models/models.dart';

class StoreAPIClient {
  static const baseUrl = 'SECRET:8000';
  final http.Client httpClient;

  StoreAPIClient({
    @required this.httpClient,
  }) : assert(httpClient != null);

  Future<Store> createStore(Map<String, dynamic> store) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    final session = prefs.getString('session');

    final url = '$baseUrl/store/';

    final res = await this.httpClient.post(
          url,
          headers: {
            HttpHeaders.authorizationHeader: session,
            HttpHeaders.contentTypeHeader: 'application/json',
          },
          body: json.encode(store),
          encoding: Encoding.getByName('utf-8'),
        );

    if (res.statusCode != 201) {
      throw Exception('Error occurred while creating your store');
    }

    final decoded = utf8.decode(res.bodyBytes);

    final data = json.decode(decoded);

    final registerers = (data['registerer'] as List)
        .map((rawRegisterer) => User.fromJson(rawRegisterer))
        .toList();

    return Store(
      id: data['id'],
      name: data['name'],
      description: data['description'],
      registerers: registerers,
      registeredNumber: data['registered_number'],
    );
  }

  Future<List<Stock>> fetchStock(Store store) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    final session = prefs.getString('session');

    final url = '$baseUrl/store/${store.id}/stocks/';
    final res = await this.httpClient.get(
      url,
      headers: {
        HttpHeaders.authorizationHeader: session,
      },
    );

    if (res.statusCode != 200) {
      throw Exception('Error occurred while fetching all stocks on your store');
    }

    final decoded = utf8.decode(res.bodyBytes);

    final data = json.decode(decoded)['results'] as List;

    final stocks = data.map((rawStock) {
      return Stock(
        store: store,
        product: Product.fromJson(rawStock['product']),
        price: rawStock['price'],
        amount: rawStock['amount'],
      );
    }).toList();

    return stocks;
  }

  Future<void> upsertStock(
      int storeId, Map<String, dynamic> stock) async {
    final url = '$baseUrl/store/$storeId/stock/';
    final res = await this.httpClient.post(
          url,
          headers: {
            HttpHeaders.contentTypeHeader: 'application/json',
          },
          body: json.encode(stock),
          encoding: Encoding.getByName('utf-8'),
        );

    if ([200, 201].any((statusCode) => statusCode == res.statusCode)) {
      throw Exception(
          'Error occurred while adding/updating/deleting stock on your store');
    }
  }

  Future<Product> getProduct(int productId) async {
    final url = '$baseUrl/product/$productId/';
    final res = await this.httpClient.get(url);

    if (res.statusCode != 200) {
      throw Exception('Error occurred while fetching a product');
    }

    final decoded = utf8.decode(res.bodyBytes);

    final data = json.decode(decoded);

    return Product.fromJson(data);
  }

  Future<Store> getStore(int storeId) async {
    final url = '$baseUrl/store/$storeId/';
    final res = await this.httpClient.get(url);

    if (res.statusCode != 200) {
      throw Exception('Error occurred while fetching a store');
    }

    final decoded = utf8.decode(res.bodyBytes);

    final data = json.decode(decoded);

    final registerers = (data['registerer'] as List)
        .map((rawRegisterer) => User.fromJson(rawRegisterer))
        .toList();

    final store = Store(
      id: storeId,
      name: data['name'],
      description: data['description'],
      registerers: registerers,
      registeredNumber: data['registered_number'],
    );

    // TO-DO: location 필드 추출 로직 구성하기

    return store;
  }

  Future<List<Manufacturer>> searchManufacturer(String keyword) async {
    final url = '$baseUrl/product/manufacturer/search/$keyword/';
    final res = await this.httpClient.get(url);

    if (res.statusCode != 200) {
      return <Manufacturer>[];
    }

    final decoded = utf8.decode(res.bodyBytes);

    final data = json.decode(decoded)['results'] as List;

    return data.map((rawManufacturer) => Manufacturer(
      id: rawManufacturer['id'],
      name: rawManufacturer['name'],
    )).toList();
  }
}
