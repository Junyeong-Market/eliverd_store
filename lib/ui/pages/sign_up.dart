import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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
            key: Key('SignUpPage'),
            appBar: AppBar(
              backgroundColor: Colors.transparent,
              brightness: Brightness.light,
              elevation: 0.0,
              iconTheme: IconThemeData(color: Colors.black),
            ),
            body: Padding(
              padding: EdgeInsets.symmetric(
                horizontal: 20.0,
              ),
              child: ListView(
                children: <Widget>[
                  Text(
                    TitleStrings.signUpTitle,
                    style: const TextStyle(
                        color: Colors.black,
                        fontSize: 36.0,
                        fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: height / 48.0),
                  Visibility(
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
                            WhitelistingTextInputFormatter(
                                RegExp("[a-zA-Zㄱ-ㅎㅏ-ㅣ가-힣^\s]")),
                          ],
                          maxLength: 128,
                          maxLengthEnforced: true,
                          controller: _nameController,
                          decoration: InputDecoration(
                            helperText: SignUpStrings.realnameHelperText,
                            contentPadding: EdgeInsets.all(2.0),
                            isDense: true,
                            errorText: isWrongTypeField(state, 'realname')
                                ? ErrorMessages.realnameInvalidMessage
                                : null,
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
                            WhitelistingTextInputFormatter(
                                RegExp("[a-zA-Z0-9ㄱ-ㅎㅏ-ㅣ가-힣^\s]")),
                          ],
                          maxLength: 50,
                          maxLengthEnforced: true,
                          controller: _nicknameController,
                          decoration: InputDecoration(
                            helperText: SignUpStrings.nicknameHelperText,
                            contentPadding: EdgeInsets.all(2.0),
                            isDense: true,
                            errorText: isWrongTypeField(state, 'nickname')
                                ? ErrorMessages.nicknameInvalidMessage
                                : (isDuplicatedField(state, 'nickname')
                                    ? ErrorMessages.nicknameDuplicatedMessage
                                    : null),
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
                    visible: _nameController.text.length != 0,
                  ),
                  Visibility(
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
                            WhitelistingTextInputFormatter(
                                RegExp("[a-zA-Z0-9^\s]")),
                          ],
                          maxLength: 50,
                          maxLengthEnforced: true,
                          controller: _userIdController,
                          decoration: InputDecoration(
                            helperText: SignUpStrings.userIdHelperText,
                            contentPadding: EdgeInsets.all(2.0),
                            isDense: true,
                            errorText: isWrongTypeField(state, 'id')
                                ? ErrorMessages.userIdInvalidMessage
                                : (isDuplicatedField(state, 'id')
                                    ? ErrorMessages.userIdDuplicatedMessage
                                    : null),
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
                    visible: _nicknameController.text.length != 0,
                  ),
                  Visibility(
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
                            WhitelistingTextInputFormatter(
                                RegExp("[a-zA-Z0-9\x01-\x19\x21-\x7F]")),
                          ],
                          maxLength: 256,
                          maxLengthEnforced: true,
                          obscureText: true,
                          controller: _passwordController,
                          decoration: InputDecoration(
                            helperText: SignUpStrings.passwordHelperText,
                            contentPadding: EdgeInsets.all(2.0),
                            isDense: true,
                            errorText: isWrongTypeField(state, 'password')
                                ? ErrorMessages.passwordInvalidMessage
                                : null,
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
                    visible: _userIdController.text.length != 0,
                  ),
                  Visibility(
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
                    visible: _passwordController.text.length != 0,
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

                          context
                              .bloc<AccountBloc>()
                              .add(AccountValidated(jsonifiedUser));
                          context
                              .bloc<AccountBloc>()
                              .add(AccountCreated(jsonifiedUser));
                        }
                      : null,
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  bool isInvalidField(dynamic state, String fieldName) {
    return state is AccountValidateFailed &&
        state.jsonifiedValidation[fieldName] != 0;
  }

  bool isWrongTypeField(dynamic state, String fieldName) {
    return state is AccountValidateFailed &&
        state.jsonifiedValidation[fieldName] == 1;
  }

  bool isDuplicatedField(dynamic state, String fieldName) {
    return state is AccountValidateFailed &&
        state.jsonifiedValidation[fieldName] == 2;
  }
}
