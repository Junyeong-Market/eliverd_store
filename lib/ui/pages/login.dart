import 'package:Eliverd/common/color.dart';
import 'package:Eliverd/common/string.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:Eliverd/bloc/authBloc.dart';
import 'package:Eliverd/resources/providers/accountProvider.dart';
import 'package:Eliverd/resources/repositories/accountRepository.dart';
import 'package:Eliverd/bloc/states/authState.dart';
import 'package:Eliverd/bloc/accountBloc.dart';
import 'package:Eliverd/bloc/events/accountEvent.dart';
import 'package:Eliverd/bloc/events/authEvent.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:http/http.dart' as http;

import './home.dart';
import './sign_up.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _idController = TextEditingController();
  final _passwordController = TextEditingController();

  bool errorOccurred = false;

  AuthenticationBloc _authenticationBloc;
  AccountBloc _accountBloc;

  @override
  void initState() {
    super.initState();

    final _accountRepository = AccountRepository(
      accountAPIClient: AccountAPIClient(
        httpClient: http.Client(),
      ),
    );

    _authenticationBloc = AuthenticationBloc(
      accountRepository: _accountRepository,
    );
    _accountBloc = AccountBloc(
      accountRepository: _accountRepository,
    );
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;

    return Scaffold(
        key: Key('LoginPage'),
        body: MultiBlocProvider(
          providers: [
            BlocProvider<AuthenticationBloc>.value(
              value: _authenticationBloc,
            ),
            BlocProvider<AccountBloc>.value(
              value: _accountBloc,
            ),
          ],
          child: BlocConsumer<AuthenticationBloc, AuthenticationState>(
            listener: (context, state) {
              if (state is Authenticated) {
                errorOccurred = false;
                // TO-DO: Authenticated state 재정의 후 로그인된 사용자(사업자) 및 그가 관리하는 사업장 정보 불러오기
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => HomePage(currentStore: state.store),
                    ));
              } else if (state is NotAuthenticated ||
                  state is AuthenticationError) {
                errorOccurred = true;
              }
            },
            builder: (context, state) {
              return ListView(
                padding: EdgeInsets.all(50.0),
                children: <Widget>[
                  SizedBox(height: height / 16.0),
                  Image(
                    width: width / 1.5,
                    height: width / 1.5,
                    image: AssetImage(
                        'assets/images/logo/eliverd_logo_original.png'),
                  ),
                  Visibility(
                    child: Column(
                      children: <Widget>[
                        Text(
                          loginErrorMessage,
                          style: TextStyle(
                            color: Colors.red,
                            fontWeight: FontWeight.bold,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        SizedBox(height: height / 120.0),
                      ],
                    ),
                    maintainSize: true,
                    maintainAnimation: true,
                    maintainState: true,
                    visible: errorOccurred,
                  ),
                  TextField(
                    key: Key('IdField'),
                    obscureText: false,
                    controller: _idController,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: new BorderRadius.circular(15.0),
                      ),
                      labelText: idText,
                    ),
                  ),
                  SizedBox(height: height / 80.0),
                  TextField(
                    key: Key('PasswordField'),
                    obscureText: true,
                    controller: _passwordController,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: new BorderRadius.circular(15.0),
                      ),
                      labelText: passwordText,
                    ),
                  ),
                  SizedBox(height: height / 80.0),
                  CupertinoButton(
                    key: Key('SignInButton'),
                    child: Text(
                      login,
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
                      _authenticationBloc.add(SignInAuthentication(
                          _idController.text, _passwordController.text));
                    },
                  ),
                  FlatButton(
                    key: Key('SignUpButton'),
                    child: Text(
                      notSignUp,
                      style: TextStyle(
                        fontWeight: FontWeight.w400,
                        color: Colors.black,
                      ),
                    ),
                    onPressed: () {
                      _accountBloc.add(NewAccountRequested());

                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => SignUpPage(),
                          ));
                    },
                  )
                ],
              );
            },
          ),
        ));
  }
}
