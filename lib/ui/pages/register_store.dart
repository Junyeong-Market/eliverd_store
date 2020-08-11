import 'package:Eliverd/ui/pages/home.dart';
import 'package:Eliverd/ui/widgets/registerers.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';

import 'package:Eliverd/bloc/storeBloc.dart';
import 'package:Eliverd/bloc/states/storeState.dart';
import 'package:Eliverd/bloc/events/storeEvent.dart';

import 'package:Eliverd/models/models.dart';

import 'package:Eliverd/common/string.dart';
import 'package:Eliverd/common/color.dart';
import 'package:Eliverd/common/key.dart';

import 'package:Eliverd/ui/widgets/form_text.dart';
import 'package:Eliverd/ui/widgets/form_text_field.dart';
import 'package:Eliverd/ui/widgets/search_user.dart';
import 'package:Eliverd/ui/widgets/search_location.dart';

class RegisterStorePage extends StatefulWidget {
  @override
  _RegisterStorePageState createState() => _RegisterStorePageState();
}

class _RegisterStorePageState extends State<RegisterStorePage> {
  final _storeNameController = TextEditingController();
  final _storeDescController = TextEditingController();
  final _registeredNumberController = TextEditingController();

  final _descNavigationFocus = FocusNode();
  final _registeredNumberNavigationFocus = FocusNode();

  bool _isNameSubmitted = false;
  bool _isDescSubmitted = false;
  bool _isRegisteredNumberSubmitted = false;

  List<User> _registerers = [];
  Coordinate _storeLocation;

  Future<String> _locationAddress;

  Store _createdStore;

