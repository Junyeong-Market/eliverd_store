import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geolocator/geolocator.dart';

import 'package:Eliverd/common/string.dart';

class SearchUserDialog extends StatefulWidget {
  @override
  _SearchUserDialogState createState() => _SearchUserDialogState();
}

class _SearchUserDialogState extends State<SearchUserDialog> {
  Completer<GoogleMapController> _controller = Completer();
  Position _selectedPosition;

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        brightness: Brightness.light,
        elevation: 0.0,
        iconTheme: IconThemeData(color: Colors.black),
        actions: <Widget>[
          ButtonTheme(
            materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
            minWidth: 0,
            height: 0,
            child: FlatButton(
              child: Text(
                '완료',
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 17.0,
                ),
              ),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ),
        ],
      ),
      body: ListView(
        padding: EdgeInsets.symmetric(
          horizontal: 20.0,
        ),
        children: <Widget>[
          CupertinoTextField(
            placeholder: RegisterStoreStrings.registererSearchDesc,
            onSubmitted: (value) {
              // TO-DO: 사업자 BLOC 구현 후 Search 이벤트 call
            },
          ),
          Container(
            width: width * 0.8,
            height: height * 0.3,
            child: FutureBuilder<CameraPosition>(
              future: _getCurrentLocation(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return GoogleMap(
                    mapType: MapType.normal,
                    initialCameraPosition: snapshot.data,
                    onMapCreated: (GoogleMapController controller) {
                      _controller.complete(controller);
                    },
                  );
                } else if (snapshot.hasError) {
                  return Center(
                    child: Text(
                      snapshot.error,
                    ),
                  );
                }

                return Center(
                  child: CupertinoActivityIndicator(),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Future<CameraPosition> _getCurrentLocation() async {
    setState(() async {
      _selectedPosition = await Geolocator().getCurrentPosition(desiredAccuracy: LocationAccuracy.bestForNavigation);
    });

    return CameraPosition(
      target: LatLng(_selectedPosition.latitude, _selectedPosition.longitude),
      zoom: 20.0,
    );
  }
}