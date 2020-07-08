import 'dart:convert';

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

  Future<Store> createStore(Map<String, dynamic> jsonifiedStore) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    final currentSession = prefs.getString('session');

    final url = '$baseUrl/store/';

    final res = await this.httpClient.post(
          url,
          body: jsonifiedStore,
          headers: {
            'Authorization': currentSession,
          },
          encoding: Encoding.getByName('application/json; charset=\'utf-8\''),
        );

    if (res.statusCode != 201) {
      throw Exception('Error occurred while creating your store');
    }

    final jsonData = utf8.decode(res.bodyBytes);

    final data = json.decode(jsonData);

    final registerers = (data['registerer'] as List)
        .map((rawRegisterer) => User.fromJson(rawRegisterer))
        .toList();

    final store = Store(
      id: data['id'],
      name: data['name'],
      description: data['description'],
      registerers: registerers,
      registeredNumber: data['registered_number'],
    );

    return store;
  }

  Future<List<Stock>> fetchStock(Store store) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    final currentSession = prefs.getString('session');

    final storeId = store.id;
    final url = '$baseUrl/store/$storeId/stocks/';
    final res = await this.httpClient.get(
      url,
      headers: {
        'Authorization': currentSession,
      },
    );

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
        amount: rawStock['amount'],
      );
    }).toList();

    return stocks;
  }

  Future<void> upsertStock(
      int storeId, Map<String, dynamic> jsonifiedStock) async {
    final url = '$baseUrl/store/$storeId/stock/';
    final res = await this.httpClient.post(
          url,
          body: jsonifiedStock,
          encoding: Encoding.getByName('application/json; charset=\'utf-8\''),
        );

    if (res.statusCode != 200 && res.statusCode != 201) {
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

    final jsonData = utf8.decode(res.bodyBytes);

    final data = json.decode(jsonData)['results'] as List;

    return data.map((rawManufacturer) => Manufacturer(
      id: rawManufacturer['id'],
      name: rawManufacturer['name'],
    )).toList();
  }
}
