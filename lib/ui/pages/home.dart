import 'package:Eliverd/common/string.dart';
import 'package:flutter/material.dart';

import 'package:Eliverd/ui/widgets/header.dart';
import 'package:Eliverd/ui/widgets/product.dart';

import 'add_product.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;

    return Scaffold(
      key: Key('HomePage'),
      appBar: Header(
        height: height / 4.8,
        child: Column(
          children: <Widget>[
            AppBar(
              backgroundColor: Colors.lightBlue,
              actions: <Widget>[
                IconButton(
                  icon: const Icon(Icons.search),
                  tooltip: searchProductDesc,
                  onPressed: () {
                    // TO-DO: 상품 조건적 검색 BLOC 구현
                    // TO-DO: 상품 검색 페이지로 Navigate
                  },
                ),
                IconButton(
                  icon: const Icon(Icons.add),
                  tooltip: addProductDesc,
                  onPressed: () {
                    Navigator.push(
                      context, MaterialPageRoute(builder: (context) => AddProductPage()));
                  },
                ),
              ],
              elevation: 0.0,
            ),
            Align(
              alignment: FractionalOffset(0.1, 0.0),
              child: Text(
                // TO-DO: User BLOC에서 사업장 이름 불러오기
                "사업장 이름",
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 36.0,
                  fontWeight: FontWeight.bold),
              ),
            ),
          ],
        ),
      ),
      body: ListView(
        children: <Widget>[
          // TO-DO: Product BLOC에서 재고 목록 불러오도록 하기

          // Rendered Example
          ProductCard(
            name: '손소독제',
            manufacturer: '(주)컴퍼니',
          ),
        ],
      ),
    );
  }
}
