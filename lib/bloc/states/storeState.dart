import 'package:equatable/equatable.dart';

import 'package:Eliverd/models/models.dart';

abstract class StoreState extends Equatable {
  const StoreState();

  @override
  List<Object> get props => [];
}

class StoreNotCreated extends StoreState {}

class StoreRegisterersRegistered extends StoreState {
  final List<dynamic> registerers;

  const StoreRegisterersRegistered(this.registerers);

  @override
  List<Object> get props => [registerers];
}

class StoreLocationRegistered extends StoreState {
  final Coordinate location;

  const StoreLocationRegistered(this.location);

  @override
  List<Object> get props => [location];
}

class StoreCreated extends StoreState {}

class StoreError extends StoreState {}