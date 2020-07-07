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
                      SearchSheetStrings.noResultMsg,
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
                        SearchSheetStrings.searchResultLoadingMsg,
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
    final width = MediaQuery.of(context).size.width;

    return Padding(
      padding: EdgeInsets.only(
        bottom: 10.0,
      ),
      child: Row(
        children: <Widget>[
          Container(
            width: 75.0,
            height: 75.0,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                  colors: [Colors.black12, Colors.black45],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter),
              borderRadius: BorderRadius.all(Radius.circular(50.0)),
            ),
            child: Center(
              child: Text(
                widget.user.nickname,
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 18.0,
                ),
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ),
          SizedBox(width: width / 60.0),
          Expanded(
            flex: 1,
            child: Container(
              height: 75.0,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        widget.user.realname,
                        style: TextStyle(
                          fontWeight: FontWeight.w700,
                          fontSize: 20.0,
                        ),
                      ),
                      SizedBox(width: width / 240.0),
                      Text(
                        widget.user.isSeller ? SearchSheetStrings.isSellerText : SearchSheetStrings.isCustomerText,
                        style: TextStyle(
                          fontWeight: FontWeight.w400,
                          color: Colors.black54,
                          fontSize: 16.0,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
