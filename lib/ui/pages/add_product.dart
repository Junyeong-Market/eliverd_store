import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:Eliverd/bloc/stockBloc.dart';
import 'package:Eliverd/bloc/states/stockState.dart';
import 'package:Eliverd/bloc/events/stockEvent.dart';

import 'package:Eliverd/models/models.dart';

import 'package:Eliverd/common/string.dart';
import 'package:Eliverd/common/color.dart';
import 'package:Eliverd/common/key.dart';

import 'package:Eliverd/ui/widgets/header.dart';
import 'package:Eliverd/ui/widgets/form_text.dart';
import 'package:Eliverd/ui/widgets/form_text_field.dart';

class AddProductPage extends StatefulWidget {
  final Store currentStore;

  const AddProductPage({Key key, this.currentStore}) : super(key: key);

  @override
  _AddProductPageState createState() => _AddProductPageState();
}

class _AddProductPageState extends State<AddProductPage> {
  final _nameController = TextEditingController();
  final _priceController = TextEditingController();
  final _manufacturerController = TextEditingController();
  final _amountController = TextEditingController();

  bool isBarcodeAdded = false;
  bool isLastPage = false;

  String barcodeValue;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;

    return BlocBuilder<StockBloc, StockState>(
      builder: (context, state) {
        return Scaffold(
          key: AddProductPageKeys.addProductPage,
          appBar: Header(
            height: height / 4.8,
            child: Column(
              children: <Widget>[
                AppBar(
                  backgroundColor: eliverdColor,
                  elevation: 0.0,
                ),
                Align(
                  alignment: FractionalOffset(0.1, 0.0),
                  child: Text(
                    TitleStrings.addProductTitle,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 36.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          ),
          body: ListView(
            children: <Widget>[
              SizedBox(height: height / 30.0),
              Visibility(
                child: Padding(
                  padding: EdgeInsets.all(15.0),
                  child: Text(
                    ProductStrings.barcodeDescWhenImcompleted,
                    style: TextStyle(
                      fontWeight: FontWeight.w800,
                      fontSize: 28.0,
                    ),
                    textAlign: TextAlign.left,
                  ),
                ),
                maintainSize: false,
                maintainAnimation: true,
                maintainState: true,
                visible: !isBarcodeAdded,
              ),
              // TO-DO: CameraPreview 위젯을 추가하여 바코드 인식이 되도록 하기
              Visibility(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Visibility(
                      child: Padding(
                        padding: EdgeInsets.all(15.0),
                        child: Text(
                          isBarcodeAdded
                              ? ProductStrings.noBarcodeDesc
                              : ProductStrings.barcodeDesc,
                          style: TextStyle(
                            fontWeight: FontWeight.w800,
                            fontSize: 28.0,
                          ),
                        ),
                      ),
                      maintainSize: false,
                      maintainAnimation: true,
                      maintainState: true,
                      visible: true,
                    ),
                    Visibility(
                      child: Padding(
                        padding: EdgeInsets.all(15.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(
                              _nameController.text.length != 0
                                  ? ProductStrings.nameDesc
                                  : ProductStrings.nameDescWhenImcompleted,
                              style: TextStyle(
                                fontWeight: FontWeight.w800,
                                fontSize: 28.0,
                              ),
                            ),
                            SizedBox(height: height / 120.0),
                            TextField(
                              key: AddProductPageKeys.productNameTextField,
                              textInputAction: TextInputAction.done,
                              controller: _nameController,
                              enabled: _nameController.text.length == 0,
                              decoration: InputDecoration(
                                contentPadding: EdgeInsets.all(2.0),
                                isDense: true,
                              ),
                              style: TextStyle(
                                fontSize: 22.0,
                                color: Colors.black54,
                              ),
                            ),
                          ],
                        ),
                      ),
                      maintainSize: false,
                      maintainAnimation: true,
                      maintainState: true,
                      visible: isBarcodeAdded,
                    ),
                    FormText(
                      controller: _priceController,
                      textWhenCompleted: ProductStrings.priceDesc,
                      textWhenNotCompleted:
                          ProductStrings.priceDescWhenImcompleted,
                    ),
                    FormTextField(
                      key: AddProductPageKeys.productPriceTextField,
                      regex: [
                        WhitelistingTextInputFormatter.digitsOnly,
                        CurrencyInputFormatter(),
                      ],
                      isObscured: false,
                      controller: _priceController,
                      helperText: '',
                      errorMessage: null,
                    ),
                    FormText(
                      controller: _manufacturerController,
                      textWhenCompleted: ProductStrings.manufacturerDesc,
                      textWhenNotCompleted:
                          ProductStrings.manufacturerDescWhenImcompleted,
                    ),
                    Visibility(
                      child: Padding(
                        padding: EdgeInsets.all(15.0),
                        child: TextField(
                          key: AddProductPageKeys.productManufacturerTextField,
                          textInputAction: TextInputAction.done,
                          controller: _manufacturerController,
                          enabled: _manufacturerController.text.length == 0,
                          onSubmitted: _stateToLastPage,
                          decoration: InputDecoration(
                            contentPadding: EdgeInsets.all(2.0),
                            isDense: true,
                          ),
                          style: TextStyle(
                            fontSize: 22.0,
                            color: Colors.black54,
                          ),
                        ),
                      ),
                      maintainSize: false,
                      maintainAnimation: true,
                      maintainState: true,
                      visible: _priceController.text.length != 0,
                    ),
                    Visibility(
                      child: Padding(
                        padding: EdgeInsets.all(15.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(
                              _amountController.text.length != 0
                                  ? ProductStrings.amountDesc
                                  : ProductStrings.amountDescWhenImcompleted,
                              style: TextStyle(
                                fontWeight: FontWeight.w800,
                                fontSize: 28.0,
                              ),
                            ),
                            SizedBox(height: height / 120.0),
                            TextField(
                              key: AddProductPageKeys.productAmountTextField,
                              textInputAction: TextInputAction.done,
                              controller: _amountController,
                              enabled: _amountController.text.length == 0,
                              onSubmitted: _stateToLastPage,
                              decoration: InputDecoration(
                                contentPadding: EdgeInsets.all(2.0),
                                isDense: true,
                              ),
                              style: TextStyle(
                                fontSize: 22.0,
                                color: Colors.black54,
                              ),
                            ),
                          ],
                        ),
                      ),
                      maintainSize: false,
                      maintainAnimation: true,
                      maintainState: true,
                      visible: _manufacturerController.text.length != 0,
                    ),
                  ],
                ),
                maintainSize: false,
                maintainAnimation: true,
                maintainState: true,
                visible: isBarcodeAdded,
              ),
            ],
          ),
          bottomNavigationBar: Padding(
            padding: EdgeInsets.all(15.0),
            child: BottomAppBar(
              color: Colors.transparent,
              elevation: 0.0,
              child: _buildSubmitBtn(),
            ),
          ),
        );
      },
    );
  }

  String get currency =>
      NumberFormat.compactSimpleCurrency(locale: 'ko').currencySymbol;


  void _stateToBarcodeAdded() {
    setState(() {
      isBarcodeAdded = true;
    });
  }

  void _stateToLastPage(text) {
    if (text.length != 0) {
      setState(() {
        isLastPage = true;
      });
    }
  }

  void _submitProduct() {
    final stock = Stock(
      store: widget.currentStore,
      product: Product(
        name: _nameController.text,
        manufacturer: Manufacturer(
          name: _manufacturerController.text,
        ),
        ian: '', // TO-DO: 바코드 기능 구현 후 value 넣기
      ),
      price: int.parse(_priceController.text),
      amount: int.parse(_amountController.text),
    );

    context.bloc<StockBloc>().add(StockAdded(stock));

    Navigator.pop(context);
  }


  Widget _buildSubmitBtn() => CupertinoButton(
        key: AddProductPageKeys.productSubmitBtn,
        color: eliverdColor,
        disabledColor: Colors.black12,
        child: Text(
          isBarcodeAdded ? ProductStrings.submit : ProductStrings.next,
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 20.0,
          ),
        ),
        onPressed: isBarcodeAdded
            ? (isLastPage ? _submitProduct : null)
            : _stateToBarcodeAdded,
        borderRadius: BorderRadius.circular(25.0),
      );
}

class CurrencyInputFormatter extends TextInputFormatter {
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    String formattedPrice = newValue.text.replaceAll(',', '');

    int price = int.parse(formattedPrice);

    String newText = NumberFormat.currency(
      locale: 'ko',
      symbol: '',
    ).format(price);

    return newValue.copyWith(
        text: newText,
        selection: new TextSelection.collapsed(offset: newText.length));
  }
}
