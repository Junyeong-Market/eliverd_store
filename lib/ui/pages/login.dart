import 'package:Eliverd/common/color.dart';
import 'package:Eliverd/common/string.dart';
import 'package:Eliverd/resources/providers/providers.dart';
import 'package:Eliverd/resources/repositories/repositories.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:Eliverd/bloc/authBloc.dart';
import 'package:Eliverd/resources/providers/accountProvider.dart';
import 'package:Eliverd/resources/repositories/accountRepository.dart';
import 'package:Eliverd/bloc/states/authState.dart';
import 'package:Eliverd/bloc/accountBloc.dart';
import 'package:Eliverd/bloc/events/accountEvent.dart';
import 'package:Eliverd/bloc/events/authEvent.dart';
import 'package:flutter/widgets.dart';
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
    final _storeRepostiory = StoreRepository(
      storeAPIClient: StoreAPIClient(
        httpClient: http.Client(),
      ),
    );

    _authenticationBloc = AuthenticationBloc(
      accountRepository: _accountRepository,
      storeRepository: _storeRepostiory,
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
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          brightness: Brightness.light,
          elevation: 0.0,
        ),
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

                // TO-DO: 상점 고르기 페이지 구현 후 Navigate 구현
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => HomePage(currentStore: state.stores[0]),
                    ));
              } else if (state is NotAuthenticated ||
                  state is AuthenticationError) {
                errorOccurred = true;
              }
            },
            builder: (context, state) {
              return Padding(
                padding: EdgeInsets.only(
                  left: 50.0,
                  right: 50.0,
                ),
                child: ListView(
                  children: <Widget>[
                    Image(
                      width: width / 1.5,
                      height: width / 1.5,
                      image: AssetImage(
                          'assets/images/logo/eliverd_logo_original.png'),
                    ),
                    SizedBox(height: height / 24.0),
                    Visibility(
                      child: Column(
                        children: <Widget>[
                          Text(
                            ErrorMessages.loginErrorMessage,
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
                        labelText: SignInStrings.idText,
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
                        labelText: SignInStrings.passwordText,
                      ),
                    ),
                    SizedBox(height: height / 80.0),
                    CupertinoButton(
                      key: Key('SignInButton'),
                      child: Text(
                        SignInStrings.login,
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 16.0,
                        ),
                      ),
                      color: eliverdColor,
                      borderRadius: BorderRadius.circular(15.0),
                      padding: EdgeInsets.symmetric(
                        horizontal: 115.0,
                        vertical: 15.0,
                      ),
                      onPressed: () {
                        _authenticationBloc.add(SignInAuthentication(
                            _idController.text, _passwordController.text));
                      },
                    ),
                    FlatButton(
                      key: Key('SignUpButton'),
                      child: Text(
                        SignInStrings.notSignUp,
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
                    ),
                  ],
                ),
              );
            },
          ),
        ));
  }
}
