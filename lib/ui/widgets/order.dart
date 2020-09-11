import 'package:Eliverd/common/color.dart';
import 'package:Eliverd/ui/pages/delivery_display.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:intl/intl.dart';

import 'package:Eliverd/models/models.dart';

import 'package:Eliverd/ui/widgets/stock.dart';

class PartialOrderWidget extends StatelessWidget {
  final PartialOrder partialOrder;

  const PartialOrderWidget({Key key, @required this.partialOrder});

  @override
  Widget build(BuildContext context) {
    final int semiTotal = partialOrder.stocks
        .map((OrderedStock orderedStock) =>
            orderedStock.stock.price * orderedStock.amount)
        .reduce((a, b) => a + b);

    final simplifiedStocks = partialOrder.stocks.length >= 3
        ? partialOrder.stocks.sublist(0, 2)
        : partialOrder.stocks;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        Divider(
          height: 4.0,
          thickness: 1.0,
          color: Colors.black,
        ),
        for (var orderedStock in simplifiedStocks)
          StockOnOrder(
            orderedStock: orderedStock,
          ),
        Visibility(
          child: Text(
            '외 ${partialOrder.stocks.length - 2}개의 상품',
            textAlign: TextAlign.right,
            style: TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: 18.0,
            ),
          ),
          maintainSize: false,
          visible: partialOrder.stocks.length >= 3,
        ),
        SizedBox(
          height: 8.0,
        ),
        Divider(
          height: 4.0,
          thickness: 1.0,
        ),
        SizedBox(
          height: 8.0,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Text(
              '주문 일자',
              maxLines: 1,
              textAlign: TextAlign.right,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                color: Colors.black45,
                fontWeight: FontWeight.w600,
                fontSize: 14.0,
              ),
            ),
            Text(
              formattedDate(partialOrder.createdAt),
              maxLines: 1,
              textAlign: TextAlign.right,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.w600,
                fontSize: 16.0,
              ),
            ),
          ],
        ),
        SizedBox(
          height: 4.0,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Text(
              '점포명',
              maxLines: 1,
              textAlign: TextAlign.right,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                color: Colors.black45,
                fontWeight: FontWeight.w600,
                fontSize: 14.0,
              ),
            ),
            Text(
              partialOrder.store.name,
              maxLines: 1,
              textAlign: TextAlign.right,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.w600,
                fontSize: 16.0,
              ),
            ),
          ],
        ),
        SizedBox(
          height: 4.0,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Text(
              '대표자',
              maxLines: 1,
              textAlign: TextAlign.right,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                color: Colors.black45,
                fontWeight: FontWeight.w600,
                fontSize: 14.0,
              ),
            ),
            Text(
              '${partialOrder.store.registerers[0].realname}' +
                  (partialOrder.store.registerers.length == 1
                      ? ''
                      : ' 외 ${partialOrder.store.registerers.length - 1}명'),
              maxLines: 1,
              textAlign: TextAlign.right,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.w600,
                fontSize: 16.0,
              ),
            ),
          ],
        ),
        SizedBox(
          height: 4.0,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Text(
              '사업자등록번호',
              maxLines: 1,
              textAlign: TextAlign.right,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                color: Colors.black45,
                fontWeight: FontWeight.w600,
                fontSize: 14.0,
              ),
            ),
            Text(
              formattedRegistererNumber(partialOrder.store.registeredNumber),
              maxLines: 1,
              textAlign: TextAlign.right,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.w600,
                fontSize: 16.0,
              ),
            ),
          ],
        ),
        SizedBox(
          height: 4.0,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Text(
              '합계',
              maxLines: 1,
              textAlign: TextAlign.right,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                color: Colors.black45,
                fontWeight: FontWeight.w600,
                fontSize: 14.0,
              ),
            ),
            Text(
              '${formattedPrice(semiTotal)}',
              maxLines: 1,
              textAlign: TextAlign.right,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.w600,
                decoration: TextDecoration.underline,
                fontSize: 17.0,
              ),
            ),
          ],
        ),
        SizedBox(
          height: 8.0,
        ),
        Divider(
          height: 4.0,
          thickness: 1.0,
        ),
        SizedBox(
          height: 8.0,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Text(
              '배송 상태',
              maxLines: 1,
              textAlign: TextAlign.right,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                color: Colors.black45,
                fontWeight: FontWeight.w600,
                fontSize: 14.0,
              ),
            ),
            Text(
              DeliveryStatus.formatDeliveryStatus(partialOrder.status),
              maxLines: 1,
              textAlign: TextAlign.right,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.w600,
                fontSize: 16.0,
              ),
            ),
          ],
        ),
        SizedBox(
          height: 4.0,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Text(
              '배송원',
              maxLines: 1,
              textAlign: TextAlign.right,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                color: Colors.black45,
                fontWeight: FontWeight.w600,
                fontSize: 14.0,
              ),
            ),
            Text(
              partialOrder?.transport?.realname ?? '배정 안됨',
              maxLines: 1,
              textAlign: TextAlign.right,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.w600,
                fontSize: 16.0,
              ),
            ),
          ],
        ),
        SizedBox(
          height: 8.0,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.max,
          children: [
            Expanded(
              child: CupertinoButton(
                color: eliverdColor,
                disabledColor: Colors.black12,
                child: Text(
                  '배송 시작',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 17.0,
                  ),
                ),
                onPressed: isReadyToDeliver
                    ? () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => DeliveryDisplayPage(
                              partialOrder: partialOrder,
                            ),
                          ),
                        );
                      }
                    : null,
                borderRadius: BorderRadius.circular(10.0),
                padding: EdgeInsets.symmetric(vertical: 16.0),
              ),
            ),
            SizedBox(
              width: 4.0,
            ),
            Expanded(
              child: CupertinoButton(
                color: eliverdColor,
                disabledColor: Colors.black12,
                child: Text(
                  '배송 완료 요청',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 17.0,
                  ),
                ),
                onPressed: isDeliveryCompleted
                    ? () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => DeliveryDisplayPage(
                              partialOrder: partialOrder,
                            ),
                          ),
                        );
                      }
                    : null,
                borderRadius: BorderRadius.circular(10.0),
                padding: EdgeInsets.symmetric(vertical: 16.0),
              ),
            ),
          ],
        ),
        SizedBox(
          height: 8.0,
        ),
      ],
    );
  }

  bool get isReadyToDeliver => partialOrder.status == DeliveryStatus.READY;

  bool get isDeliveryCompleted =>
      partialOrder.status == DeliveryStatus.DELIVERING;

  String formattedPrice(int price) => NumberFormat.currency(
        locale: 'ko',
        symbol: '₩',
      )?.format(price);

  String formattedRegistererNumber(String value) =>
      value.substring(0, 3) +
      '-' +
      value.substring(3, 5) +
      '-' +
      value.substring(5);

  String formattedDate(DateTime dateTime) =>
      '${dateTime.year}년 ${dateTime.month}월 ${dateTime.day}일(${formattedWeekDay(dateTime.weekday)}) ${DateFormat.Hm('en-US').format(dateTime)}';

  String formattedWeekDay(int weekday) {
    switch (weekday) {
      case 1:
        return '월';
        break;
      case 2:
        return '화';
        break;
      case 3:
        return '수';
        break;
      case 4:
        return '목';
        break;
      case 5:
        return '금';
        break;
      case 6:
        return '토';
        break;
      case 7:
        return '일';
        break;
    }

    return '';
  }
}
