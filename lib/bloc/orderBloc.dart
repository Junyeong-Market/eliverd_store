import 'package:rxdart/rxdart.dart';

import 'package:meta/meta.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:Eliverd/resources/repositories/repositories.dart';

import 'package:Eliverd/bloc/events/orderEvent.dart';
import 'package:Eliverd/bloc/states/orderState.dart';

class OrderBloc extends Bloc<OrderEvent, OrderState> {
  final PurchaseRepository purchaseRepository;

  OrderBloc({@required this.purchaseRepository})
      : assert(PurchaseRepository != null),
        super(OrderInitial());

  @override
  Stream<Transition<OrderEvent, OrderState>> transformEvents(
    Stream<OrderEvent> events,
    TransitionFunction<OrderEvent, OrderState> transitionFn,
  ) {
    return super.transformEvents(
      events.debounceTime(const Duration(seconds: 1)),
      transitionFn,
    );
  }

  @override
  Stream<OrderState> mapEventToState(OrderEvent event) async* {
    if (event is FetchOrder) {
      yield* _mapFetchOrderToState(event);
    } else if (event is ProceedOrder) {
      yield* _mapProceedOrderToState(event);
    } else if (event is ApproveOrder) {
      yield* _mapApproveOrderToState(event);
    } else if (event is CancelOrder) {
      yield* _mapCancelOrderToState(event);
    } else if (event is FailOrder) {
      yield* _mapFailOrderToState(event);
    }
  }

  Stream<OrderState> _mapFetchOrderToState(FetchOrder event) async* {
    var currentState = state;

    if (currentState is OrderFetched && currentState.orders.first.store != event.store) {
      currentState = OrderInitial();
    }

    if (!_isOrderAllFetched(currentState)) {
      try {
        if (currentState is! OrderFetched) {
          yield OrderInitial();

          final orders = await purchaseRepository.fetchOrder(event.store);

          yield orders.isEmpty || orders.length != 20
              ? OrderFetched(
                  orders: orders,
                  isAllFetched: true,
                  page: 1,
                )
              : OrderFetched(
                  orders: orders,
                  isAllFetched: false,
                  page: 2,
                );
        } else if (currentState is OrderFetched) {
          final orders = await purchaseRepository.fetchOrder(
              event.store, currentState.page);

          yield orders.isEmpty || orders.length != 20
              ? currentState.copyWith(
                  orders: currentState.orders,
                  isAllFetched: true,
                  page: currentState.page,
                )
              : OrderFetched(
                  orders: currentState.orders + orders,
                  isAllFetched: false,
                  page: currentState.page + 1,
                );
        }
      } catch (_) {
        yield OrderError();
      }
    }
  }

  Stream<OrderState> _mapProceedOrderToState(ProceedOrder event) async* {
    try {
      final redirectURL = await purchaseRepository.createOrder(
          event.items, event.amounts, event.shippingDestination);

      yield OrderInProgress(redirectURL);
    } catch (_) {
      yield OrderError();
    }
  }

  Stream<OrderState> _mapApproveOrderToState(ApproveOrder event) async* {
    try {
      final order = await purchaseRepository.approveOrder(event.url);

      yield OrderApproved(order);
    } catch (_) {
      yield OrderError();
    }
  }

  Stream<OrderState> _mapCancelOrderToState(CancelOrder event) async* {
    try {
      final order = await purchaseRepository.cancelOrder(event.url);

      yield OrderCanceled(order);
    } catch (_) {
      yield OrderError();
    }
  }

  Stream<OrderState> _mapFailOrderToState(FailOrder event) async* {
    try {
      final order = await purchaseRepository.failOrder(event.url);

      yield OrderFailed(order);
    } catch (_) {
      yield OrderError();
    }
  }

  bool _isOrderAllFetched(OrderState state) =>
      state is OrderFetched && state.isAllFetched;
}
