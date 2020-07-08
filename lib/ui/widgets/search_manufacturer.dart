import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:Eliverd/models/models.dart';

import 'package:Eliverd/common/string.dart';

import 'package:Eliverd/ui/widgets/manufacturers.dart';

class SearchManufacturerDialog extends StatefulWidget {
  final Manufacturer manufacturer;
  final ValueChanged<Manufacturer> onManufacturerChanged;

  const SearchManufacturerDialog({Key key, @required this.manufacturer, @required this.onManufacturerChanged}) : super(key: key);

  @override
  _SearchManufacturerDialogState createState() =>
      _SearchManufacturerDialogState();
}

class _SearchManufacturerDialogState extends State<SearchManufacturerDialog> {
  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;

    return Container(
      height: height * 0.6,
      padding: EdgeInsets.symmetric(
        horizontal: 20.0,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              SizedBox(height: height / 64.0),
              Divider(
                indent: 140.0,
                endIndent: 140.0,
                height: 16.0,
                thickness: 4.0,
              ),
              SizedBox(height: height / 64.0),
              Text(
                TitleStrings.searchManufacturerTitle,
                style: TextStyle(
                  fontWeight: FontWeight.w800,
                  fontSize: 26.0,
                ),
              ),
              Text(
                SearchSheetStrings.searchManufacturerDesc,
                style: TextStyle(
                  fontWeight: FontWeight.w200,
                  fontSize: 16.0,
                ),
              ),
              SizedBox(height: height / 48.0),
              Manufacturers(
                manufacturer: widget.manufacturer,
                onManufacturerChanged: widget.onManufacturerChanged,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
