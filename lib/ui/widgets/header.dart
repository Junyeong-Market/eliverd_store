import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:Eliverd/common/color.dart';

class Header extends PreferredSize {
  final Widget child;
  final double height;

  Header({@required this.child, this.height = kToolbarHeight});

  @override
  Size get preferredSize => Size.fromHeight(height);

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.only(
        bottomLeft: Radius.circular(50.0),
        bottomRight: Radius.circular(50.0),
      ),
      child: Container(
        child: child,
        height: preferredSize.height,
        alignment: Alignment.center,
        color: eliverdColor,
      ),
    );
  }
}