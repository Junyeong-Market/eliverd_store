import 'package:equatable/equatable.dart';

import 'package:Eliverd/models/models.dart';

abstract class StoreState extends Equatable {
  const StoreState();

  @override
  List<Object> get props => [];
}

class StoreNotCreated extends StoreState {}

class RegisterersSearching extends StoreState {}

class RegisterersSelected extends StoreState {
  final List<User> registerers;

  const RegisterersSelected(this.registerers);

  @override
  List<Object> get props => [registerers];
}

class StoreCreated extends StoreState {}

class StoreError extends StoreState {}