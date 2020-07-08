import 'package:equatable/equatable.dart';

import 'package:Eliverd/models/models.dart';

abstract class SearchManufacturerEvent extends Equatable {
  const SearchManufacturerEvent();

  @override
  List<Object> get props => [];
}

class SearchManufacturer extends SearchManufacturerEvent {
  final String keyword;

  const SearchManufacturer(this.keyword);

  @override
  List<Object> get props => [keyword];
}

class SelectManufacturer extends SearchManufacturerEvent {
  final List<Manufacturer> manufacturers;

  const SelectManufacturer(this.manufacturers);

  @override
  List<Object> get props => [manufacturers];
}