import 'package:Eliverd/ui/pages/register_store.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:Eliverd/bloc/authBloc.dart';
import 'package:Eliverd/bloc/events/authEvent.dart';
import 'package:Eliverd/bloc/states/authState.dart';

import 'package:Eliverd/models/models.dart';

import 'package:Eliverd/ui/pages/splash_screen.dart';
import 'package:Eliverd/ui/pages/home.dart';
import 'package:Eliverd/ui/widgets/header.dart';
import 'package:Eliverd/ui/widgets/store.dart';

import 'package:Eliverd/common/key.dart';

class StoreSelectionPage extends StatefulWidget {
  final List<Store> stores;

  const StoreSelectionPage({Key key, @required this.stores}) : super(key: key);

  @override
  _StoreSelectionPageState createState() => _StoreSelectionPageState();
}

class _StoreSelectionPageState extends State<StoreSelectionPage> {
  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;

    return BlocConsumer<AuthenticationBloc, AuthenticationState>(
      listener: (context, state) {
        if (state is! Authenticated) {
          Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(
              builder: (context) => SplashScreenPage(),
            ),
                (route) => false,
          );
        }
      },
      builder: (context, state) {
        return Scaffold(
          key: StoreSelectionPageKeys.storeSelectionPage,
          extendBodyBehindAppBar: true,
          appBar: Header(
            onBackButtonPressed: () {
              context.bloc<AuthenticationBloc>().add(RevokeAuthentication());
            },
            title: '상점을 선택하세요.',
            actions: [
              ButtonTheme(
                materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                minWidth: 0,
                height: 0,
                child: FlatButton(
                  padding: EdgeInsets.only(
                    right: 16.0,
                  ),
                  key: HomePageKeys.addStockBtn,
                  textColor: Colors.white,
                  splashColor: Colors.transparent,
                  highlightColor: Colors.transparent,
                  child: Text(
                    '􀅼',
                    style: TextStyle(
                      fontWeight: FontWeight.w200,
                      fontSize: 22.0,
                    ),
                  ),
                  onPressed: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) => RegisterStorePage(
                          stores: widget.stores,
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
          body: GridView.builder(
            padding: EdgeInsets.only(
              top: kToolbarHeight + height * 0.15,
              left: 16.0,
              right: 16.0,
            ),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 4,
              mainAxisSpacing: 4,
              childAspectRatio: 0.7,
            ),
            itemBuilder: (context, index) {
              return InkWell(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => HomePage(
                        store: widget.stores[index],
                      ),
                    ),
                  );
                },
                highlightColor: Colors.transparent,
                child: StoreWidget(
                  store: widget.stores[index],
                ),
              );
            },
            itemCount: widget.stores.length,
          ),
        );
      },
    );
  }
}
