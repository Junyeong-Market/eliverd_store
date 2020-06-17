import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
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
        elevation: 0.0,
        iconTheme: IconThemeData(
            color: Colors.black
        ),
      ),
      body: BlocProvider<AccountBloc>.value(
        value: _accountBloc,
        child: BlocConsumer<AccountBloc, AccountState>(
          listener: (context, state) {
            if (state is AccountExist) {
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
                  signUp,
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
                          _nameController.text.length != 0 ? usernameDesc : usernameDescWhenImcompleted,
                          style: TextStyle(
                            fontWeight: FontWeight.w800,
                            fontSize: 26.0,
                          ),
                        ),
                        SizedBox(height: height / 120.0),
                        TextField(
                          textInputAction: TextInputAction.done,
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
                  child: Padding(
                    padding: EdgeInsets.only(
                      top: 10.0,
                      bottom: 10.0,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          _nicknameController.text.length != 0 ? nicknameDesc : nicknameDescWhenImcompleted,
                          style: TextStyle(
                            fontWeight: FontWeight.w800,
                            fontSize: 26.0,
                          ),
                        ),
                        SizedBox(height: height / 120.0),
                        TextField(
                          textInputAction: TextInputAction.done,
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
                  child: Padding(
                    padding: EdgeInsets.only(
                      top: 10.0,
                      bottom: 10.0,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          _userIdController.text.length != 0 ? idDesc : idDescWhenImcompleted,
                          style: TextStyle(
                            fontWeight: FontWeight.w800,
                            fontSize: 26.0,
                          ),
                        ),
                        SizedBox(height: height / 120.0),
                        TextField(
                          textInputAction: TextInputAction.done,
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
                  child: Padding(
                    padding: EdgeInsets.only(
                      top: 10.0,
                      bottom: 10.0,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          _passwordController.text.length != 0 ? passwordDesc : passwordDescWhenImcompleted,
                          style: TextStyle(
                            fontWeight: FontWeight.w800,
                            fontSize: 26.0,
                          ),
                        ),
                        SizedBox(height: height / 120.0),
                        TextField(
                          textInputAction: TextInputAction.done,
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
                              isSellerDesc,
                              style: TextStyle(
                                fontWeight: FontWeight.w800,
                                fontSize: 26.0,
                              ),
                            ),
                            CupertinoSwitch(
                              value: _isSeller,
                              onChanged: (value) { setState(() { _isSeller = value; }); },
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
                SizedBox(height: height / 64.0),
                CupertinoButton(
                  key: Key('SignUpButton'),
                  child: Text(
                    signUpButtonDesc,
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 16.0,
                    ),
                  ),
                  color: eliverdColor,
                  borderRadius: BorderRadius.circular(15.0),
                  padding: EdgeInsets.symmetric(vertical: 15.0),
                  onPressed: _passwordController.text.length != 0 ? () {
                    Map<String, dynamic> jsonifiedUser = {
                      'name': _nameController.text,
                      'nickname': _nicknameController.text,
                      'user_id': _userIdController.text,
                      'password': _passwordController.text,
                      'is_seller': _isSeller.toString(),
                    };

                    _accountBloc.add(AccountCreated(jsonifiedUser));
                  } : null,
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
