import 'package:Eliverd/common/color.dart';
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
  final ValueChanged<List<User>> onSelectedRegisterersChanged;

  const RegistererCards({Key key, @required this.onSelectedRegisterersChanged})
      : super(key: key);

  @override
  _RegistererCardsState createState() => _RegistererCardsState();
}

class _RegistererCardsState extends State<RegistererCards> {
  String _enteredKeyword;
  SearchUserBloc _searchUserBloc;

  List<User> _registerers = [];

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
        SizedBox(
          height: 16.0,
        ),
        Container(
          height: height * 0.5,
          child: BlocBuilder<SearchUserBloc, SearchUserState>(
            cubit: _searchUserBloc,
            builder: (context, state) {
              if (state is UserFound) {
                if (state.users.length == 0) {
                  return Text(
                    BottomSheetStrings.noResultMsg,
                    style: TextStyle(
                      color: Colors.black26,
                      fontWeight: FontWeight.w600,
                    ),
                  );
                }

                return CupertinoScrollbar(
                  child: ListView.builder(
                    itemBuilder: (BuildContext context, int index) {
                      return InkWell(
                          splashColor: Colors.transparent,
                          highlightColor: Colors.transparent,
                          onTap: () {
                            if (_registerers.contains(state.users[index])) {
                              _registerers.remove(state.users[index]);
                            } else {
                              _registerers.add(state.users[index]);
                            }

                            widget.onSelectedRegisterersChanged(_registerers);
                          },
                          child: Registerer(
                            user: state.users[index],
                            isSelected: _isSelected(state.users[index]),
                          ));
                    },
                    itemCount: state.users.length,
                  ),
                );
              }

              return Center(
                child: CupertinoActivityIndicator(),
              );
            },
          ),
        ),
      ],
    );
  }

  bool _isSelected(User user) {
    return _registerers.contains(user);
  }
}

class Registerer extends StatelessWidget {
  final User user;
  final bool isSelected;

  const Registerer({Key key, @required this.user, this.isSelected})
      : super(key: key);

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
                  colors: [eliverdLightColor, eliverdColor],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter),
              borderRadius: BorderRadius.all(Radius.circular(50.0)),
            ),
            child: Center(
              child: Text(
                user.nickname,
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
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        user.realname,
                        style: TextStyle(
                          fontWeight: FontWeight.w700,
                          fontSize: 20.0,
                        ),
                      ),
                      SizedBox(width: width / 240.0),
                      Visibility(
                        child: Text(
                          isSelected != null ? BottomSheetStrings.selected : '',
                          style: TextStyle(
                            fontWeight: FontWeight.w800,
                            color: eliverdColor,
                            fontSize: 16.0,
                          ),
                        ),
                        maintainSize: true,
                        maintainAnimation: true,
                        maintainState: true,
                        visible: isSelected ?? false,
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
