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
  void _openSearchUserDialog() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (BuildContext context) {
          return Scaffold(
            appBar: AppBar(
              backgroundColor: Colors.transparent,
              brightness: Brightness.light,
              elevation: 0.0,
              iconTheme: IconThemeData(color: eliverdColor),
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
                        color: eliverdColor,
                      ),
                    ),
                    onPressed: () {},
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
        },
        fullscreenDialog: true,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;

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
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: height / 48.0),
                  Visibility(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(
                              RegisterStoreStrings.reigsterersDesc,
                              style: TextStyle(
                                fontWeight: FontWeight.w800,
                                fontSize: 26.0,
                              ),
                            ),
                            ButtonTheme(
                              padding: EdgeInsets.all(2.0),
                              materialTapTargetSize:
                                  MaterialTapTargetSize.shrinkWrap,
                              minWidth: 0,
                              height: 0,
                              child: FlatButton(
                                child: Text(
                                  '􀅼',
                                  style: TextStyle(
                                    fontWeight: FontWeight.w400,
                                    fontSize: 22.0,
                                  ),
                                ),
                                onPressed: _openSearchUserDialog,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: height / 120.0),
                        Visibility(
                          child: Text(
                            ErrorMessages.signUpErrorMessage,
                            style: TextStyle(
                              color: Colors.red,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          maintainSize: false,
                          maintainAnimation: true,
                          maintainState: true,
                          visible: state is AccountError,
                        ),
                      ],
                    ),
                    maintainSize: true,
                    maintainAnimation: true,
                    maintainState: true,
                    visible: true,
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
                    onPressed: () {}),
              ),
            ),
          );
        },
      ),
    );
  }
}
