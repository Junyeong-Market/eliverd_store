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

  Future<Store> createStore(Store store) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    final session = prefs.getString('session');

    final url = '$baseUrl/store/';

    final body = {
      'name': store.name,
      'description': store.description,
      'registerer': store.registerers.map((user) => user.pid).toList(),
      'registered_number': store.registeredNumber,
      'lat': store.location.lat,
      'lng': store.location.lng,
    };

    final res = await this.httpClient.post(
          url,
          headers: {
            HttpHeaders.authorizationHeader: session,
            HttpHeaders.contentTypeHeader: 'application/json',
          },
          body: json.encode(body),
          encoding: Encoding.getByName('utf-8'),
        );

    if (res.statusCode != 201) {
      throw Exception('Error occurred while creating your store');
    }

    final decoded = utf8.decode(res.bodyBytes);

    return Store.fromJson(json.decode(decoded));
  }

  Future<List<Stock>> fetchStock(Store store, [String name, String category, String orderBy]) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    final session = prefs.getString('session');

    String url = '$baseUrl/store/${store.id}/stocks/';

    final filters = { 'name': name, 'category': category, 'order_by': orderBy };

    String queries = '';

    filters.forEach((key, value) {
      if (value != null && value.isNotEmpty) {
        if (queries.isNotEmpty) {
          queries += '&';
        }

        queries += '$key=$value';
      }
    });

    if (queries.isNotEmpty) {
      url += '?' + queries;
    }

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

    return json
        .decode(decoded)['results']
        .map<Stock>((stock) => Stock.fromJson(stock, store))
        .toList();
  }

  Future<void> upsertStock(int storeId, Map<String, dynamic> stock) async {
    print(stock);
    final url = '$baseUrl/store/$storeId/stock/';
    final res = await this.httpClient.post(
          url,
          headers: {
            HttpHeaders.contentTypeHeader: 'application/json',
          },
          body: json.encode(stock),
          encoding: Encoding.getByName('utf-8'),
        );
    print(res.statusCode);
    print(utf8.decode(res.bodyBytes));

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

    final decoded = utf8.decode(res.bodyBytes);

    final data = json.decode(decoded);

    return Product.fromJson(data);
  }

  Future<Store> getStore(int storeId) async {
    final url = '$baseUrl/store/$storeId/';
    final res = await this.httpClient.get(url);

    print(res.statusCode);
    if (res.statusCode != 200) {
      throw Exception('Error occurred while fetching a store');
    }

    final decoded = utf8.decode(res.bodyBytes);

    return Store.fromJson(json.decode(decoded));
  }

  Future<List<Manufacturer>> searchManufacturer(String keyword) async {
    final url = '$baseUrl/product/manufacturer/search/$keyword/';
    final res = await this.httpClient.get(url);

    if (res.statusCode != 200) {
      return <Manufacturer>[];
    }

    final decoded = utf8.decode(res.bodyBytes);

    return json
        .decode(decoded)['results']
        .map<Manufacturer>(
            (manufacturer) => Manufacturer.fromJson(manufacturer))
        .toList();
  }
}
