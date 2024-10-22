import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:Eliverd/bloc/events/stockEvent.dart';
import 'package:Eliverd/bloc/stockBloc.dart';

import 'package:Eliverd/models/models.dart';

import 'package:Eliverd/common/string.dart';
import 'package:Eliverd/common/color.dart';
import 'package:Eliverd/common/key.dart';

import 'package:Eliverd/ui/widgets/form_text_field.dart';

class UpdateStockDialog extends StatefulWidget {
  final Stock stock;
  final Store currentStore;

  const UpdateStockDialog(
      {Key key, @required this.stock, @required this.currentStore})
      : super(key: key);

  @override
  _UpdateStockDialogState createState() => _UpdateStockDialogState();
}

class _UpdateStockDialogState extends State<UpdateStockDialog> {
  final _priceController = TextEditingController();
  final _amountController = TextEditingController();

  int _initialAmount;

  bool _isPriceSubmitted = false;
  bool _isAmountSubmitted = false;

  @override
  void initState() {
    super.initState();

    _priceController.text =
        NumberFormat.decimalPattern().format(widget.stock.price);
    _amountController.text = widget.stock.amount.toString();

    _initialAmount = widget.stock.amount;
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;

    return Container(
      height: height * 0.7,
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
                TitleStrings.updateStockTitle,
                style: TextStyle(
                  fontWeight: FontWeight.w800,
                  fontSize: 26.0,
                ),
              ),
              Text(
                '\'${widget.stock.product.name}\'에 대한 정보를 수정합니다.',
                style: TextStyle(
                  fontWeight: FontWeight.w200,
                  fontSize: 16.0,
                ),
              ),
              SizedBox(
                height: 16.0,
              ),
              _buildPriceSection(height),
              _buildAmountSection(height),
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
                        BottomSheetStrings.cancel,
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
                        BottomSheetStrings.proceed,
                        style: TextStyle(
                          color: eliverdColor,
                          fontWeight: FontWeight.bold,
                          fontSize: 18.0,
                        ),
                      ),
                      onPressed: _isAmountSubmitted
                          ? () {
                              _submitProduct();
                              Navigator.pop(context);
                            }
                          : null,
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

  String get currency =>
      NumberFormat.compactSimpleCurrency(locale: 'ko').currencySymbol;

  void _submitProduct() async {
    final newStock = widget.stock.copyWith(
      price: int.parse(_priceController.text.replaceAll(',', '')),
      amount: int.parse(
            _amountController.text.replaceAll(',', ''),
          ) -
          _initialAmount,
    );

    context.bloc<StockBloc>().add(UpdateStock(newStock));

    await Future.delayed(Duration(seconds: 1));
  }

  Widget _buildPriceSection(double height) => Visibility(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              _isPriceSubmitted
                  ? ProductStrings.priceDesc
                  : ProductStrings.priceDescWhenUpdate,
              style: TextStyle(
                fontWeight: FontWeight.w800,
                fontSize: 22.0,
              ),
            ),
            SizedBox(
              height: 4.0,
            ),
            FormTextField(
              key: UpdateStockPageKeys.productPriceTextField,
              regex: [
                WhitelistingTextInputFormatter.digitsOnly,
                DecimalInputFormatter(),
              ],
              controller: _priceController,
              isEnabled: !_isPriceSubmitted,
              onSubmitted: (value) {
                setState(() {
                  _isPriceSubmitted = true;
                });
              },
              prefixText: currency,
            ),
          ],
        ),
        maintainSize: false,
        maintainAnimation: true,
        maintainState: true,
        visible: true,
      );

  Widget _buildAmountSection(double height) => Visibility(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              _isAmountSubmitted
                  ? ProductStrings.amountDesc
                  : ProductStrings.amountDescWhenUpdate,
              style: TextStyle(
                fontWeight: FontWeight.w800,
                fontSize: 22.0,
              ),
            ),
            SizedBox(
              height: 4.0,
            ),
            FormTextField(
              key: UpdateStockPageKeys.productAmountTextField,
              regex: [
                WhitelistingTextInputFormatter.digitsOnly,
                DecimalInputFormatter(),
              ],
              controller: _amountController,
              isEnabled: !_isAmountSubmitted,
              onSubmitted: (value) {
                setState(() {
                  _isAmountSubmitted = true;
                });
              },
            ),
          ],
        ),
        maintainSize: false,
        maintainAnimation: true,
        maintainState: true,
        visible: _isPriceSubmitted,
      );
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
