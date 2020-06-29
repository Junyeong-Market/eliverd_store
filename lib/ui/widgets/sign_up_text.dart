import 'package:flutter/cupertino.dart';

class SignUpText extends StatefulWidget {
  final TextEditingController controller;
  final String textWhenCompleted;
  final String textWhenNotCompleted;

  const SignUpText(
      {Key key,
      @required this.controller,
      @required this.textWhenCompleted,
      @required this.textWhenNotCompleted})
      : super(key: key);

  @override
  State<StatefulWidget> createState() => _SignUpTextState();
}

class _SignUpTextState extends State<SignUpText> {
  @override
  Widget build(BuildContext context) {
    return Text(
      widget.controller.text.length != 0
          ? widget.textWhenCompleted
          : widget.textWhenNotCompleted,
      style: TextStyle(
        fontWeight: FontWeight.w800,
        fontSize: 26.0,
      ),
    );
  }
}
