import 'package:equatable/equatable.dart';

import 'package:Eliverd/models/models.dart';

abstract class StoreEvent extends Equatable {
  const StoreEvent();

  @override
  List<Object> get props => [];
}

class SearchRegisterers extends StoreEvent {}

class SelectRegisterers extends StoreEvent {
  final List<User> registerers;

  const SelectRegisterers(this.registerers);

  @override
  List<Object> get props => [registerers];
}

class CreateStore extends StoreEvent {
  final Store store;

  const CreateStore(this.store);

  @override
  List<Object> get props => [store];
}