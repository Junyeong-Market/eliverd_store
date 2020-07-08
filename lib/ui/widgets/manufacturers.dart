import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;

import 'package:Eliverd/resources/providers/providers.dart';
import 'package:Eliverd/resources/repositories/repositories.dart';

import 'package:Eliverd/bloc/events/searchManufacturerEvent.dart';
import 'package:Eliverd/bloc/states/searchManufacturerState.dart';
import 'package:Eliverd/bloc/searchManufacturerBloc.dart';

import 'package:Eliverd/models/models.dart';

import 'package:Eliverd/common/string.dart';
import 'package:Eliverd/common/color.dart';

class Manufacturers extends StatefulWidget {
  final Manufacturer manufacturer;
  final ValueChanged<Manufacturer> onManufacturerChanged;

  Manufacturers({Key key,
    @required this.manufacturer,
    @required this.onManufacturerChanged})
      : super(key: key);

  @override
  _ManufacturersState createState() => _ManufacturersState();
}

class _ManufacturersState extends State<Manufacturers> {
  String _enteredKeyword;
  SearchManufacturerBloc _searchManufacturerBloc;

  Manufacturer _manufacturer;

  @override
  void initState() {
    super.initState();

    _searchManufacturerBloc = SearchManufacturerBloc(
      storeRepository: StoreRepository(
        storeAPIClient: StoreAPIClient(
          httpClient: http.Client(),
        ),
      ),
    );

    _searchManufacturerBloc.add(SearchManufacturer(_enteredKeyword));
  }

  @override
  void dispose() {
    _searchManufacturerBloc.close();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery
        .of(context)
        .size
        .height;

    return Column(
      children: <Widget>[
        CupertinoTextField(
          placeholder: ProductStrings.manufacturerSearchDesc,
          autofocus: true,
          onChanged: (value) {
            setState(() {
              _enteredKeyword = value;
            });

            _searchManufacturerBloc.add(SearchManufacturer(_enteredKeyword));
          },
          cursorRadius: Radius.circular(25.0),
        ),
        SizedBox(height: height / 48.0),
        Container(
          height: height * 0.3,
          child: BlocProvider<SearchManufacturerBloc>.value(
            value: _searchManufacturerBloc,
            child: BlocBuilder<SearchManufacturerBloc, SearchManufacturerState>(
              builder: (context, state) {
                if (state is ManufacturerFound) {
                  if (state.manufacturers.length == 0) {
                    return Text(
                      SearchSheetStrings.noResultMsg,
                      style: TextStyle(
                        color: Colors.black26,
                        fontWeight: FontWeight.w600,
                      ),
                    );
                  }

                  return CupertinoScrollbar(
                    child: ListView.builder(
                      itemBuilder: (BuildContext context, int index) {
                        return GestureDetector(
                          onTap: () {
                            setState(() {
                              if (_manufacturer == state.manufacturers[index]) {
                                _manufacturer = _manufacturer != null ? null : state.manufacturers[index];
                              } else {
                                _manufacturer = state.manufacturers[index];
                              }
                            });

                            widget.onManufacturerChanged(_manufacturer);
                          },
                          child: ManufacturerCard(
                            manufacturer: state.manufacturers[index],
                            isSelected: _isSelected(state.manufacturers[index]),
                          ),
                        );
                      },
                      itemCount: state.manufacturers.length,
                    ),
                  );
                }

                return Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      CupertinoActivityIndicator(),
                      SizedBox(height: height / 120.0),
                      Text(
                        SearchSheetStrings.searchResultLoadingMsg,
                        style: TextStyle(
                          color: Colors.black26,
                          fontWeight: FontWeight.w600,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ),
      ],
    );
  }

  bool _isSelected(Manufacturer manufacturer) {
    return widget.manufacturer == manufacturer;
  }
}

class ManufacturerCard extends StatelessWidget {
  final Manufacturer manufacturer;
  final bool isSelected;

  const ManufacturerCard({Key key, this.manufacturer, this.isSelected}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.zero,
      elevation: 0.0,
      color: Colors.transparent,
      shape: Border(
        bottom: BorderSide(
          color: Colors.black12,
          width: 1,
        ),
      ),
      child: Container(
        padding: EdgeInsets.symmetric(
          vertical: 4.0,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Text(
              manufacturer.name,
              style: TextStyle(
                fontWeight: FontWeight.w200,
                fontSize: 16.0,
              ),
            ),
            Text(
              isSelected ? ProductStrings.selected : '',
            ),
          ],
        ),
      ),
    );
  }
}
