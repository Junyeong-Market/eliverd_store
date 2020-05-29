import 'package:Eliverd/common/color.dart';
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
              backgroundColor: eliverdColor,
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
          SizedBox(height: height / 80.0),

          // TO-DO: Product BLOC에서 재고 목록 불러오도록 하기
          // Rendered Example
          ProductCard(
            name: '클린 투 클린 핸드 세니타이저',
            manufacturer: '(주)코리안코스팩',
          ),
          ProductCard(
            name: '깔끔대장 강력한편백수 피톤치드',
            manufacturer: '(주)자연',
            price: 5600,
          ),
          ProductCard(
            name: '애니케어 황사마스크 대형',
            manufacturer: '(주)네오인터네셔날',
            price: 8700,
          ),
          ProductCard(
            name: '죽염청신원치약',
            manufacturer: '(주)엘지생활건강',
            price: 10500,
          ),
          ProductCard(
            name: '수세미수세미',
            manufacturer: '(주)스펀지',
            price: 9999900,
          ),
          ProductCard(
            name: '그냥 컵',
            manufacturer: '(유)그릇전문',
            price: 100000000,
          ),
        ],
      ),
    );
  }
}
