import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:barcode_widget/barcode_widget.dart';
import 'package:intl/intl.dart';

import 'package:Eliverd/bloc/events/stockEvent.dart';
import 'package:Eliverd/bloc/states/stockState.dart';
import 'package:Eliverd/bloc/stockBloc.dart';

import 'package:Eliverd/models/models.dart';

import 'package:Eliverd/ui/widgets/category.dart';
import 'package:Eliverd/ui/widgets/update_stock.dart';
import 'package:Eliverd/ui/widgets/select_amount.dart';

import 'package:Eliverd/common/color.dart';
import 'package:Eliverd/common/string.dart';

class StockOnOrder extends StatelessWidget {
  final OrderedStock orderedStock;

  const StockOnOrder({Key key, this.orderedStock}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;

    return Padding(
      padding: EdgeInsets.only(
        left: 0.0,
        right: 0.0,
        top: 8.0,
        bottom: 0.0,
      ),
      child: Row(
        children: <Widget>[
          Flexible(
            flex: 1,
            child: ConstrainedBox(
              constraints: BoxConstraints.expand(
                height: width * 0.25,
              ),
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.black12,
                  borderRadius: BorderRadius.circular(10.0),
                ),
                child: Center(
                  child: Text(
                    '사진 없음',
                    style: const TextStyle(
                      color: Colors.black45,
                      fontSize: 12.0,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
            ),
          ),
          SizedBox(width: 4.0),
          Flexible(
            flex: 3,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      orderedStock.stock.product.manufacturer.name,
                      maxLines: 1,
                      textAlign: TextAlign.left,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        color: Colors.black45,
                        fontWeight: FontWeight.w500,
                        fontSize: 13.0,
                      ),
                    ),
                    Text(
                      orderedStock.stock.product.name,
                      maxLines: 1,
                      textAlign: TextAlign.left,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        color: Colors.black87,
                        fontWeight: FontWeight.w600,
                        fontSize: 17.0,
                      ),
                    ),
                    SizedBox(height: 1.6),
                    CategoryWidget(
                      categoryId: orderedStock.stock.product.category,
                      fontSize: 9.0,
                      padding: 2.0,
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Row(
                      children: [
                        Text(
                          '수량 ${orderedStock.amount}개',
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 17.0,
                          ),
                        ),
                      ],
                    ),
                    Flexible(
                      fit: FlexFit.loose,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text(
                            '${formattedPrice(orderedStock.stock.price)} * ${orderedStock.amount}',
                            maxLines: 1,
                            textAlign: TextAlign.left,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              color: Colors.black45,
                              fontWeight: FontWeight.w500,
                              fontSize: 10.0,
                            ),
                          ),
                          Text(
                            formattedPrice(
                                orderedStock.stock.price * orderedStock.amount),
                            maxLines: 1,
                            textAlign: TextAlign.left,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: 19.0,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  String formattedPrice(int price) {
    return NumberFormat.currency(
      locale: 'ko',
      symbol: '₩',
    )?.format(price);
  }
}

class StockWidget extends StatefulWidget {
  final Stock stock;

  const StockWidget({Key key, @required this.stock}) : super(key: key);

  @override
  _StockWidgetState createState() => _StockWidgetState();
}

class _StockWidgetState extends State<StockWidget> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<StockBloc, StockState>(
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
          child: Padding(
            padding: EdgeInsets.only(
              left: 12.0,
              top: 16.0,
              bottom: 8.0,
              right: 16.0,
            ),
            child: Column(
              children: <Widget>[
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Flexible(
                      flex: 2,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Row(
                            children: [
                              Flexible(
                                child: Text(
                                  widget.stock.product.name,
                                  maxLines: 1,
                                  textAlign: TextAlign.left,
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 18.0,
                                  ),
                                ),
                              ),
                              SizedBox(
                                width: 4.0,
                              ),
                              CategoryWidget(
                                categoryId: widget.stock.product.category,
                                fontSize: 9.0,
                                padding: 2.0,
                              ),
                            ],
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
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: <Widget>[
                        Text(
                          formattedPrice(widget.stock.price),
                          maxLines: 1,
                          textAlign: TextAlign.right,
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 20.0,
                          ),
                        ),
                        _buildAmountText(widget.stock.amount),
                      ],
                    ),
                  ],
                ),
                SizedBox(height: 4.0),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    _buildBarcodeImage(),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        ButtonTheme(
                          materialTapTargetSize:
                              MaterialTapTargetSize.shrinkWrap,
                          minWidth: 0,
                          height: 0,
                          child: FlatButton(
                            padding: EdgeInsets.all(1.0),
                            textColor: eliverdColor,
                            child: Text(
                              '􀈎',
                              style: TextStyle(
                                fontWeight: FontWeight.w400,
                                fontSize: 24.0,
                              ),
                            ),
                            onPressed: () {
                              showModalBottomSheet(
                                context: context,
                                builder: (context) => UpdateStockDialog(
                                  stock: widget.stock,
                                  currentStore: widget.stock.store,
                                ),
                                isScrollControlled: true,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(30.0),
                                    topRight: Radius.circular(30.0),
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                        ButtonTheme(
                          materialTapTargetSize:
                              MaterialTapTargetSize.shrinkWrap,
                          minWidth: 0,
                          height: 0,
                          child: FlatButton(
                            padding: EdgeInsets.all(1.0),
                            textColor: eliverdColor,
                            child: Text(
                              '􀍯',
                              style: TextStyle(
                                fontWeight: FontWeight.w400,
                                fontSize: 24.0,
                              ),
                            ),
                            onPressed: () {
                              showModalBottomSheet(
                                context: context,
                                builder: (context) => SelectAmountDialog(
                                  stock: widget.stock,
                                ),
                                isScrollControlled: true,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(30.0),
                                    topRight: Radius.circular(30.0),
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                        ButtonTheme(
                          materialTapTargetSize:
                              MaterialTapTargetSize.shrinkWrap,
                          minWidth: 0,
                          height: 0,
                          child: FlatButton(
                            padding: EdgeInsets.all(1.0),
                            textColor: eliverdColor,
                            child: Text(
                              '􀈑',
                              style: TextStyle(
                                fontWeight: FontWeight.w400,
                                fontSize: 24.0,
                              ),
                            ),
                            onPressed: () {
                              showDeleteProductAlertDialog(
                                  context, widget.stock);
                            },
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildBarcodeImage() => BarcodeWidget(
        barcode: Barcode.ean13(),
        data: widget.stock.product.ian,
        width: 110,
        height: 45,
        drawText: true,
        style: TextStyle(
          fontSize: 11.0,
        ),
        errorBuilder: (context, error) => Text(
          ProductStrings.noBarcodeDesc,
          style: TextStyle(
            fontSize: 14.0,
            fontWeight: FontWeight.w500,
          ),
        ),
      );

  Widget _buildAmountText(int amount) {
    return Text(
      '현재 $amount개 남음',
      style: TextStyle(
        color: Colors.black,
        fontWeight: FontWeight.w300,
        fontSize: 14.0,
      ),
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
      context.bloc<StockBloc>().add(DeleteStock(stock));
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
      context.bloc<StockBloc>().add(DeleteStock(stock));
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
    showCupertinoDialog(
      context: context,
      builder: (BuildContext context) {
        return cupertinoAlertDialog;
      },
    );
  }
}
