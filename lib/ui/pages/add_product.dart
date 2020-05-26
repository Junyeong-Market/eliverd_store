import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:Eliverd/ui/widgets/header.dart';
import 'package:Eliverd/common/string.dart';

// TO-DO: Camera 인터페이스 구현 후 정의하도록 하기
// import 'package:camera/camera.dart';

class AddProductPage extends StatefulWidget {
  @override
  _AddProductPageState createState() => _AddProductPageState();
}

class _AddProductPageState extends State<AddProductPage> {
  // TO-DO: Camera 인터페이스 구현 후 선언하도록 하기
  // CameraController _controller;
  // Future<void> _initializeControllerFuture;

  // bool isCameraReady = false;
  // bool showCapturedPhoto = false;

  var isBackButtonEnabled = false;
  var isNextButtonEnabled = true;
  var isLastPage = false;

  @override
  void initState() {
    super.initState();
    // TO-DO: Camera 인터페이스 구현 후 호출하도록 하기
    // _initializeCamera();
  }

  @override
  void dispose() {
    // TO-DO: Camera 인터페이스 구현 후 호출하도록 하기
    // _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;

    return Scaffold(
      key: Key('AddProductPage'),
      appBar: Header(
        height: height / 4.8,
        child: Column(
          children: <Widget>[
            AppBar(
              backgroundColor: Colors.lightBlue,
              elevation: 0.0,
            ),
            Align(
              alignment: FractionalOffset(0.1, 0.0),
              child: Text(
                addProductTitle,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 36.0,
                  fontWeight: FontWeight.bold),
              ),
            ),
          ],
        ),
      ),
      body: ListView(
        children: <Widget>[
          SizedBox(height: height / 30.0),
          Padding(
            padding: EdgeInsets.all(15.0),
            child: Text(
              '바코드 없음',
              style: TextStyle(
                fontWeight: FontWeight.w800,
                fontSize: 27.0,
              ),
            ),
          ),
          // TO-DO: CameraPreview 위젯을 추가하여 바코드 인식이 되도록 하기
          Padding(
            padding: EdgeInsets.all(15.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  '상품 이름을 입력하세요.',
                  style: TextStyle(
                    fontWeight: FontWeight.w800,
                    fontSize: 27.0,
                  ),
                ),
                TextField(
                  style: TextStyle(
                    fontSize: 20.0,
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.all(15.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  '상품 가격을 입력하세요.',
                  style: TextStyle(
                    fontWeight: FontWeight.w800,
                    fontSize: 27.0,
                  ),
                ),
                TextField(
                  textInputAction: TextInputAction.next,
                  keyboardType: TextInputType.numberWithOptions(
                    decimal: true,
                  ),
                  style: TextStyle(
                    fontSize: 20.0,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
      bottomNavigationBar: BottomAppBar(
        color: Colors.transparent,
        elevation: 0.0,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            CupertinoButton(
              child: Text(
                '이전',
                style: TextStyle(
                  color: isBackButtonEnabled ? Colors.blue : Colors.black45,
                  fontWeight: FontWeight.w400,
                  fontSize: 17.0,
                ),
              ),
              onPressed: isBackButtonEnabled ? () {} : null,
            ),
            CupertinoButton(
              child: Text(
                '다음',
                style: TextStyle(
                  color: isNextButtonEnabled ? Colors.blue : Colors.black45,
                  fontWeight: isLastPage ? FontWeight.bold : FontWeight.normal,
                  fontSize: 17.0,
                ),
              ),
              onPressed: isNextButtonEnabled ? () {} : null,
            ),
          ],
        ),
      ),
    );
  }

  // TO-DO: Camera 인터페이스 구현 후 정의하도록 하기
  /*
  Future<void> _initializeCamera() async {
    final cameras = await availableCameras();
    final selectedCamera = cameras.first;

    _controller = CameraController(selectedCamera, ResolutionPreset.medium);
    _initializeControllerFuture = _controller.initialize();

    if (!mounted) {
      return;
    }

    setState(() {
      isCameraReady = true;
    });
  }
  */
}
