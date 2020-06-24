import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:Eliverd/bloc/authBloc.dart';
import 'package:Eliverd/bloc/states/authState.dart';

import 'package:Eliverd/common/string.dart';

class StoreSelectionPage extends StatefulWidget {
  @override
  _StoreSelectionPageState createState() => _StoreSelectionPageState();
}

class _StoreSelectionPageState extends State<StoreSelectionPage> {
  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;

    return BlocProvider<AuthenticationBloc>.value(
      value: context.bloc<AuthenticationBloc>(),
      child: BlocConsumer<AuthenticationBloc, AuthenticationState>(
        listener: (context, state) {
          if (state is! Authenticated) {
            Navigator.pop(context);
          }
        },
        builder: (context, state) {
          return Scaffold(
            key: Key('StoreSelectionPage'),
            appBar: AppBar(
              backgroundColor: Colors.transparent,
              brightness: Brightness.light,
              elevation: 0.0,
              automaticallyImplyLeading: false,
            ),
            body: Padding(
              padding: EdgeInsets.symmetric(
                horizontal: 20.0,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    state is Authenticated
                        ? state.user.nickname + TitleStrings.storeSelectionTitle
                        : '',
                    style: const TextStyle(
                        color: Colors.black,
                        fontSize: 36.0,
                        fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: height / 32.0),
                  CupertinoPicker(
                    itemExtent: 25.0,
                    looping: true,
                    onSelectedItemChanged: null,
                    children: <Widget>[
                      // TO-DO: Store Widget UI 구현 후 매핑
                    ],
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
