import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:barcode_widget/barcode_widget.dart';

import 'package:Eliverd/models/models.dart';

import 'package:Eliverd/ui/widgets/delivery.dart';
import 'package:Eliverd/ui/widgets/header.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class DeliveryDisplayPage extends StatefulWidget {
  final PartialOrder partialOrder;

  const DeliveryDisplayPage({Key key, @required this.partialOrder})
      : super(key: key);

  @override
  _DeliveryDisplayPageState createState() => _DeliveryDisplayPageState();
}

class _DeliveryDisplayPageState extends State<DeliveryDisplayPage> {
  Future<String> shippingAddress;

  @override
  void initState() {
    super.initState();

    shippingAddress =
        _getAddressFromCoordinate(widget.partialOrder?.destination ??
            Coordinate(
              lat: 0,
              lng: 0,
            ));
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: Header(
        onBackButtonPressed: () {
          Navigator.pop(context);
        },
        title: '배송 대기',
      ),
      body: ListView(
        padding: EdgeInsets.only(
          top: kToolbarHeight + height * 0.15,
          left: 16.0,
          right: 16.0,
        ),
        children: [
          Text(
            '아래 QR 코드를 스캔하세요.',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 22.0,
            ),
            textAlign: TextAlign.left,
          ),
          Text(
            '소비자용 Eliverd 애플리케이션에서 QR 코드를 스캔한 뒤 배송을 시작하세요.',
            style: TextStyle(
              color: Colors.black45,
              fontSize: 16.0,
            ),
            textAlign: TextAlign.left,
          ),
          SizedBox(
            height: 16.0,
          ),
          BarcodeWidget(
            data: widget.partialOrder?.transportToken ?? '',
            barcode: Barcode.qrCode(),
            width: width * 0.5,
            height: width * 0.5,
            errorBuilder: (context, error) {
              return Text(
                '바코드를 불러올 수 없습니다.',
                style: TextStyle(
                  color: Colors.black26,
                  fontWeight: FontWeight.w600,
                ),
                textAlign: TextAlign.center,
              );
            },
          ),
          SizedBox(
            height: 24.0,
          ),
          Text(
            '배달할 상품',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 22.0,
            ),
            textAlign: TextAlign.left,
          ),
          DeliveryWidget(
            partialOrder: widget.partialOrder,
          ),
          SizedBox(
            height: 24.0,
          ),
          Text(
            '배송지 살펴보기',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 22.0,
            ),
            textAlign: TextAlign.left,
          ),
          SizedBox(
            height: 8.0,
          ),
          Container(
            height: height * 0.3,
            child: FutureBuilder<String>(
              future: shippingAddress,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.done &&
                    snapshot.hasData) {
                  return GoogleMap(
                    mapType: MapType.normal,
                    initialCameraPosition: CameraPosition(
                      target: LatLng(widget.partialOrder?.destination?.lat ?? 0,
                          widget.partialOrder?.destination?.lng ?? 0),
                      zoom: 16.0,
                    ),
                    zoomGesturesEnabled: false,
                    tiltGesturesEnabled: false,
                    markers: Set.of([
                      Marker(
                        markerId: MarkerId('배송지'),
                        position: LatLng(
                            widget.partialOrder?.destination?.lat ?? 0,
                            widget.partialOrder?.destination?.lng ?? 0),
                        infoWindow:
                            InfoWindow(title: '배송지', snippet: snapshot.data),
                      )
                    ]),
                  );
                }

                return CupertinoActivityIndicator();
              },
            ),
          ),
          SizedBox(
            height: 8.0,
          ),
        ],
      ),
    );
  }

  Future<String> _getAddressFromCoordinate(Coordinate coordinate) async {
    if (coordinate == null) {
      return '';
    }

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
