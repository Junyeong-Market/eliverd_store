import 'package:Eliverd/bloc/events/searchUserEvent.dart';
import 'package:Eliverd/bloc/events/storeEvent.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:Eliverd/bloc/searchUserBloc.dart';
import 'package:Eliverd/bloc/storeBloc.dart';

import 'package:Eliverd/models/models.dart';

import 'package:Eliverd/common/string.dart';

class SearchUserDialog extends StatefulWidget {
  @override
  _SearchUserDialogState createState() => _SearchUserDialogState();
}

class _SearchUserDialogState extends State<SearchUserDialog> {
  List<User> registerers;

  void _registerersSelected() {
    context.bloc<StoreBloc>().add(SelectRegisterers(registerers));
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<StoreBloc>.value(
          value: context.bloc<StoreBloc>(),
        ),
        BlocProvider<SearchUserBloc>.value(
          value: context.bloc<SearchUserBloc>(),
        ),
      ],
      child: BlocConsumer(
        listener: (context, state) {

        },
        builder: (context, state) {
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
                    onPressed: _registerersSelected,
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
                    context.bloc<SearchUserBloc>().add(SearchUser(value));
                  },
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
