import 'package:equatable/equatable.dart';

abstract class StoreState extends Equatable {
  const StoreState();

  @override
  List<Object> get props => [];
}

class StoreNotCreated extends StoreState {}

class StoreCreated extends StoreState {}

class StoreError extends StoreState {}