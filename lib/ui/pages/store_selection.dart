import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:Eliverd/bloc/authBloc.dart';
import 'package:Eliverd/bloc/states/authState.dart';

import 'package:Eliverd/common/color.dart';
import 'package:Eliverd/common/string.dart';

import 'package:Eliverd/ui/pages/home.dart';
import 'package:Eliverd/ui/pages/register_store.dart';

class StoreSelectionPage extends StatelessWidget {
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

          if ((state as Authenticated)?.stores?.length == 1) {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => HomePage(currentStore: (state as Authenticated).stores[0]),
              ),
            );
          }
        },
        builder: (context, state) {
          if ((state as Authenticated)?.stores?.length == 0) {
            return Scaffold(
              extendBodyBehindAppBar: true,
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
                      ErrorMessages.noRegisteredBusinessMessage,
                      style: const TextStyle(
                          color: Colors.black,
                          fontSize: 32.0,
                          fontWeight: FontWeight.bold
                      ),
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
                    key: Key('RegisterStoreButton'),
                    child: Text(
                      StoreSelectionStrings.registerBtnDesc,
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
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) => RegisterStorePage(),
                        ),
                      );
                    }
                  ),
                ),
              ),
            );
          }

          return Scaffold(
            extendBodyBehindAppBar: true,
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