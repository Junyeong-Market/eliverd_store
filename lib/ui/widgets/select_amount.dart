import 'package:Eliverd/ui/pages/checkout_stock.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';

import 'package:Eliverd/models/models.dart';

import 'package:Eliverd/common/string.dart';
import 'package:Eliverd/common/color.dart';

class SelectAmountDialog extends StatefulWidget {
  final Stock stock;

  const SelectAmountDialog({Key key, @required this.stock}) : super(key: key);

  @override
  _SelectAmountDialogState createState() => _SelectAmountDialogState();
}

class _SelectAmountDialogState extends State<SelectAmountDialog> {
  FixedExtentScrollController amountScrollController;

  int price;
  int amount;

  @override
  void initState() {
    super.initState();

    amount = 1;
    price = widget.stock.price * amount;
    amountScrollController =
        FixedExtentScrollController(initialItem: amount - 1);
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;

    return Container(
      height: height * 0.4,
      padding: EdgeInsets.only(
        left: 16.0,
        right: 16.0,
        bottom: kBottomNavigationBarHeight,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              SizedBox(
                height: 8.0,
              ),
              Divider(
                indent: 140.0,
                endIndent: 140.0,
                height: 16.0,
                thickness: 4.0,
              ),
              SizedBox(
                height: 8.0,
              ),
              Text(
                '주문 수량 설정',
                style: TextStyle(
                  fontWeight: FontWeight.w800,
                  fontSize: 26.0,
                ),
              ),
              Text(
                '\'${widget.stock.product.name}\'를 몇 개 주문할지 설정합니다.',
                style: TextStyle(
                  fontWeight: FontWeight.w200,
                  fontSize: 16.0,
                ),
              ),
              SizedBox(
                height: 16.0,
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    '수량',
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      color: Colors.black45,
                      fontSize: 17.0,
                    ),
                  ),
                  Container(
                    width: 36.0,
                    height: 24.0,
                    child: CupertinoPicker.builder(
                      scrollController: amountScrollController,
                      itemExtent: 24.0,
                      onSelectedItemChanged: (index) {
                        setState(() {
                          amount = index + 1;
                          price = widget.stock.price * amount;
                        });
                      },
                      itemBuilder: (context, index) {
                        return Center(
                          child: Text(
                            (index + 1).toString(),
                            style: TextStyle(
                              fontWeight: FontWeight.w400,
                              fontSize: 17.0,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        );
                      },
                      childCount: widget.stock.amount + 1,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 8.0),
              Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    '결제 금액',
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      color: Colors.black45,
                      fontSize: 17.0,
                    ),
                  ),
                  Text(
                    formattedPrice,
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 20.0,
                    ),
                  ),
                ],
              ),
            ],
          ),
          Column(
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  ButtonTheme(
                    materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                    minWidth: 0,
                    height: 0,
                    child: FlatButton(
                      padding: EdgeInsets.all(0.0),
                      child: Text(
                        '취소',
                        style: TextStyle(
                          color: eliverdColor,
                          fontSize: 18.0,
                        ),
                      ),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                    ),
                  ),
                  ButtonTheme(
                    materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                    minWidth: 0,
                    height: 0,
                    child: FlatButton(
                      padding: EdgeInsets.all(0.0),
                      child: Text(
                        '주문',
                        style: TextStyle(
                          color: eliverdColor,
                          fontWeight: FontWeight.bold,
                          fontSize: 18.0,
                        ),
                      ),
                      onPressed: () {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (context) => CheckoutStockPage(
                              stock: widget.stock,
                              amount: amount,
                            ),
                          ),
                        );
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

  String get formattedPrice => NumberFormat.currency(
        locale: 'ko',
        symbol: '₩',
      ).format(price);
}

class DecimalInputFormatter extends TextInputFormatter {
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    String formattedPrice = newValue.text.replaceAll(',', '');

    int price = int.parse(formattedPrice);

    String newText = NumberFormat.decimalPattern().format(price);

    return newValue.copyWith(
        text: newText,
        selection: new TextSelection.collapsed(offset: newText.length));
  }
}
