import 'package:Eliverd/bloc/events/stockEvent.dart';
import 'package:Eliverd/bloc/states/stockState.dart';
import 'package:Eliverd/bloc/stockBloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'dart:io' show Platform;

import 'package:intl/intl.dart';

import 'package:Eliverd/models/models.dart';

import 'package:Eliverd/common/string.dart';
import 'package:Eliverd/common/color.dart';

import 'package:Eliverd/ui/pages/update_product.dart';

class ProductCard extends StatefulWidget {
  final Stock stock;

  const ProductCard({Key key, this.stock}) : super(key: key);

  @override
  _ProductCardState createState() => _ProductCardState();
}

class _ProductCardState extends State<ProductCard> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider<StockBloc>.value(
      value: context.bloc<StockBloc>(),
      child: BlocConsumer<StockBloc, StockState>(
          listener: (context, state) {},
          builder: (context, state) {
            return Card(
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
                                widget.stock.product.name,
                                maxLines: 1,
                                textAlign: TextAlign.left,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 18.0,
                                ),
                              ),
                              Text(
                                widget.stock.product.manufacturer.name,
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
                          formattedPrice(widget.stock.price),
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
                            padding: EdgeInsets.all(3.0),
                            materialTapTargetSize:
                                MaterialTapTargetSize.shrinkWrap,
                            minWidth: 0,
                            height: 0,
                            child: FlatButton(
                              textColor: eliverdColor,
                              child: Text(
                                '􀈎',
                                style: TextStyle(
                                  fontWeight: FontWeight.w400,
                                  fontSize: 22.0,
                                ),
                              ),
                              onPressed: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            UpdateProductPage()));
                              },
                            ),
                          ),
                          ButtonTheme(
                            padding: EdgeInsets.all(3.0),
                            materialTapTargetSize:
                                MaterialTapTargetSize.shrinkWrap,
                            minWidth: 0,
                            height: 0,
                            child: FlatButton(
                              textColor: eliverdColor,
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
                              textColor: eliverdColor,
                              child: Text(
                                '􀈑',
                                style: TextStyle(
                                  fontWeight: FontWeight.w400,
                                  fontSize: 22.0,
                                ),
                              ),
                              onPressed: () {
                                showDeleteProductAlertDialog(
                                    context, widget.stock);
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
          }),
    );
  }

  String formattedPrice(int price) {
    return NumberFormat.currency(
      locale: 'ko',
      symbol: '₩',
    )?.format(price);
  }
}

showDeleteProductAlertDialog(BuildContext context, Stock stock) {
  Widget cancelButton = FlatButton(
    child: Text(
      ProductStrings.cancel,
      style: TextStyle(
        color: eliverdColor,
        fontWeight: FontWeight.w400,
      ),
    ),
    onPressed: () {
      Navigator.pop(context);
    },
  );

  Widget deleteButton = FlatButton(
    child: Text(
      ProductStrings.delete,
      style: TextStyle(
        color: eliverdColor,
        fontWeight: FontWeight.w700,
      ),
    ),
    onPressed: () {
      context.bloc<StockBloc>().add(StockDeleted(stock));
      Navigator.pop(context);
    },
  );

  Widget cupertinoCancelButton = CupertinoButton(
    child: Text(
      ProductStrings.cancel,
      style: TextStyle(
        color: eliverdColor,
        fontWeight: FontWeight.w400,
      ),
    ),
    onPressed: () {
      Navigator.pop(context);
    },
  );

  Widget cupertinoDeleteButton = CupertinoButton(
    child: Text(
      ProductStrings.delete,
      style: TextStyle(
        color: eliverdColor,
        fontWeight: FontWeight.w700,
      ),
    ),
    onPressed: () {
      context.bloc<StockBloc>().add(StockDeleted(stock));
      Navigator.pop(context);
    },
  );

  AlertDialog alertDialog = AlertDialog(
    title: Text(
      stock.product.name + "을(를) 삭제하시겠습니까?",
      style: TextStyle(
        fontWeight: FontWeight.w600,
        fontSize: 18.0,
      ),
    ),
    content: Text(
      ProductStrings.deleteWarningContent,
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

  CupertinoAlertDialog cupertinoAlertDialog = CupertinoAlertDialog(
    title: Text(
      stock.product.name + "을(를) 삭제하시겠습니까?",
      style: TextStyle(
        fontWeight: FontWeight.w600,
        fontSize: 18.0,
      ),
    ),
    content: Text(
      ProductStrings.deleteWarningContent,
      style: TextStyle(
        fontWeight: FontWeight.w400,
        fontSize: 14.0,
      ),
    ),
    actions: <Widget>[
      cupertinoCancelButton,
      cupertinoDeleteButton,
    ],
  );

  if (Platform.isAndroid) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alertDialog;
      },
    );
  } else if (Platform.isIOS) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return cupertinoAlertDialog;
      },
    );
  }
}
