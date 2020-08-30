import 'dart:ui';

import 'package:Eliverd/ui/widgets/category.dart';
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
import 'package:Eliverd/ui/pages/home.dart';
import 'package:Eliverd/ui/widgets/search_manufacturer.dart';
import 'package:Eliverd/ui/widgets/select_category.dart';

class AddStockPage extends StatefulWidget {
  final Store store;

  const AddStockPage({Key key, @required this.store}) : super(key: key);

  @override
  _AddStockPageState createState() => _AddStockPageState();
}

class _AddStockPageState extends State<AddStockPage> {
  String _barcodeIan = '';
  Manufacturer _manufacturer;
  Category _category;

  final _nameController = TextEditingController();
  final _priceController = TextEditingController();
  final _amountController = TextEditingController();

  bool _isBarcodeRegistered = false;

  final _nameNavigationFocus = FocusNode();
  final _priceNavigationFocus = FocusNode();
  final _amountNavigationFocus = FocusNode();

  bool _isNameSubmitted = false;
  bool _isPriceSubmitted = false;
  bool _isAmountSubmitted = false;

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;

    return BlocBuilder<StockBloc, StockState>(
      builder: (context, state) {
        return Scaffold(
          key: AddStockPageKeys.addStockPage,
          extendBodyBehindAppBar: true,
          appBar: Header(
            onBackButtonPressed: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => HomePage(
                    store: widget.store,
                  ),
                ),
              );
            },
            title: TitleStrings.addStockTitle,
          ),
          body: ListView(
            padding: EdgeInsets.symmetric(
              horizontal: 16.0,
            ),
            children: <Widget>[
              SizedBox(
                height: kToolbarHeight + 128.0,
              ),
              _buildRegisterBarcodeSection(width, height),
              _buildBarcodeSection(width, height),
              SizedBox(
                height: 8.0,
              ),
              _buildNameSection(height),
              _buildPriceSection(height),
              _buildAmountSection(height),
              _buildManufacturerSection(height),
              SizedBox(
                height: 8.0,
              ),
              _buildSelectedManufacturerText(),
              SizedBox(
                height: 16.0,
              ),
              _buildCategorySection(height),
              SizedBox(
                height: 8.0,
              ),
              _buildCategoryText(),
            ],
          ),
          bottomNavigationBar: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: 8.0,
            ),
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

      _nameNavigationFocus.requestFocus();
    });
  }

  void _onManufacturerChanged(Manufacturer manufacturer) {
    setState(() {
      _manufacturer = manufacturer;
    });
  }

  void _onCategoryChanged(Category category) {
    setState(() {
      _category = category;
    });
  }

  void _submitProduct() async {
    final stock = Stock(
      store: widget.store,
      product: Product(
        name: _nameController.text,
        manufacturer: _manufacturer,
        ian: _barcodeIan,
        category: _category.id,
      ),
      price: int.parse(_priceController.text.replaceAll(',', '')),
      amount: int.parse(_amountController.text.replaceAll(',', '')),
    );

    context.bloc<StockBloc>().add(AddStock(stock));

    await Future.delayed(Duration(milliseconds: 500));

    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => HomePage(
          store: widget.store,
        ),
      ),
    );
  }

  Future<void> _scanBarcode() async {
    String barcodeIan;

    try {
      barcodeIan = await FlutterBarcodeScanner.scanBarcode(
          "#ff6666", "취소", true, ScanMode.BARCODE);
    } on PlatformException {
      throw Exception('Failed to get platform version.');
    }

    if (!mounted) return;

    setState(() {
      _barcodeIan = barcodeIan;
    });

    _registerBarcode();
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
            SizedBox(
              height: 8.0,
            ),
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
                fontSize: 26.0,
              ),
            ),
            SizedBox(
              height: 8.0,
            ),
            Center(
              child: _barcodeIan.length != 0
                  ? BarcodeWidget(
                      barcode: Barcode.ean13(),
                      data: _barcodeIan,
                      height: height * 0.12,
                      drawText: true,
                      style: TextStyle(
                        fontSize: 18.0,
                        fontWeight: FontWeight.w400,
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
            SizedBox(
              height: 8.0,
            ),
            FormTextField(
              key: AddStockPageKeys.productNameTextField,
              controller: _nameController,
              isEnabled: !_isNameSubmitted,
              focusNode: _nameNavigationFocus,
              onSubmitted: (String value) {
                if (value.length != 0) {
                  setState(() {
                    _isNameSubmitted = true;
                  });

                  _priceNavigationFocus.requestFocus();
                }
              },
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
            SizedBox(
              height: 8.0,
            ),
            FormTextField(
              key: AddStockPageKeys.productPriceTextField,
              regex: [
                WhitelistingTextInputFormatter.digitsOnly,
                DecimalInputFormatter(),
              ],
              controller: _priceController,
              focusNode: _priceNavigationFocus,
              isEnabled: !_isPriceSubmitted,
              onSubmitted: (String value) {
                if (value.length != 0) {
                  setState(() {
                    _isPriceSubmitted = true;
                  });

                  _amountNavigationFocus.requestFocus();
                }
              },
              prefixText: currency,
            ),
          ],
        ),
        maintainSize: false,
        maintainAnimation: true,
        maintainState: true,
        visible: _isNameSubmitted,
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
            SizedBox(
              height: 8.0,
            ),
            FormTextField(
              key: AddStockPageKeys.productAmountTextField,
              regex: [
                WhitelistingTextInputFormatter.digitsOnly,
                DecimalInputFormatter(),
              ],
              controller: _amountController,
              focusNode: _amountNavigationFocus,
              isEnabled: !_isAmountSubmitted,
              onSubmitted: (String value) {
                if (value.length != 0) {
                  setState(() {
                    _isAmountSubmitted = true;
                  });

                  _amountNavigationFocus.unfocus();
                }
              },
            ),
          ],
        ),
        maintainSize: false,
        maintainAnimation: true,
        maintainState: true,
        visible: _isPriceSubmitted,
      );

  Widget _buildManufacturerSection(double height) => Visibility(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              _manufacturer != null
                  ? ProductStrings.manufacturerDesc
                  : ProductStrings.manufacturerDescWhenImcompleted,
              style: TextStyle(
                fontWeight: FontWeight.w800,
                fontSize: 26.0,
              ),
            ),
            SizedBox(
              height: 8.0,
            ),
            Visibility(
              child: ButtonTheme(
                padding: EdgeInsets.all(2.0),
                materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                minWidth: 0,
                height: 0,
                child: FlatButton(
                  child: Text(
                    '􀅼',
                    style: TextStyle(
                      fontWeight: FontWeight.w400,
                      fontSize: 22.0,
                    ),
                  ),
                  onPressed: () {
                    showModalBottomSheet(
                      context: context,
                      builder: (context) => SearchManufacturerDialog(
                        onManufacturerChanged: _onManufacturerChanged,
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
              maintainSize: true,
              maintainAnimation: true,
              maintainState: true,
              visible: _manufacturer == null,
            ),
          ],
        ),
        maintainSize: false,
        maintainAnimation: true,
        maintainState: true,
        visible: _isAmountSubmitted,
      );

  Widget _buildSelectedManufacturerText() => Visibility(
        child: Text(
          _manufacturer?.name ?? '',
          style: TextStyle(
            fontSize: 22.0,
            color: Colors.black54,
          ),
        ),
        visible: _manufacturer != null,
      );

  Widget _buildCategorySection(double height) => Visibility(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              '카테고리',
              style: TextStyle(
                fontWeight: FontWeight.w800,
                fontSize: 26.0,
              ),
            ),
            SizedBox(
              height: 8.0,
            ),
            Visibility(
              child: ButtonTheme(
                padding: EdgeInsets.all(2.0),
                materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                minWidth: 0,
                height: 0,
                child: FlatButton(
                  child: Text(
                    '􀅼',
                    style: TextStyle(
                      fontWeight: FontWeight.w400,
                      fontSize: 22.0,
                    ),
                  ),
                  onPressed: () {
                    showModalBottomSheet(
                      context: context,
                      builder: (context) => SelectCategoryDialog(
                        onCategoryChanged: _onCategoryChanged,
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
              maintainSize: true,
              maintainAnimation: true,
              maintainState: true,
              visible: _category == null,
            ),
          ],
        ),
        maintainSize: false,
        maintainAnimation: true,
        maintainState: true,
        visible: _manufacturer != null,
      );

  Widget _buildCategoryText() => Visibility(
        child: Container(
          padding: EdgeInsets.all(
            4.0,
          ),
          height: 48.0,
          decoration: BoxDecoration(
            color: _category?.color,
            borderRadius: BorderRadius.circular(10.0),
          ),
          child: Row(
            children: [
              Text(
                _category?.icon ?? '',
                textAlign: TextAlign.left,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w600,
                  fontSize: 32.0,
                ),
              ),
              Text(
                _category?.text ?? '',
                textAlign: TextAlign.left,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w600,
                  fontSize: 20.0,
                ),
              ),
            ],
          ),
        ),
        visible: _category != null,
      );

  Widget _buildSubmitBtn() => CupertinoButton(
        key: AddStockPageKeys.productSubmitBtn,
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
        onPressed: _category != null
            ? _submitProduct
            : null,
        borderRadius: BorderRadius.circular(10.0),
        padding: EdgeInsets.symmetric(vertical: 16.0),
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
