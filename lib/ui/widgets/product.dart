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
    return new Card(
      margin: EdgeInsets.zero,
      elevation: 0.0,
      color: Colors.transparent,
      shape: Border(
        bottom: BorderSide(
          color: Colors.black12,
          width: 1,
        ),
      ),
      child: Column(
        children: <Widget>[
          Padding(
            padding: EdgeInsets.only(
              left: 12.0,
              top: 12.0,
              right: 15.0,
            ),
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
                          fontSize: 18.0,
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
                    fontWeight: FontWeight.w600,
                    fontSize: 20.0,
                  ),
                ),
              ],
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: <Widget>[
              Image(
                width: 100.0,
                height: 50.0,
                image: AssetImage('assets/images/barcode_example.png'),
              ),
              ButtonBar(
                buttonMinWidth: 25.0,
                buttonHeight: 25.0,
                buttonPadding: EdgeInsets.all(0.0),
                children: <Widget>[
                  ButtonTheme(
                    minWidth: 25.0,
                    height: 25.0,
                    child: FlatButton(
                      padding: EdgeInsets.all(0.0),
                      textColor: Colors.blue,
                      child: Text(
                        '􀈎',
                        style: TextStyle(
                          fontWeight: FontWeight.w400,
                          fontSize: 22.0,
                        ),
                      ),
                      onPressed: () {
                        Navigator.push(
                          context, MaterialPageRoute(builder: (context) => UpdateProductPage()));
                      },
                    ),
                  ),
                  ButtonTheme(
                    minWidth: 25.0,
                    height: 25.0,
                    child: FlatButton(
                      padding: EdgeInsets.all(0.0),
                      textColor: Colors.blue,
                      child: Text(
                        '􀈕',
                        style: TextStyle(
                          fontWeight: FontWeight.w400,
                          fontSize: 22.0,
                        ),
                      ),
                      onPressed: () {
                        // TO-DO: 상품 결제 페이지로 Navigate
                      },
                    ),
                  ),
                  ButtonTheme(
                    minWidth: 25.0,
                    height: 25.0,
                    child: FlatButton(
                      padding: EdgeInsets.all(0.0),
                      textColor: Colors.blue,
                      child: Text(
                        '􀈑',
                        style: TextStyle(
                          fontWeight: FontWeight.w400,
                          fontSize: 22.0,
                        ),
                      ),
                      onPressed: () {
                        showDeleteProductAlertDialog(context, widget.name);
                      },
                    ),
                  ),
                ],
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

// TO-DO: BLOC 구현 후 요청된 Product 개체를 매개변수로 받도록 수정(productTitle)
showDeleteProductAlertDialog(BuildContext context, String productTitle) {
  Widget cancelButton = CupertinoButton(
    child: Text(
      cancel,
      style: TextStyle(
        color: Colors.blue,
        fontWeight: FontWeight.w400,
      ),
    ),
    onPressed: () {
      Navigator.pop(context);
    },
  );

  Widget deleteButton = CupertinoButton(
    child: Text(
      delete,
      style: TextStyle(
        color: Colors.blue,
        fontWeight: FontWeight.w700,
      ),
    ),
    onPressed: () {
      // TO-DO: Product 삭제 BLOC 구현 및 불러오기
      Navigator.pop(context);
    },
  );

  CupertinoAlertDialog alertDialog = CupertinoAlertDialog(
    title: Text(
      productTitle + "을(를) 삭제하시겠습니까?",
      style: TextStyle(
        fontWeight: FontWeight.w600,
        fontSize: 18.0,
      ),
    ),
    content: Text(
      deleteWarningContent,
      style: TextStyle(
        fontWeight: FontWeight.w400,
        fontSize: 14.0,
      ),
    ),
    actions: <Widget>[
      cancelButton,
      deleteButton,
    ],
  );

  showDialog(
    context: context,
    builder: (BuildContext context) {
      return alertDialog;
    },
  );
}