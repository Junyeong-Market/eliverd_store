import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:Eliverd/bloc/states/storeState.dart';
import 'package:Eliverd/bloc/events/storeEvent.dart';
import 'package:Eliverd/bloc/storeBloc.dart';

import 'package:Eliverd/models/models.dart';

import 'package:Eliverd/common/string.dart';
import 'package:Eliverd/common/color.dart';

import 'package:Eliverd/ui/widgets/registerers.dart';

class SearchUserDialog extends StatefulWidget {
  @override
  _SearchUserDialogState createState() => _SearchUserDialogState();
}

class _SearchUserDialogState extends State<SearchUserDialog> {
  List<User> _registerers = [];

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;

    return BlocConsumer<StoreBloc, StoreState>(
      listener: (context, state) {
        if (state is StoreRegisterersRegistered) {
          Navigator.pop(context);
        }
      },
      builder: (context, state) {
        return Container(
          height: height * 0.9,
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
                    TitleStrings.searchRegisterersTitle,
                    style: TextStyle(
                      fontWeight: FontWeight.w800,
                      fontSize: 26.0,
                    ),
                  ),
                  Text(
                    BottomSheetStrings.searchRegisterersDesc,
                    style: TextStyle(
                      fontWeight: FontWeight.w200,
                      fontSize: 16.0,
                    ),
                  ),
                  SizedBox(
                    height: 8.0,
                  ),
                  RegistererCards(
                    onSelectedRegisterersChanged: _onSelectedRegisterersChanged,
                  ),
                ],
              ),
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
                        if (_registerers.isNotEmpty) {
                          context
                              .bloc<StoreBloc>()
                              .add(RegisterStoreRegisterers(_registerers));
                        }
                      },
                    ),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }

  void _onSelectedRegisterersChanged(List<User> updatedRegisterers) {
    setState(() {
      _registerers = updatedRegisterers;
    });
  }
}
