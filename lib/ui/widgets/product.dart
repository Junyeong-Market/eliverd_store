import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:intl/intl.dart';

import 'package:Eliverd/common/string.dart';

import 'package:Eliverd/ui/pages/update_product.dart';

class ProductCard extends StatefulWidget {
  const ProductCard({Key key, this.id, this.name, this.manufacturer, this.price, this.ian}) : super(key: key);

  final String id;
  final String name;
  final String manufacturer;
  final int price;
  final String ian;

  @override
  _ProductCardState createState() => _ProductCardState();
}

class _ProductCardState extends State<ProductCard> {

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;

    return new Card(
      margin: EdgeInsets.zero,
      elevation: 0.0,
      child: Column(
        children: <Widget>[
          SizedBox(height: height / 80.0),
          Padding(
            padding: EdgeInsets.all(15.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Flexible(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        widget.name,
                        maxLines: 1,
                        textAlign: TextAlign.left,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 19.0,
                        ),
                      ),
                      Text(
                        widget.manufacturer,
                        maxLines: 1,
                        textAlign: TextAlign.left,
                        style: TextStyle(
                          color: Colors.black54,
                          fontSize: 16.0,
                        ),
                      ),
                    ],
                  ),
                ),
                Text(
                  formattedPrice(widget.price),
                  maxLines: 1,
                  textAlign: TextAlign.right,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20.0,
                  ),
                ),
              ],
            ),
          ),
          ButtonBar(
            buttonPadding: EdgeInsets.all(0.0),
            children: <Widget>[
              IconButton(
                icon: const Icon(Icons.open_in_new),
                tooltip: updateProductDesc,
                onPressed: () {
                  Navigator.push(
                    context, MaterialPageRoute(builder: (context) => UpdateProductPage()));
                },
              ),
              IconButton(
                icon: const Icon(Icons.payment),
                tooltip: checkOutProductDesc,
                onPressed: () {
                  // TO-DO: 상품 결제 페이지로 Navigate
                },
              ),
              IconButton(
                icon: const Icon(Icons.delete),
                tooltip: deleteProductDesc,
                onPressed: () {
                  // TO-DO: 재고 폐기 Alert 창 팝업
                },
              ),
            ],
          ),
        ],
      ),
    );
  }

  String formattedPrice(int price) {
    if (price == null) {
      return priceUndefined;
    }

    return NumberFormat.currency(
      locale: 'ko',
      symbol: '₩',
    )?.format(price);
  }
}