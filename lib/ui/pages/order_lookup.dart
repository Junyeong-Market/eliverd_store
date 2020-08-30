import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:Eliverd/bloc/states/orderState.dart';
import 'package:Eliverd/bloc/events/orderEvent.dart';
import 'package:Eliverd/bloc/orderBloc.dart';

import 'package:Eliverd/models/models.dart';

import 'package:Eliverd/ui/widgets/order.dart';
import 'package:Eliverd/ui/widgets/header.dart';

class OrderLookupPage extends StatefulWidget {
  final Store store;

  const OrderLookupPage({Key key, @required this.store}) : super(key: key);

  @override
  _OrderLookupPageState createState() => _OrderLookupPageState();
}

class _OrderLookupPageState extends State<OrderLookupPage> {
  final _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();

    _scrollController.addListener(_onScroll);

    context.bloc<OrderBloc>().add(FetchOrder(
          store: widget.store,
        ));
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<OrderBloc, OrderState>(
      listener: (context, state) {
        WidgetsBinding.instance.addPostFrameCallback((_) {
          if (state is OrderFetched && !state.isAllFetched && _isBottom) {
            context.bloc<OrderBloc>().add(FetchOrder(
                  store: widget.store,
                ));
          }
        });
      },
      builder: (context, state) {
        return Scaffold(
          extendBodyBehindAppBar: true,
          appBar: Header(
            onBackButtonPressed: () {
              Navigator.pop(context);
            },
            title: '주문 내역',
          ),
          body: Padding(
            padding: EdgeInsets.only(
              top: kToolbarHeight + 128.0,
              left: 16.0,
              right: 16.0,
            ),
            child: state is OrderFetched
                ? (state.orders.length == 0
                    ? Center(
                        child: Text(
                          '주문 내역이 없네요.\n좀 더 분발해보세요!💪',
                          style: TextStyle(
                            color: Colors.black26,
                            fontWeight: FontWeight.w600,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      )
                    : ListView.builder(
                        padding: EdgeInsets.zero,
                        itemBuilder: (BuildContext context, int index) {
                          return index >= state.orders.length
                              ? Center(
                                  child: state.isAllFetched
                                      ? Column(
                                          children: [
                                            Divider(
                                              height: 16.0,
                                              indent: 160.0,
                                              endIndent: 160.0,
                                              thickness: 2.4,
                                              color: Colors.black12,
                                            ),
                                            Text(
                                              '여기까지 ${state.orders.length}번 주문하셨습니다.',
                                              style: TextStyle(
                                                color: Colors.black26,
                                                fontWeight: FontWeight.w600,
                                              ),
                                            ),
                                          ],
                                        )
                                      : CupertinoActivityIndicator(),
                                )
                              : PartialOrderWidget(
                                  partialOrder: state.orders[index],
                                );
                        },
                        itemCount: state.isAllFetched
                            ? state.orders.length
                            : state.orders.length + 1,
                        controller: _scrollController,
                      ))
                : (state is OrderError
                    ? Center(
                        child: Column(
                          children: [
                            ButtonTheme(
                              materialTapTargetSize:
                                  MaterialTapTargetSize.shrinkWrap,
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
                                    fontSize: 48.0,
                                  ),
                                ),
                                onPressed: () {
                                  context.bloc<OrderBloc>().add(FetchOrder(
                                        store: widget.store,
                                      ));
                                },
                                shape: RoundedRectangleBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(25.0)),
                                ),
                              ),
                            ),
                            Text(
                              '주문 내역을 불러오는 중 오류가 발생했습니다.\n다시 시도해주세요.',
                              style: TextStyle(
                                color: Colors.black26,
                                fontWeight: FontWeight.w600,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ],
                        ),
                      )
                    : Center(
                        child: CupertinoActivityIndicator(),
                      )),
          ),
        );
      },
    );
  }

  void _onScroll() {
    if (_isBottom)
      context.bloc<OrderBloc>().add(FetchOrder(
            store: widget.store,
          ));
  }

  bool get _isBottom {
    final maxScroll = _scrollController.position.maxScrollExtent;
    final currentScroll = _scrollController.offset;
    return currentScroll >= maxScroll;
  }
}
