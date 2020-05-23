import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

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
    return new Card(
      margin: EdgeInsets.all(0.0),
      child: Container(
        child: Column(
          children: <Widget>[
            ListTile(
              title: Text(widget.name),
              subtitle: Text(widget.manufacturer),
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

                  },
                ),
                IconButton(
                  icon: const Icon(Icons.delete),
                  tooltip: deleteProductDesc,
                  onPressed: () {

                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}