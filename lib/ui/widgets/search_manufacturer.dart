import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:Eliverd/models/models.dart';

import 'package:Eliverd/common/string.dart';
import 'package:Eliverd/common/color.dart';

import 'package:Eliverd/ui/widgets/manufacturers.dart';

class SearchManufacturerDialog extends StatefulWidget {
  final ValueChanged<Manufacturer> onManufacturerChanged;

  const SearchManufacturerDialog(
      {Key key, @required this.onManufacturerChanged})
      : super(key: key);

  @override
  _SearchManufacturerDialogState createState() =>
      _SearchManufacturerDialogState();
}

class _SearchManufacturerDialogState extends State<SearchManufacturerDialog> {
  Manufacturer _manufacturer;

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;

    return Container(
      height: height * 0.7,
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
                BottomSheetStrings.searchManufacturerDesc,
                style: TextStyle(
                  fontWeight: FontWeight.w200,
                  fontSize: 16.0,
                ),
              ),
              SizedBox(height: height / 48.0),
              Manufacturers(
                onManufacturerChanged: _onSelectedManufacturerChanged,
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
                        BottomSheetStrings.cancel,
                        style: TextStyle(
                          color: eliverdColor,
                          fontSize: 16.0,
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
                          fontSize: 16.0,
                        ),
                      ),
                      onPressed: () {
                        widget.onManufacturerChanged(_manufacturer);
                        Navigator.pop(context);
                      },
                    ),
                  ),
                ],
              ),
              SizedBox(height: height / 48.0),
            ],
          ),
        ],
      ),
    );
  }

  void _onSelectedManufacturerChanged(Manufacturer manufacturer) {
    setState(() {
      _manufacturer = manufacturer;
    });
  }
}
