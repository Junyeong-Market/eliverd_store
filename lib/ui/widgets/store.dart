import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:Eliverd/models/models.dart';

class StoreWidget extends StatelessWidget {
  final Store store;

  const StoreWidget({Key key, @required this.store}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Container(
          width: height * 0.22,
          height: height * 0.22,
          decoration: BoxDecoration(
            color: Colors.black12,
            borderRadius: BorderRadius.circular(10.0),
          ),
          child: Center(
            child:
            Text(
              store.name,
              maxLines: 1,
              textAlign: TextAlign.left,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w600,
                fontSize: 18.0,
              ),
            ),
          ),
        ),
        SizedBox(
          height: 8.0,
        ),
        Text(
          store.registerers.first.realname +
              ((store.registerers.length > 1)
                  ? ' 외 ${store.registerers.length - 1}명의'
                  : '') +
              ' 사업자',
          maxLines: 1,
          textAlign: TextAlign.right,
          overflow: TextOverflow.ellipsis,
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.w600,
            fontSize: 14.0,
          ),
        ),
        Text(
          '사업자등록번호: ${formattedRegistererNumber(store.registeredNumber)}',
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.w600,
            fontSize: 11.0,
          ),
        ),
        Text(
          store.description,
          maxLines: 3,
          textAlign: TextAlign.left,
          overflow: TextOverflow.ellipsis,
          style: TextStyle(
            color: Colors.black45,
            fontWeight: FontWeight.w500,
            fontSize: 13.0,
          ),
        ),
      ],
    );
  }

  String formattedRegistererNumber(String value) {
    return value.substring(0, 3) +
        '-' +
        value.substring(3, 5) +
        '-' +
        value.substring(5);
  }
}
