import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;

import 'package:Eliverd/resources/repositories/repositories.dart';
import 'package:Eliverd/resources/providers/providers.dart';
import 'package:Eliverd/bloc/accountBloc.dart';
import 'package:Eliverd/bloc/events/accountEvent.dart';
import 'package:Eliverd/bloc/states/accountState.dart';

import 'package:Eliverd/common/string.dart';
import 'package:Eliverd/common/color.dart';

class SignUpPage extends StatefulWidget {
  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final _nameController = TextEditingController();
  final _nicknameController = TextEditingController();
  final _userIdController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _isSeller = false;

  AccountBloc _accountBloc;

  @override
  void initState() {
    super.initState();

    _accountBloc = AccountBloc(
      accountRepository: AccountRepository(
        accountAPIClient: AccountAPIClient(
          httpClient: http.Client(),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;

    return Scaffold(
      key: Key('SignUpPage'),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        brightness: Brightness.light,
        elevation: 0.0,
        iconTheme: IconThemeData(color: Colors.black),
      ),
      body: BlocProvider<AccountBloc>.value(
        value: _accountBloc,
        child: BlocConsumer<AccountBloc, AccountState>(
          listener: (context, state) {
            if (state is AccountDoneCreate) {
              Navigator.pop(context);
            }
          },
          builder: (context, state) {
            return ListView(
              padding: EdgeInsets.only(
                left: height / 32.0,
                right: height / 32.0,
                bottom: height / 15.0,
              ),
              children: <Widget>[
                Text(
                  SignUpStrings.signUp,
                  style: const TextStyle(
                      color: Colors.black,
                      fontSize: 36.0,
                      fontWeight: FontWeight.bold),
                ),
                SizedBox(height: height / 64.0),
                Visibility(
                  child: Padding(
                    padding: EdgeInsets.only(
                      top: 10.0,
                      bottom: 10.0,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          _nameController.text.length != 0
                              ? SignUpStrings.realnameDesc
                              : SignUpStrings.realnameDescWhenImcompleted,
                          style: TextStyle(
                            fontWeight: FontWeight.w800,
                            fontSize: 26.0,
                          ),
                        ),
                        SizedBox(height: height / 120.0),
                        TextField(
                          textInputAction: TextInputAction.done,
                          inputFormatters: [
                            WhitelistingTextInputFormatter(RegExp("[a-zA-Zㄱ-ㅎㅏ-ㅣ가-힣^\s]")),
                          ],
                          maxLength: 128,
                          maxLengthEnforced: true,
                          controller: _nameController,
                          enabled: _nameController.text.length == 0,
                          decoration: InputDecoration(
                            contentPadding: EdgeInsets.all(2.0),
                            isDense: true,
                          ),
                          style: TextStyle(
                            fontSize: 22.0,
                            color: Colors.black54,
                          ),
                        ),
                      ],
                    ),
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
                        isWrongTypeField(state, 'realname') ? ErrorMessages.realnameInvalidMessage : '',
                        style: TextStyle(
                          color: Colors.red,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: height / 120.0),
                    ],
                  ),
                  maintainSize: false,
                  maintainAnimation: true,
                  maintainState: true,
                  visible: isInvalidField(state, 'realname'),
                ),
                Visibility(
                  child: Padding(
                    padding: EdgeInsets.only(
                      top: 10.0,
                      bottom: 10.0,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          _nicknameController.text.length != 0
                              ? SignUpStrings.nicknameDesc
                              : SignUpStrings.nicknameDescWhenImcompleted,
                          style: TextStyle(
                            fontWeight: FontWeight.w800,
                            fontSize: 26.0,
                          ),
                        ),
                        SizedBox(height: height / 120.0),
                        TextField(
                          textInputAction: TextInputAction.done,
                          inputFormatters: [
                            WhitelistingTextInputFormatter(RegExp("[a-zA-Z0-9ㄱ-ㅎㅏ-ㅣ가-힣^\s]")),
                          ],
                          maxLength: 50,
                          maxLengthEnforced: true,
                          controller: _nicknameController,
                          enabled: _nicknameController.text.length == 0,
                          decoration: InputDecoration(
                            contentPadding: EdgeInsets.all(2.0),
                            isDense: true,
                          ),
                          style: TextStyle(
                            fontSize: 22.0,
                            color: Colors.black54,
                          ),
                        ),
                      ],
                    ),
                  ),
                  maintainSize: true,
                  maintainAnimation: true,
                  maintainState: true,
                  visible: _nameController.text.length != 0,
                ),
                Visibility(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        isWrongTypeField(state, 'nickname')
                            ? ErrorMessages.nicknameInvalidMessage
                            : (isDuplicatedField(state, 'nickname')
                                ? ErrorMessages.nicknameDuplicatedMessage
                                : ''),
                        style: TextStyle(
                          color: Colors.red,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: height / 120.0),
                    ],
                  ),
                  maintainSize: false,
                  maintainAnimation: true,
                  maintainState: true,
                  visible: isInvalidField(state, 'nickname'),
                ),
                Visibility(
                  child: Padding(
                    padding: EdgeInsets.only(
                      top: 10.0,
                      bottom: 10.0,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          _userIdController.text.length != 0
                              ? SignUpStrings.idDesc
                              : SignUpStrings.idDescWhenImcompleted,
                          style: TextStyle(
                            fontWeight: FontWeight.w800,
                            fontSize: 26.0,
                          ),
                        ),
                        SizedBox(height: height / 120.0),
                        TextField(
                          textInputAction: TextInputAction.done,
                          inputFormatters: [
                            WhitelistingTextInputFormatter(RegExp("[a-zA-Z0-9^\s]")),
                          ],
                          maxLength: 50,
                          maxLengthEnforced: true,
                          controller: _userIdController,
                          enabled: _userIdController.text.length == 0,
                          decoration: InputDecoration(
                            contentPadding: EdgeInsets.all(2.0),
                            isDense: true,
                          ),
                          style: TextStyle(
                            fontSize: 22.0,
                            color: Colors.black54,
                          ),
                        ),
                      ],
                    ),
                  ),
                  maintainSize: true,
                  maintainAnimation: true,
                  maintainState: true,
                  visible: _nicknameController.text.length != 0,
                ),
                Visibility(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        isWrongTypeField(state, 'id')
                            ? ErrorMessages.userIdInvalidMessage
                            : (isDuplicatedField(state, 'id')
                                ? ErrorMessages.userIdDuplicatedMessage
                                : ''),
                        style: TextStyle(
                          color: Colors.red,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: height / 120.0),
                    ],
                  ),
                  maintainSize: false,
                  maintainAnimation: true,
                  maintainState: true,
                  visible: isInvalidField(state, 'id'),
                ),
                Visibility(
                  child: Padding(
                    padding: EdgeInsets.only(
                      top: 10.0,
                      bottom: 10.0,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          _passwordController.text.length != 0
                              ? SignUpStrings.passwordDesc
                              : SignUpStrings.passwordDescWhenImcompleted,
                          style: TextStyle(
                            fontWeight: FontWeight.w800,
                            fontSize: 26.0,
                          ),
                        ),
                        SizedBox(height: height / 120.0),
                        TextField(
                          textInputAction: TextInputAction.done,
                          inputFormatters: [
                            WhitelistingTextInputFormatter(RegExp("[a-zA-Z0-9\x00-\x7F^\s]")),
                          ],
                          maxLength: 256,
                          maxLengthEnforced: true,
                          obscureText: true,
                          controller: _passwordController,
                          enabled: _passwordController.text.length == 0,
                          decoration: InputDecoration(
                            contentPadding: EdgeInsets.all(2.0),
                            isDense: true,
                          ),
                          style: TextStyle(
                            fontSize: 22.0,
                            color: Colors.black54,
                          ),
                        ),
                      ],
                    ),
                  ),
                  maintainSize: true,
                  maintainAnimation: true,
                  maintainState: true,
                  visible: _userIdController.text.length != 0,
                ),
                Visibility(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        isWrongTypeField(state, 'password')
                            ? ErrorMessages.passwordInvalidMessage
                            : '',
                        style: TextStyle(
                          color: Colors.red,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: height / 120.0),
                    ],
                  ),
                  maintainSize: false,
                  maintainAnimation: true,
                  maintainState: true,
                  visible: isInvalidField(state, 'password'),
                ),
                Visibility(
                  child: Padding(
                    padding: EdgeInsets.only(
                      top: 10.0,
                      bottom: 10.0,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Text(
                              SignUpStrings.isSellerDesc,
                              style: TextStyle(
                                fontWeight: FontWeight.w800,
                                fontSize: 26.0,
                              ),
                            ),
                            CupertinoSwitch(
                              value: _isSeller,
                              onChanged: (value) {
                                setState(() {
                                  _isSeller = value;
                                });
                              },
                            ),
                          ],
                        ),
                        SizedBox(height: height / 120.0),
                      ],
                    ),
                  ),
                  maintainSize: true,
                  maintainAnimation: true,
                  maintainState: true,
                  visible: _passwordController.text.length != 0,
                ),
                Visibility(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        ErrorMessages.signUpErrorMessage,
                        style: TextStyle(
                          color: Colors.red,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: height / 120.0),
                    ],
                  ),
                  maintainSize: false,
                  maintainAnimation: true,
                  maintainState: true,
                  visible: state is AccountError,
                ),
              ],
            );
          },
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        color: Colors.transparent,
        elevation: 0.0,
        child: Padding(
          padding: EdgeInsets.only(
            left: 24.0,
            right: 24.0,
            bottom: 24.0,
          ),
          child: CupertinoButton(
            key: Key('SignUpButton'),
            child: Text(
              SignUpStrings.signUpButtonDesc,
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 16.0,
              ),
            ),
            color: eliverdColor,
            borderRadius: BorderRadius.circular(15.0),
            padding: EdgeInsets.symmetric(vertical: 15.0),
            onPressed: _passwordController.text.length != 0
                ? () {
                    Map<String, dynamic> jsonifiedUser = {
                      'name': _nameController.text,
                      'nickname': _nicknameController.text,
                      'user_id': _userIdController.text,
                      'password': _passwordController.text,
                      'is_seller': _isSeller.toString(),
                    };

                    _accountBloc.add(AccountValidated(jsonifiedUser));
                    _accountBloc.add(AccountCreated(jsonifiedUser));
                  }
                : null,
          ),
        ),
      ),
    );
  }

  bool isInvalidField(dynamic state, String fieldName) {
    return state is AccountValidateFailed && state.jsonifiedValidation[fieldName] != 0;
  }

  bool isWrongTypeField(dynamic state, String fieldName) {
    return state is AccountValidateFailed && state.jsonifiedValidation[fieldName] == 1;
  }

  bool isDuplicatedField(dynamic state, String fieldName) {
    return state is AccountValidateFailed && state.jsonifiedValidation[fieldName] == 2;
  }
}
