import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:Eliverd/bloc/accountBloc.dart';
import 'package:Eliverd/bloc/states/accountState.dart';

import 'package:Eliverd/common/string.dart';
import 'package:Eliverd/common/color.dart';

class RegisterStorePage extends StatefulWidget {
  @override
  _RegisterStorePageState createState() => _RegisterStorePageState();
}

class _RegisterStorePageState extends State<RegisterStorePage> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider<AccountBloc>.value(
      value: context.bloc<AccountBloc>(),
      child: BlocConsumer<AccountBloc, AccountState>(
        listener: (context, state) {
          if (state is AccountDoneCreate) {
            Navigator.pop(context);
          }
        },
        builder: (context, state) {
          return Scaffold(
            extendBodyBehindAppBar: true,
            key: Key('RegisterStorePage'),
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
              child: ListView(
                children: <Widget>[
                  Text(
                    TitleStrings.registerStoreTitle,
                    style: const TextStyle(
                        color: Colors.black,
                        fontSize: 36.0,
                        fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
            bottomNavigationBar: Padding(
              padding: EdgeInsets.only(
                left: 20.0,
                right: 20.0,
                bottom: 20.0,
              ),
              child: BottomAppBar(
                color: Colors.transparent,
                elevation: 0.0,
                child: CupertinoButton(
                  key: Key('RegisterButton'),
                  child: Text(
                    RegisterStoreStrings.registerBtnDesc,
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 16.0,
                    ),
                  ),
                  color: eliverdColor,
                  borderRadius: BorderRadius.circular(15.0),
                  padding: EdgeInsets.symmetric(vertical: 15.0),
                  onPressed: () {

                  }
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
