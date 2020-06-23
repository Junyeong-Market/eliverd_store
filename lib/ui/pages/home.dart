import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:Eliverd/bloc/states/stockState.dart';
import 'package:Eliverd/bloc/events/stockEvent.dart';
import 'package:Eliverd/bloc/stockBloc.dart';

import 'package:Eliverd/models/models.dart';

import 'package:Eliverd/common/color.dart';
import 'package:Eliverd/common/string.dart';

import 'package:Eliverd/ui/pages/add_product.dart';
import 'package:Eliverd/ui/widgets/header.dart';
import 'package:Eliverd/ui/widgets/product.dart';

class HomePage extends StatefulWidget {
  final Store currentStore;

  const HomePage({Key key, @required this.currentStore}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _scrollController = ScrollController();
  final _scrollThreshold = 200.0;

  Completer<void> _refreshCompleter;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
    _refreshCompleter = Completer<void>();
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;

    return BlocProvider<StockBloc>.value(
      value: context.bloc<StockBloc>(),
      child: BlocConsumer<StockBloc, StockState>(
        listener: (context, state) {
          if (state is StockNotFetchedState) {
            context.bloc<StockBloc>().add(StockLoaded(widget.currentStore));

            _refreshCompleter?.complete();
            _refreshCompleter = Completer();
          }
        },
        builder: (context, state) {
          return Scaffold(
            key: Key('HomePage'),
            appBar: Header(
              height: height / 4.8,
              child: Column(
                children: <Widget>[
                  AppBar(
                    backgroundColor: eliverdColor,
                    actions: <Widget>[
                      IconButton(
                        icon: const Icon(Icons.search),
                        tooltip: HomePageStrings.searchProductDesc,
                        onPressed: () {
                          // TO-DO: 상품 조건적 검색 BLOC 구현
                          // TO-DO: 상품 검색 페이지로 Navigate
                        },
                      ),
                      IconButton(
                        icon: const Icon(Icons.add),
                        tooltip: HomePageStrings.addProductDesc,
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => AddProductPage(
                                currentStore: widget.currentStore,
                              ),
                            ),
                          );
                        },
                      ),
                    ],
                    elevation: 0.0,
                  ),
                  Align(
                    alignment: FractionalOffset(0.1, 0.0),
                    child: Text(
                      widget.currentStore.name,
                      style: const TextStyle(
                          color: Colors.white,
                          fontSize: 36.0,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
              ),
            ),
            body: state is StockFetchErrorState
                ? Center(
                    child: Text(ErrorMessages.stocksCannotbeFetched),
                  )
                : ((state is StockFetchSuccessState)
                    ? RefreshIndicator(
                        onRefresh: () {
                          context
                              .bloc<StockBloc>()
                              .add(StockLoaded(widget.currentStore));

                          return _refreshCompleter.future;
                        },
                        child: ListView.builder(
                          itemBuilder: (BuildContext context, int index) {
                            return index >= state.stocks.length
                                ? Center(
                                    child: CupertinoActivityIndicator(),
                                  )
                                : ProductCard(
                                    stock: state.stocks[index],
                                  );
                          },
                          itemCount: state.isAllFetched
                              ? state.stocks.length
                              : state.stocks.length + 1,
                          controller: _scrollController,
                        ),
                      )
                    : Center(
                        child: CupertinoActivityIndicator(),
                      )),
          );
        },
      ),
    );
  }

  void _onScroll() {
    final maxScroll = _scrollController.position.maxScrollExtent;
    final currentScroll = _scrollController.position.pixels;
    if (maxScroll - currentScroll <= _scrollThreshold) {
      context.bloc<StockBloc>().add(StockLoaded(widget.currentStore));
    }
  }
}
