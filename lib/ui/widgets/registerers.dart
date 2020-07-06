import 'package:Eliverd/resources/providers/accountProvider.dart';
import 'package:Eliverd/resources/repositories/accountRepository.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;

import 'package:Eliverd/bloc/events/searchUserEvent.dart';
import 'package:Eliverd/bloc/states/searchUserState.dart';
import 'package:Eliverd/bloc/searchUserBloc.dart';

import 'package:Eliverd/models/models.dart';

import 'package:Eliverd/common/string.dart';

class RegistererCards extends StatefulWidget {
  @override
  _RegistererCardsState createState() => _RegistererCardsState();
}

class _RegistererCardsState extends State<RegistererCards> {
  String _enteredKeyword;
  SearchUserBloc _searchUserBloc;

  @override
  void initState() {
    super.initState();

    _searchUserBloc = SearchUserBloc(
      accountRepository: AccountRepository(
        accountAPIClient: AccountAPIClient(
          httpClient: http.Client(),
        ),
      ),
    );

    _searchUserBloc.add(SearchUser(_enteredKeyword));
  }

  @override
  void dispose() {
    _searchUserBloc.close();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;

    return Column(
      children: <Widget>[
        CupertinoTextField(
          placeholder: RegisterStoreStrings.registererSearchDesc,
          autofocus: true,
          onChanged: (value) {
            setState(() {
              _enteredKeyword = value;
            });

            _searchUserBloc.add(SearchUser(_enteredKeyword));
          },
          cursorRadius: Radius.circular(25.0),
        ),
        SizedBox(height: height / 48.0),
        Container(
          height: height * 0.5,
          child: BlocProvider<SearchUserBloc>.value(
            value: _searchUserBloc,
            child: BlocBuilder<SearchUserBloc, SearchUserState>(
              builder: (context, state) {
                if (state is UserFound) {
                  if (state.users.length == 0) {
                    return Text(
                      '사업자가 검색되지 않습니다. 다른 키워드로 검색해보세요.',
                      style: TextStyle(
                        color: Colors.black26,
                        fontWeight: FontWeight.w600,
                      ),
                    );
                  }

                  return ListView.builder(
                    itemBuilder: (BuildContext context, int index) {
                      return RegistererCard(
                        user: state.users[index],
                      );
                    },
                    itemCount: state.users.length,
                  );
                }

                return Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      CupertinoActivityIndicator(),
                      SizedBox(height: height / 120.0),
                      Text(
                        '검색 결과에 따라서 사업자 목록을 불러오고 있습니다.\n잠시만 기다려주세요.',
                        style: TextStyle(
                          color: Colors.black26,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ),
      ],
    );
  }
}

class RegistererCard extends StatefulWidget {
  final User user;

  const RegistererCard({Key key, @required this.user}) : super(key: key);

  @override
  _RegistererCardState createState() => _RegistererCardState();
}

class _RegistererCardState extends State<RegistererCard> {
  @override
  Widget build(BuildContext context) {
    return Text(
      widget.user.toString(),
    );
  }
}
