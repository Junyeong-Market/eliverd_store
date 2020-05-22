import 'package:Eliverd/ui/widgets/header.dart';
import 'package:flutter/material.dart';

class AddProductPage extends StatefulWidget {
  @override
  _AddProductPageState createState() => _AddProductPageState();
}

class _AddProductPageState extends State<AddProductPage> {

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;

    return Scaffold(
      key: Key('AddProductPage'),
      appBar: Header(
        height: height / 5.0,
        child: Column(
          children: <Widget>[
            AppBar(
              backgroundColor: Colors.lightBlue,
              elevation: 0.0,
            ),
            Align(
              alignment: FractionalOffset(0.1, 0.0),
              child: Text(
                "상품 등록",
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
