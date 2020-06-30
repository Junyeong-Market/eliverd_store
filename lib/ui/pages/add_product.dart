import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:barcode_flutter/barcode_flutter.dart';

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
  String _barcodeIan = '';
  final _nameController = TextEditingController();
  final _priceController = TextEditingController();
  final _manufacturerController = TextEditingController();
  final _amountController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
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
            padding: EdgeInsets.symmetric(
              horizontal: 20.0,
            ),
            children: <Widget>[
              SizedBox(height: height / 16.0),
              Visibility(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      ProductStrings.barcodeDescWhenImcompleted,
                      style: TextStyle(
                        fontWeight: FontWeight.w800,
                        fontSize: 28.0,
                      ),
                      textAlign: TextAlign.left,
                    ),
                    SizedBox(height: height / 120.0),
                    Center(
                      child: Container(
                        height: height / 4.0,
                        width: width / 1.12,
                        padding: EdgeInsets.all(2.0),
                        child: CupertinoButton(
                          child: Text(
                            '바코드 등록',
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 18.0,
                            ),
                          ),
                          color: Colors.black12,
                          borderRadius: BorderRadius.circular(15.0),
                          onPressed: _scanBarcode,
                        ),
                      ),
                    ),
                  ],
                ),
                maintainSize: false,
                maintainAnimation: true,
                maintainState: true,
                visible: _barcodeIan.length == 0,
              ),
              Visibility(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      _barcodeIan.length != 0
                          ? ProductStrings.barcodeDesc
                          : ProductStrings.noBarcodeDesc,
                      style: TextStyle(
                        fontWeight: FontWeight.w800,
                        fontSize: 28.0,
                      ),
                    ),
                    SizedBox(height: height / 120.0),
                    Center(
                      child: BarCodeImage(
                        params: EAN13BarCodeParams(
                          _barcodeIan,
                          withText: true,
                        ),
                      ),
                    ),
                  ],
                ),
                maintainSize: false,
                maintainAnimation: true,
                maintainState: true,
                visible: _barcodeIan.length != 0,
              ),
              SizedBox(height: height / 48.0),
              Visibility(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    FormText(
                      controller: _nameController,
                      textWhenCompleted: ProductStrings.nameDesc,
                      textWhenNotCompleted:
                          ProductStrings.nameDescWhenImcompleted,
                    ),
                    SizedBox(height: height / 120.0),
                    FormTextField(
                      key: AddProductPageKeys.productNameTextField,
                      controller: _nameController,
                    ),
                  ],
                ),
                maintainSize: false,
                maintainAnimation: true,
                maintainState: true,
                visible: _barcodeIan.length != 0,
              ),
              SizedBox(height: height / 48.0),
              Visibility(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    FormText(
                      controller: _priceController,
                      textWhenCompleted: ProductStrings.priceDesc,
                      textWhenNotCompleted:
                          ProductStrings.priceDescWhenImcompleted,
                    ),
                    SizedBox(height: height / 120.0),
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
                  ],
                ),
                maintainSize: false,
                maintainAnimation: true,
                maintainState: true,
                visible: _nameController.text.length != 0,
              ),
              Visibility(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    FormText(
                      controller: _manufacturerController,
                      textWhenCompleted: ProductStrings.manufacturerDesc,
                      textWhenNotCompleted:
                          ProductStrings.manufacturerDescWhenImcompleted,
                    ),
                    SizedBox(height: height / 120.0),
                    FormTextField(
                      key: AddProductPageKeys.productManufacturerTextField,
                      controller: _manufacturerController,
                    ),
                  ],
                ),
                maintainSize: false,
                maintainAnimation: true,
                maintainState: true,
                visible: _priceController.text.length != 0,
              ),
              SizedBox(height: height / 48.0),
              Visibility(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    FormText(
                      controller: _amountController,
                      textWhenCompleted: ProductStrings.amountDesc,
                      textWhenNotCompleted:
                          ProductStrings.amountDescWhenImcompleted,
                    ),
                    SizedBox(height: height / 120.0),
                    FormTextField(
                      key: AddProductPageKeys.productAmountTextField,
                      controller: _amountController,
                    ),
                  ],
                ),
                maintainSize: false,
                maintainAnimation: true,
                maintainState: true,
                visible: _manufacturerController.text.length != 0,
              ),
            ],
          ),
          bottomNavigationBar: Visibility(
            child: Padding(
              padding: EdgeInsets.all(15.0),
              child: BottomAppBar(
                color: Colors.transparent,
                elevation: 0.0,
                child: _buildSubmitBtn(),
              ),
            ),
            visible: _barcodeIan.length != 0,
          ),
        );
      },
    );
  }

  String get currency =>
      NumberFormat.compactSimpleCurrency(locale: 'ko').currencySymbol;

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

  Future<void> _scanBarcode() async {
    String barcodeIan;

    try {
      barcodeIan = await FlutterBarcodeScanner.scanBarcode(
          "#ff6666", "Cancel", true, ScanMode.BARCODE);
    } on PlatformException {
      barcodeIan = 'Failed to get platform version.';
    }

    if (!mounted) return;

    setState(() {
      _barcodeIan = barcodeIan;
    });
  }

  Widget _buildSubmitBtn() => CupertinoButton(
        key: AddProductPageKeys.productSubmitBtn,
        color: eliverdColor,
        disabledColor: Colors.black12,
        child: Text(
          ProductStrings.submit,
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 20.0,
          ),
        ),
        onPressed: _amountController.text.length != 0 ? _submitProduct : null,
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
      symbol: '₩',
    ).format(price);

    return newValue.copyWith(
        text: newText,
        selection: new TextSelection.collapsed(offset: newText.length));
  }
}
