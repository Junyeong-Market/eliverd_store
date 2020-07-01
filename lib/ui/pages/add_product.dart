import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:barcode_widget/barcode_widget.dart';

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

  bool _isBarcodeRegistered = false;
  bool _isLastPage = false;

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;

    return BlocConsumer<StockBloc, StockState>(
      listener: (context, state) {},
      builder: (context, state) {
        return Scaffold(
          key: AddProductPageKeys.addProductPage,
          appBar: Header(
            height: height / 4.8,
            child: Column(
              children: <Widget>[
                AppBar(
                  leading: ButtonTheme(
                    materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                    minWidth: 0,
                    height: 0,
                    child: FlatButton(
                      padding: EdgeInsets.all(0.0),
                      key: HomePageKeys.searchProductBtn,
                      textColor: Colors.white,
                      splashColor: Colors.transparent,
                      highlightColor: Colors.transparent,
                      child: Text(
                        '􀆉',
                        style: TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: 24.0,
                        ),
                      ),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                    ),
                  ),
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
              _buildRegisterBarcodeSection(width, height),
              _buildBarcodeSection(width, height),
              SizedBox(height: height / 48.0),
              _buildNameSection(height),
              SizedBox(height: height / 48.0),
              _buildPriceSection(height),
              SizedBox(height: height / 48.0),
              _buildManufacturerSection(height),
              SizedBox(height: height / 48.0),
              _buildAmountSection(height),
            ],
          ),
          bottomNavigationBar: Padding(
            padding: EdgeInsets.all(20.0),
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

  void _registerBarcode() {
    setState(() {
      _isBarcodeRegistered = true;
    });
  }

  void _submitActivate(value) {
    setState(() {
      _isLastPage = true;
    });
  }

  void _submitProduct() {
    final stock = Stock(
      store: widget.currentStore,
      product: Product(
        name: _nameController.text,
        manufacturer: Manufacturer(
          name: _manufacturerController.text,
        ),
        ian: _barcodeIan,
      ),
      price: int.parse(_priceController.text.replaceAll(',', '')),
      amount: int.parse(_amountController.text.replaceAll(',', '')),
    );

    context.bloc<StockBloc>().add(StockAdded(stock));
  }

  Future<void> _scanBarcode() async {
    String barcodeIan;

    try {
      barcodeIan = await FlutterBarcodeScanner.scanBarcode(
          "#ff6666", "Cancel", true, ScanMode.BARCODE);
    } on PlatformException {
      throw Exception('Failed to get platform version.');
    }

    if (!mounted) return;

    setState(() {
      _barcodeIan = barcodeIan;
    });
  }

  Widget _buildRegisterBarcodeSection(double width, double height) =>
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
                height: height / 4.8,
                width: width,
                child: CupertinoButton(
                  child: Image(
                    image: AssetImage('assets/images/camera.png'),
                  ),
                  color: Colors.black12.withOpacity(0.05),
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
        visible: !_isBarcodeRegistered,
      );

  Widget _buildBarcodeSection(double width, double height) => Visibility(
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
              child: _barcodeIan.length != 0
                  ? BarcodeWidget(
                      barcode: Barcode.ean13(),
                      data: _barcodeIan,
                      width: width / 1.2,
                      height: height / 24.0,
                      drawText: true,
                      style: TextStyle(
                        fontSize: 10.0,
                      ),
                      errorBuilder: (context, error) =>
                          Center(child: Text(error)),
                    )
                  : null,
            ),
          ],
        ),
        maintainSize: false,
        maintainAnimation: true,
        maintainState: true,
        visible: _isBarcodeRegistered,
      );

  Widget _buildNameSection(double height) => Visibility(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            FormText(
              controller: _nameController,
              textWhenCompleted: ProductStrings.nameDesc,
              textWhenNotCompleted: ProductStrings.nameDescWhenImcompleted,
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
        visible: _isBarcodeRegistered,
      );

  Widget _buildPriceSection(double height) => Visibility(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            FormText(
              controller: _priceController,
              textWhenCompleted: ProductStrings.priceDesc,
              textWhenNotCompleted: ProductStrings.priceDescWhenImcompleted,
            ),
            SizedBox(height: height / 120.0),
            TextField(
              key: AddProductPageKeys.productPriceTextField,
              textInputAction: TextInputAction.done,
              inputFormatters: [
                WhitelistingTextInputFormatter.digitsOnly,
                DecimalInputFormatter(),
              ],
              controller: _priceController,
              decoration: InputDecoration(
                contentPadding: EdgeInsets.all(2.0),
                isDense: true,
                prefixText: currency,
              ),
              style: TextStyle(
                fontSize: 22.0,
                color: Colors.black54,
              ),
            ),
          ],
        ),
        maintainSize: false,
        maintainAnimation: true,
        maintainState: true,
        visible: _nameController.text.length != 0,
      );

  Widget _buildManufacturerSection(double height) => Visibility(
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
      );

  Widget _buildAmountSection(double height) => Visibility(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            FormText(
              controller: _amountController,
              textWhenCompleted: ProductStrings.amountDesc,
              textWhenNotCompleted: ProductStrings.amountDescWhenImcompleted,
            ),
            SizedBox(height: height / 120.0),
            FormTextField(
              key: AddProductPageKeys.productAmountTextField,
              regex: [
                WhitelistingTextInputFormatter.digitsOnly,
                DecimalInputFormatter(),
              ],
              controller: _amountController,
              onSubmitted: _submitActivate,
            ),
          ],
        ),
        maintainSize: false,
        maintainAnimation: true,
        maintainState: true,
        visible: _manufacturerController.text.length != 0,
      );

  Widget _buildSubmitBtn() => CupertinoButton(
        key: AddProductPageKeys.productSubmitBtn,
        color: eliverdColor,
        disabledColor: Colors.black12,
        child: Text(
          _isBarcodeRegistered ? ProductStrings.submit : ProductStrings.next,
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 18.0,
          ),
        ),
        onPressed: _isLastPage
            ? _submitProduct
            : (!_isBarcodeRegistered ? _registerBarcode : null),
        borderRadius: BorderRadius.circular(25.0),
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
