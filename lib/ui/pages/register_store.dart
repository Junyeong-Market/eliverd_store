import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:Eliverd/bloc/accountBloc.dart';
import 'package:Eliverd/bloc/states/accountState.dart';

import 'package:Eliverd/models/models.dart';

import 'package:Eliverd/common/string.dart';
import 'package:Eliverd/common/color.dart';

class RegisterStorePage extends StatefulWidget {
  @override
  _RegisterStorePageState createState() => _RegisterStorePageState();
}

class _RegisterStorePageState extends State<RegisterStorePage> {
  final _storeNameController = TextEditingController();
  final _storeDescController = TextEditingController();
  final _registerNumberController = TextEditingController();

  List<User> _registerers = [];
  Coordinate _storeLocation;

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
            body: Padding(
              padding: EdgeInsets.only(
                left: 20.0,
                right: 20.0,
                top: 40.0,
              ),
              child: ListView(
                children: <Widget>[
                  Text(
                    TitleStrings.registerStoreTitle,
                    style: const TextStyle(
                      color: Colors.black,
                      fontSize: 32.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: height / 48.0),
                  Visibility(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          _storeNameController.text.length == 0
                              ? RegisterStoreStrings
                                  .storeNameTitleWhenImcompleted
                              : RegisterStoreStrings.storeNameTitle,
                          style: TextStyle(
                            fontWeight: FontWeight.w800,
                            fontSize: 26.0,
                          ),
                        ),
                        SizedBox(height: height / 120.0),
                        TextField(
                          textInputAction: TextInputAction.done,
                          inputFormatters: [
                            WhitelistingTextInputFormatter(
                                RegExp("[a-zA-Zㄱ-ㅎㅏ-ㅣ가-힣 ]")),
                          ],
                          maxLength: 50,
                          maxLengthEnforced: true,
                          controller: _storeNameController,
                          enabled: _storeNameController.text.length == 0,
                          decoration: InputDecoration(
                            helperText:
                                RegisterStoreStrings.storeNameHelperText,
                            contentPadding: EdgeInsets.all(2.0),
                            isDense: true,
                            errorStyle: const TextStyle(
                              color: Colors.red,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          style: TextStyle(
                            fontSize: 22.0,
                            color: Colors.black54,
                          ),
                        ),
                        SizedBox(height: height / 120.0),
                      ],
                    ),
                    maintainSize: true,
                    maintainAnimation: true,
                    maintainState: true,
                    visible: true,
                  ),
                  Visibility(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          _storeDescController.text.length == 0
                              ? RegisterStoreStrings
                                  .storeDescTitleWhenImcompleted
                              : RegisterStoreStrings.storeDescTitle,
                          style: TextStyle(
                            fontWeight: FontWeight.w800,
                            fontSize: 26.0,
                          ),
                        ),
                        SizedBox(height: height / 120.0),
                        TextField(
                          textInputAction: TextInputAction.done,
                          controller: _storeDescController,
                          enabled: _storeDescController.text.length == 0,
                          decoration: InputDecoration(
                            helperText:
                                RegisterStoreStrings.storeDescHelperText,
                            contentPadding: EdgeInsets.all(2.0),
                            isDense: true,
                            errorStyle: const TextStyle(
                              color: Colors.red,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          style: TextStyle(
                            fontSize: 22.0,
                            color: Colors.black54,
                          ),
                        ),
                        SizedBox(height: height / 120.0),
                      ],
                    ),
                    maintainSize: true,
                    maintainAnimation: true,
                    maintainState: true,
                    visible: _storeNameController.text.length != 0,
                  ),
                  Visibility(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          _registerNumberController.text.length == 0
                              ? RegisterStoreStrings
                                  .registerNumberTitleWhenImcompleted
                              : RegisterStoreStrings.registerNumberTitle,
                          style: TextStyle(
                            fontWeight: FontWeight.w800,
                            fontSize: 26.0,
                          ),
                        ),
                        SizedBox(height: height / 120.0),
                        TextField(
                          textInputAction: TextInputAction.done,
                          inputFormatters: [
                            WhitelistingTextInputFormatter(RegExp("[0-9^\s]")),
                            RegisterNumberTextInputFormatter(),
                          ],
                          maxLength: 12,
                          maxLengthEnforced: true,
                          controller: _registerNumberController,
                          enabled: _registerNumberController.text.length == 0,
                          decoration: InputDecoration(
                            helperText:
                                RegisterStoreStrings.registerNumberHelperText,
                            contentPadding: EdgeInsets.all(2.0),
                            isDense: true,
                            errorStyle: const TextStyle(
                              color: Colors.red,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          style: TextStyle(
                            fontSize: 22.0,
                            color: Colors.black54,
                          ),
                        ),
                        SizedBox(height: height / 120.0),
                      ],
                    ),
                    maintainSize: true,
                    maintainAnimation: true,
                    maintainState: true,
                    visible: _storeDescController.text.length != 0,
                  ),
                  Visibility(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(
                              _registerers.length == 0
                                  ? RegisterStoreStrings
                                      .reigsterersTitleWhenImcompleted
                                  : RegisterStoreStrings.reigsterersTitle,
                              style: TextStyle(
                                fontWeight: FontWeight.w800,
                                fontSize: 26.0,
                              ),
                            ),
                            Visibility(
                              child: ButtonTheme(
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
                                  onPressed: () {
                                    setState(() {
                                      // TO-DO: 사업자 검색 후 선택한 모든 사업자 List를 _registerers에 할당
                                    });
                                  },
                                ),
                              ),
                              maintainSize: true,
                              maintainAnimation: true,
                              maintainState: true,
                              visible: _registerers.length == 0,
                            ),
                          ],
                        ),
                        SizedBox(height: height / 120.0),
                      ],
                    ),
                    maintainSize: true,
                    maintainAnimation: true,
                    maintainState: true,
                    visible: _registerNumberController.text.length != 0,
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
                              _storeLocation == null
                                  ? RegisterStoreStrings
                                      .storeLocationTitleWhenImcompleted
                                  : RegisterStoreStrings.storeLocationTitle,
                              style: TextStyle(
                                fontWeight: FontWeight.w800,
                                fontSize: 26.0,
                              ),
                            ),
                            Visibility(
                              child: ButtonTheme(
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
                                  onPressed: () {
                                    setState(() {
                                      // TO-DO: 위치 정보 추출 후 _storeLocation에 Coordinate 값 할당
                                    });
                                  },
                                ),
                              ),
                              maintainSize: true,
                              maintainAnimation: true,
                              maintainState: true,
                              visible: _storeLocation == null,
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
                    visible: _registerers.length != 0,
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
                  onPressed: _storeLocation == null ? null : () {},
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

class RegisterNumberTextInputFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    final newTextLength = newValue.text.length;
    final newText = StringBuffer();

    int selectionIndex = newValue.selection.end;
    int usedSubstringIndex = 0;

    if (newTextLength >= 4) {
      newText.write(newValue.text.substring(0, usedSubstringIndex = 3) + '-');
      if (newValue.selection.end >= 3)
        selectionIndex++;
    }

    if (newTextLength >= 6) {
      newText.write(newValue.text.substring(3, usedSubstringIndex = 5) + '-');
      if (newValue.selection.end >= 5)
        selectionIndex++;
    }

    if (newTextLength >= usedSubstringIndex)
      newText.write(newValue.text.substring(usedSubstringIndex));
    return TextEditingValue(
      text: newText.toString(),
      selection: TextSelection.collapsed(offset: selectionIndex),
    );
  }
}
