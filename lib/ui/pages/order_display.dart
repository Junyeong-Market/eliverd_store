import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:Eliverd/models/models.dart';

import 'package:Eliverd/ui/widgets/order.dart';

class OrderDisplayPage extends StatefulWidget {
  final Order order;

  const OrderDisplayPage({Key key, this.order}) : super(key: key);

  @override
  _OrderDisplayPageState createState() => _OrderDisplayPageState();
}

class _OrderDisplayPageState extends State<OrderDisplayPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: ButtonTheme(
          materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
          minWidth: 0,
          height: 0,
          child: FlatButton(
            padding: EdgeInsets.all(0.0),
            textColor: Colors.black,
            splashColor: Colors.transparent,
            highlightColor: Colors.transparent,
            child: Text(
              '􀆉',
              style: TextStyle(
                fontWeight: FontWeight.w200,
                fontSize: 24.0,
              ),
            ),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ),
        brightness: Brightness.light,
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        title: Text(
          '주문 상세 조회',
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.w800,
          ),
        ),
      ),
      body: ListView(
        children: [
          OrderWidget(
            order: widget.order,
          ),
        ],
      ),
    );
  }
}
