import 'package:Eliverd/ui/widgets/header.dart';
import 'package:flutter/material.dart';

import 'package:Eliverd/common/string.dart';

class UpdateProductPage extends StatefulWidget {
  @override
  _UpdateProductPageState createState() => _UpdateProductPageState();
}

class _UpdateProductPageState extends State<UpdateProductPage> {

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;

    return Scaffold(
      key: Key('UpdateProductPage'),
      appBar: Header(
        height: height / 4.8,
        child: Column(
          children: <Widget>[
            AppBar(
              backgroundColor: Colors.lightBlue,
              elevation: 0.0,
            ),
            Align(
              alignment: FractionalOffset(0.1, 0.0),
              child: Text(
                updateProductTitle,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 36.0,
                  fontWeight: FontWeight.bold),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
