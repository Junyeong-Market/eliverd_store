import 'package:equatable/equatable.dart';

import 'package:Eliverd/models/models.dart';

abstract class StoreEvent extends Equatable {
  const StoreEvent();

  @override
  List<Object> get props => [];
}

class RegisterStoreRegisterers extends StoreEvent {
  final List<dynamic> registerers;

  const RegisterStoreRegisterers(this.registerers);

  @override
  List<Object> get props => [registerers];
}

class RegisterStoreLocation extends StoreEvent {
  final Coordinate location;

  const RegisterStoreLocation(this.location);

  @override
  List<Object> get props => [location];
}

class CreateStore extends StoreEvent {
  final Store store;

  const CreateStore(this.store);

  @override
  List<Object> get props => [store];
}