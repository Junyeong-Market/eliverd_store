import 'package:equatable/equatable.dart';

import 'package:Eliverd/models/models.dart';

abstract class SearchManufacturerState extends Equatable {
  const SearchManufacturerState();

  @override
  List<Object> get props => [];
}

class ManufacturerNotFound extends SearchManufacturerState {}

class ManufacturerFound extends SearchManufacturerState {
  final List<Manufacturer> manufacturers;

  const ManufacturerFound(this.manufacturers);

  @override
  List<Object> get props => [manufacturers];
}

class ManufacturerSelected extends SearchManufacturerState {
  final Manufacturer manufacturer;

  const ManufacturerSelected(this.manufacturer);

  @override
  List<Object> get props => [manufacturer];
}

class ManufacturerError extends SearchManufacturerState {}