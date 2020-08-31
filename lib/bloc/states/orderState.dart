import 'package:Eliverd/models/models.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

abstract class OrderState extends Equatable {
  const OrderState();

  @override
  List<Object> get props => [];
}

class OrderInitial extends OrderState {}

class OrderFetched extends OrderState {
  final Store store;
  final List<PartialOrder> orders;
  final bool isAllFetched;
  final int page;

  const OrderFetched({@required this.store, @required this.orders, @required this.isAllFetched, this.page = 1});

  OrderFetched copyWith({Store store, List<PartialOrder> orders, bool isAllFetched, int page}) {
    return OrderFetched(
      store: store,
      orders: orders,
      isAllFetched: isAllFetched,
      page: page,
    );
  }

  @override
  List<Object> get props => [store, orders, isAllFetched, page];

  @override
  String toString() {
    return 'OrderFetched{ store: $store, orders: $orders, isAllFetched: $isAllFetched, page: $page }';
  }
}

class OrderInProgress extends OrderState {
  final String redirectURL;

  const OrderInProgress(this.redirectURL);

  @override
  List<Object> get props => [redirectURL];
}

class OrderInResume extends OrderState {
  final String redirectURL;

  const OrderInResume(this.redirectURL);

  @override
  List<Object> get props => [redirectURL];
}

class OrderDone extends OrderState {
  final Order order;

  const OrderDone(this.order);

  @override
  List<Object> get props => [order];
}

class OrderApproved extends OrderDone {
  final Order order;

  const OrderApproved(this.order) : super(order);

  @override
  List<Object> get props => [order];
}

class OrderCanceled extends OrderDone {
  final Order order;

  const OrderCanceled(this.order) : super(order);

  @override
  List<Object> get props => [order];
}

class OrderFailed extends OrderDone {
  final Order order;

  const OrderFailed(this.order) : super(order);

  @override
  List<Object> get props => [order];
}

class OrderError extends OrderState {}
