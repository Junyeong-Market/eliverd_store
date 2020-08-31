import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:Eliverd/bloc/states/stockState.dart';
import 'package:Eliverd/bloc/events/stockEvent.dart';
import 'package:Eliverd/bloc/stockBloc.dart';

import 'package:Eliverd/models/models.dart';

import 'package:Eliverd/common/string.dart';
import 'package:Eliverd/common/key.dart';

import 'package:Eliverd/ui/pages/add_stock.dart';
import 'package:Eliverd/ui/widgets/header.dart';
import 'package:Eliverd/ui/widgets/stock.dart';
import 'package:Eliverd/ui/pages/order_lookup.dart';

class HomePage extends StatefulWidget {
  final Store store;

  const HomePage({Key key, @required this.store}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);

    context.bloc<StockBloc>().add(LoadStock(
          store: widget.store,
        ));
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;

    return BlocConsumer<StockBloc, StockState>(
      listener: (context, state) {
        if (state is StockNotFetchedState) {
          context.bloc<StockBloc>().add(LoadStock(
                store: widget.store,
              ));
        }
      },
      builder: (context, state) {
        return Scaffold(
          key: HomePageKeys.homePage,
          extendBodyBehindAppBar: true,
          appBar: _buildMainHeader(),
          body: ListView(
            padding: EdgeInsets.symmetric(
              horizontal: 8.0,
            ),
            children: [
              SizedBox(
                height: kToolbarHeight + height * 0.15,
              ),
              CupertinoTextField(
                placeholder: '검색할 상품의 이름을 입력해주세요.',
                onChanged: (value) {
                  context.bloc<StockBloc>().add(LoadStock(
                        store: widget.store,
                        name: value,
                      ));
                },
              ),
              SizedBox(
                height: 4.0,
              ),
              Container(
                width: width,
                height: height * 0.7,
                child: _buildMainBody(state, height),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildMainHeader() => Header(
        onBackButtonPressed: () {
          Navigator.pop(context);
        },
        title: widget.store.name,
        actions: <Widget>[
          ButtonTheme(
            materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
            minWidth: 0,
            height: 0,
            child: FlatButton(
              padding: EdgeInsets.only(
                right: 8.0,
              ),
              key: HomePageKeys.searchProductBtn,
              textColor: Colors.white,
              splashColor: Colors.transparent,
              highlightColor: Colors.transparent,
              child: Text(
                '􀈫',
                style: TextStyle(
                  fontWeight: FontWeight.w200,
                  fontSize: 22.0,
                ),
              ),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => OrderLookupPage(
                      store: widget.store,
                    ),
                  ),
                );
              },
            ),
          ),
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
                    builder: (context) => AddStockPage(
                      store: widget.store,
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      );

  Widget _buildMainBody(StockState state, double height) {
    if (state is StockFetchErrorState) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            ButtonTheme(
              materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
              minWidth: 0,
              height: 0,
              child: FlatButton(
                padding: EdgeInsets.all(0.0),
                textColor: Colors.black12,
                splashColor: Colors.transparent,
                highlightColor: Colors.transparent,
                child: Text(
                  '⟳',
                  style: TextStyle(
                    fontWeight: FontWeight.w400,
                    fontSize: 56.0,
                  ),
                ),
                onPressed: () {
                  context.bloc<StockBloc>().add(LoadStock(
                        store: widget.store,
                      ));
                },
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(25.0)),
                ),
              ),
            ),
            Text(
              ErrorMessages.stocksCannotbeFetched,
              style: TextStyle(
                color: Colors.black26,
                fontWeight: FontWeight.w600,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      );
    } else if (state is StockFetchSuccessState) {
      if (state.stocks == null || state.stocks?.length == 0) {
        return Center(
          child: Text(
            HomePageStrings.stockEmptyMsg,
            style: TextStyle(
              color: Colors.black26,
              fontWeight: FontWeight.w600,
            ),
            textAlign: TextAlign.center,
          ),
        );
      }

      return ListView.builder(
        physics: const AlwaysScrollableScrollPhysics(),
        padding: EdgeInsets.all(0.0),
        key: HomePageKeys.stockList,
        itemBuilder: (BuildContext context, int index) {
          return index >= state.stocks.length
              ? Center(
                  child: Column(
                    children: <Widget>[
                      Divider(
                        height: 16.0,
                        indent: 160.0,
                        endIndent: 160.0,
                        thickness: 2.4,
                        color: Colors.black12,
                      ),
                      Text(
                        '현재 총합 ${state.stocks.length}개의 재고가 있습니다.',
                        style: TextStyle(
                          color: Colors.black26,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                )
              : StockWidget(
                  stock: state.stocks[index],
                );
        },
        itemCount:
            state.isAllFetched ? state.stocks.length : state.stocks.length + 1,
        controller: _scrollController,
      );
    } else {
      return Center(
        child: CupertinoActivityIndicator(),
      );
    }
  }

  void _onScroll() {
    if (_isTop || _isBottom)
      context.bloc<StockBloc>().add(LoadStock(
        store: widget.store,
      ));
  }

  bool get _isBottom {
    final maxScroll = _scrollController.position.maxScrollExtent;
    final currentScroll = _scrollController.offset;
    return currentScroll >= maxScroll;
  }

  bool get _isTop {
    final minScroll = _scrollController.position.minScrollExtent;
    final currentScroll = _scrollController.offset;
    return currentScroll <= minScroll;
  }
}
