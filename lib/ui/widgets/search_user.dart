import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:Eliverd/common/string.dart';

class SearchUserDialog extends StatefulWidget {
  @override
  _SearchUserDialogState createState() => _SearchUserDialogState();
}

class _SearchUserDialogState extends State<SearchUserDialog> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        brightness: Brightness.light,
        elevation: 0.0,
        iconTheme: IconThemeData(color: Colors.black),
        actions: <Widget>[
          ButtonTheme(
            materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
            minWidth: 0,
            height: 0,
            child: FlatButton(
              child: Text(
                '완료',
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 17.0,
                ),
              ),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ),
        ],
      ),
      body: ListView(
        padding: EdgeInsets.symmetric(
          horizontal: 20.0,
        ),
        children: <Widget>[
          CupertinoTextField(
            placeholder: RegisterStoreStrings.registererSearchDesc,
            onSubmitted: (value) {
              // TO-DO: 사업자 BLOC 구현 후 Search 이벤트 call
            },
          ),
        ],
      ),
    );
  }
}