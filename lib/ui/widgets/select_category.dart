import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:Eliverd/models/models.dart';

class SelectCategoryDialog extends StatefulWidget {
  final ValueChanged<Category> onCategoryChanged;

  const SelectCategoryDialog(
      {Key key, @required this.onCategoryChanged})
      : super(key: key);

  @override
  _SelectCategoryDialogState createState() =>
      _SelectCategoryDialogState();
}

class _SelectCategoryDialogState extends State<SelectCategoryDialog> {
  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;

    return Container(
      height: height * 0.45,
      padding: EdgeInsets.only(
        left: 16.0,
        right: 16.0,
        bottom: kBottomNavigationBarHeight,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              SizedBox(
                height: 8.0,
              ),
              Divider(
                indent: 140.0,
                endIndent: 140.0,
                height: 16.0,
                thickness: 4.0,
              ),
              SizedBox(
                height: 8.0,
              ),
              Text(
                '카테고리 선택',
                style: TextStyle(
                  fontWeight: FontWeight.w800,
                  fontSize: 26.0,
                ),
              ),
              Text(
                '등록할 상품의 카테고리를 선택하세요.',
                style: TextStyle(
                  fontWeight: FontWeight.w200,
                  fontSize: 16.0,
                ),
              ),
              SizedBox(
                height: 16.0,
              ),
              Container(
                height: height * 0.2,
                child: GridView.builder(
                  scrollDirection: Axis.horizontal,
                  padding: EdgeInsets.all(0.0),
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 4,
                    mainAxisSpacing: 4,
                    childAspectRatio: 0.5,
                  ),
                  itemBuilder: (context, index) {
                    return InkWell(
                      onTap: () {
                        widget.onCategoryChanged(Categories.listByViewPOV[index]);

                        Navigator.pop(context);
                      },
                      highlightColor: Colors.transparent,
                      child: Container(
                        width: height * 0.22,
                        height: height * 0.22,
                        decoration: BoxDecoration(
                          color: Categories.listByViewPOV[index].color,
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        child: Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                Categories.listByViewPOV[index].icon,
                                textAlign: TextAlign.left,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w600,
                                  fontSize: 32.0,
                                ),
                              ),
                              Text(
                                Categories.listByViewPOV[index].text,
                                textAlign: TextAlign.left,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w600,
                                  fontSize: 16.0,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                  itemCount: Categories.listByViewPOV.length,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