  void _registerStore() {
    final formattedRegisteredNumber =
        _registeredNumberController.text.replaceAll('-', '');

    _createdStore = Store(
      name: _storeNameController.text,
      description: _storeDescController.text,
      registeredNumber: formattedRegisteredNumber,
      registerers: _registerers,
      location: _storeLocation,
    );

    context.bloc<StoreBloc>().add(CreateStore(_createdStore));
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;

    return BlocConsumer<StoreBloc, StoreState>(
      listener: (context, state) {
        if (state is StoreRegisterersRegistered) {
          setState(() {
            _registerers = state.registerers;
          });
        }

        if (state is StoreLocationRegistered) {
          setState(() {
            _storeLocation = state.location;
          });

          _locationAddress = _getAddressFromCoordinate(_storeLocation);
        }

        if (state is StoreCreated) {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => HomePage(
                currentStore: _createdStore,
              ),
            ),
          );
        }
      },
      builder: (context, state) {
        return Scaffold(
          key: RegisterStorePageKeys.registerStorePage,
          extendBodyBehindAppBar: true,
          body: Padding(
            padding: EdgeInsets.only(
              left: 20.0,
              right: 20.0,
              top: 40.0,
            ),
            child: ListView(
              children: <Widget>[
                Text(
                  TitleStrings.registerStoreTitle,
                  style: const TextStyle(
                    color: Colors.black,
                    fontSize: 32.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: height / 48.0),
                Visibility(
                  child: _buildStoreNameSection(height),
                  maintainSize: true,
                  maintainAnimation: true,
                  maintainState: true,
                  visible: true,
                ),
                Visibility(
                  child: _buildStoreDescSection(height),
                  maintainSize: true,
                  maintainAnimation: true,
                  maintainState: true,
                  visible: _isNameSubmitted,
                ),
                Visibility(
                  child: _buildRegisteredNumberSection(height),
                  maintainSize: true,
                  maintainAnimation: true,
                  maintainState: true,
                  visible: _isDescSubmitted,
                ),
                Visibility(
                  child: _buildRegisterRegisterersSection(),
                  maintainSize: true,
                  maintainAnimation: true,
                  maintainState: true,
                  visible: _isRegisteredNumberSubmitted,
                ),
                SizedBox(height: height / 120.0),
                Visibility(
                  child: _buildRegisterers(height),
                  maintainSize: true,
                  maintainAnimation: true,
                  maintainState: true,
                  visible: _registerers.length != 0,
                ),
                SizedBox(height: height / 48.0),
                Visibility(
                  child: _buildRegisterLocationSection(state, height),
                  maintainSize: true,
                  maintainAnimation: true,
                  maintainState: true,
                  visible: _registerers.length != 0,
                ),
                SizedBox(height: height / 120.0),
                Visibility(
                  child: _buildAddressText(),
                  maintainSize: true,
                  maintainAnimation: true,
                  maintainState: true,
                  visible: _storeLocation != null,
                ),
                SizedBox(height: height / 120.0),
                Visibility(
                  child: Text(
                    ErrorMessages.registerStoreNotProceed,
                    style: TextStyle(
                      color: Colors.red,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  maintainSize: false,
                  maintainAnimation: true,
                  maintainState: true,
                  visible: state is StoreError,
                ),
              ],
            ),
          ),
          bottomNavigationBar: Padding(
            padding: EdgeInsets.only(
              left: 20.0,
              right: 20.0,
              bottom: 20.0,
            ),
            child: BottomAppBar(
              color: Colors.transparent,
              elevation: 0.0,
              child: _buildSubmitBtn(),
            ),
          ),
        );
      },
    );
  }

  final _storeNameRegex = FilteringTextInputFormatter(
    RegExp("[a-zA-Zㄱ-ㅎㅏ-ㅣ가-힣 ]"),
    allow: true,
  );
  final _registeredNumberRegex = [
    FilteringTextInputFormatter(
      RegExp("[0-9^\s]"),
      allow: true,
    ),
    RegisterNumberTextInputFormatter(),
  ];

  Widget _buildStoreNameSection(double height) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          FormText(
            controller: _storeNameController,
            textWhenCompleted: RegisterStoreStrings.storeNameTitle,
            textWhenNotCompleted:
                RegisterStoreStrings.storeNameTitleWhenImcompleted,
          ),
          SizedBox(height: height / 120.0),
          FormTextField(
            controller: _storeNameController,
            isFocused: true,
            isEnabled: !_isNameSubmitted,
            regex: _storeNameRegex,
            maxLength: 50,
            helperText: RegisterStoreStrings.storeNameHelperText,
            onSubmitted: (value) {
              if (_storeNameController.text.length != 0) {
                setState(() {
                  _isNameSubmitted = true;
                });

                _descNavigationFocus.requestFocus();
              }
            },
          ),
          SizedBox(height: height / 120.0),
        ],
      );

  Widget _buildStoreDescSection(double height) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          FormText(
            controller: _storeDescController,
            textWhenCompleted: RegisterStoreStrings.storeDescTitle,
            textWhenNotCompleted:
                RegisterStoreStrings.storeDescTitleWhenImcompleted,
          ),
          SizedBox(height: height / 120.0),
          FormTextField(
            controller: _storeDescController,
            helperText: RegisterStoreStrings.storeDescHelperText,
            isEnabled: !_isDescSubmitted,
            focusNode: _descNavigationFocus,
            onSubmitted: (value) {
              if (_storeDescController.text.length != 0) {
                setState(() {
                  _isDescSubmitted = true;
                });

                _registeredNumberNavigationFocus.requestFocus();
              } else {
                _descNavigationFocus.requestFocus();
              }
            },
          ),
          SizedBox(height: height / 120.0),
        ],
      );

  Widget _buildRegisteredNumberSection(double height) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          FormText(
            controller: _registeredNumberController,
            textWhenCompleted: RegisterStoreStrings.registerNumberTitle,
            textWhenNotCompleted:
                RegisterStoreStrings.registerNumberTitleWhenImcompleted,
          ),
          SizedBox(height: height / 120.0),
          FormTextField(
            controller: _registeredNumberController,
            regex: _registeredNumberRegex,
            maxLength: 12,
            isEnabled: !_isRegisteredNumberSubmitted,
            helperText: RegisterStoreStrings.registerNumberHelperText,
            focusNode: _registeredNumberNavigationFocus,
            onSubmitted: (value) {
              if (_registeredNumberController.text.length != 0) {
                setState(() {
                  _isRegisteredNumberSubmitted = true;
                });

                _registeredNumberNavigationFocus.unfocus();
              } else {
                _registeredNumberNavigationFocus.requestFocus();
              }
            },
          ),
          SizedBox(height: height / 120.0),
        ],
      );

  Widget _buildRegisterRegisterersSection() => Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            _registerers.length == 0
                ? RegisterStoreStrings.reigsterersTitleWhenImcompleted
                : RegisterStoreStrings.reigsterersTitle,
            style: TextStyle(
              fontWeight: FontWeight.w800,
              fontSize: 26.0,
            ),
          ),
          Visibility(
            child: ButtonTheme(
              padding: EdgeInsets.all(2.0),
              materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
              minWidth: 0,
              height: 0,
              child: FlatButton(
                child: Text(
                  '􀅼',
                  style: TextStyle(
                    fontWeight: FontWeight.w400,
                    fontSize: 22.0,
                  ),
                ),
                onPressed: () {
                  showModalBottomSheet(
                    context: context,
                    builder: (context) => SearchUserDialog(),
                    isScrollControlled: true,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(30.0),
                        topRight: Radius.circular(30.0),
                      ),
                    ),
                  );
                },
              ),
            ),
            maintainSize: true,
            maintainAnimation: true,
            maintainState: true,
            visible: _registerers.length == 0,
          ),
        ],
      );

  Widget _buildRegisterers(double height) => Container(
        height: height * 0.12,
        child: CupertinoScrollbar(
          child: ListView.builder(
            itemBuilder: (BuildContext context, int index) {
              return Registerer(
                user: _registerers[index],
              );
            },
            itemCount: _registerers.length,
          ),
        ),
      );

  Widget _buildRegisterLocationSection(StoreState state, double height) =>
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                _storeLocation == null
                    ? RegisterStoreStrings.storeLocationTitleWhenImcompleted
                    : RegisterStoreStrings.storeLocationTitle,
                style: TextStyle(
                  fontWeight: FontWeight.w800,
                  fontSize: 26.0,
                ),
              ),
              Visibility(
                child: ButtonTheme(
                  padding: EdgeInsets.all(2.0),
                  materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                  minWidth: 0,
                  height: 0,
                  child: FlatButton(
                    child: Text(
                      '􀅼',
                      style: TextStyle(
                        fontWeight: FontWeight.w400,
                        fontSize: 22.0,
                      ),
                    ),
                    onPressed: () {
                      showModalBottomSheet(
                        context: context,
                        builder: (context) => SearchLocationDialog(),
                        isScrollControlled: true,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(30.0),
                            topRight: Radius.circular(30.0),
                          ),
                        ),
                      );
                    },
                  ),
                ),
                maintainSize: true,
                maintainAnimation: true,
                maintainState: true,
                visible: _storeLocation == null,
              ),
            ],
          ),
        ],
      );

  Widget _buildAddressText() => FutureBuilder(
        future: _locationAddress,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            if (snapshot.hasData) {
              return Text(
                snapshot.data,
                style: TextStyle(
                  fontWeight: FontWeight.w300,
                  fontSize: 16.0,
                ),
              );
            } else {
              return RefreshIndicator(
                child: Row(
                  children: <Widget>[
                    ButtonTheme(
                      materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                      minWidth: 0,
                      height: 0,
                      child: FlatButton(
                        padding: EdgeInsets.all(0.0),
                        textColor: Colors.black12,
                        child: Text(
                          '⟳',
                          style: TextStyle(
                            fontWeight: FontWeight.w400,
                            fontSize: 56.0,
                          ),
                        ),
                        onPressed: () {
                          return _getAddressFromCoordinate(_storeLocation);
                        },
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(25.0)),
                        ),
                      ),
                    ),
                    Text(
                      ErrorMessages.retryForFetchingAddress,
                      style: TextStyle(
                        color: Colors.black26,
                        fontWeight: FontWeight.w600,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
                onRefresh: () {
                  return _getAddressFromCoordinate(_storeLocation);
                },
              );
            }
          }

          return Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text(
                RegisterStoreStrings.waitUntilAddressFetched,
                style: TextStyle(
                  color: Colors.black26,
                  fontWeight: FontWeight.w600,
                ),
                textAlign: TextAlign.center,
              ),
              CupertinoActivityIndicator(),
            ],
          );
        },
      );

  Widget _buildSubmitBtn() => CupertinoButton(
        key: RegisterStorePageKeys.registerStoreBtn,
        child: Text(
          RegisterStoreStrings.registerBtnDesc,
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 16.0,
          ),
        ),
        color: eliverdColor,
        borderRadius: BorderRadius.circular(15.0),
        padding: EdgeInsets.symmetric(vertical: 15.0),
        onPressed: _storeLocation == null ? null : _registerStore,
      );

  Future<String> _getAddressFromCoordinate(Coordinate coordinate) async {
    List<Placemark> placemarks = await Geolocator().placemarkFromCoordinates(
      coordinate.lat,
      coordinate.lng,
      localeIdentifier: 'ko_KR',
    );

    return placemarks
        .map((placemark) =>
            '${placemark.country} ${placemark.administrativeArea} ${placemark.locality} ${placemark.name} ${placemark.postalCode}')
        .join(',');
  }
}

class RegisterNumberTextInputFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    final newTextLength = newValue.text.length;
    final newText = StringBuffer();

    int selectionIndex = newValue.selection.end;
    int usedSubstringIndex = 0;

    if (newTextLength >= 4) {
      newText.write(newValue.text.substring(0, usedSubstringIndex = 3) + '-');
      if (newValue.selection.end >= 3) selectionIndex++;
    }

    if (newTextLength >= 6) {
      newText.write(newValue.text.substring(3, usedSubstringIndex = 5) + '-');
      if (newValue.selection.end >= 5) selectionIndex++;
    }

    if (newTextLength >= usedSubstringIndex)
      newText.write(newValue.text.substring(usedSubstringIndex));
    return TextEditingValue(
      text: newText.toString(),
      selection: TextSelection.collapsed(offset: selectionIndex),
    );
  }
}
