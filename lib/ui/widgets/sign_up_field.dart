import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SignUpTextField extends StatefulWidget {
  final regex;
  final maxLength;
  final isObscured;
  final controller;
  final helperText;
  final errorMessage;

  const SignUpTextField(
      {Key key,
      @required this.regex,
      @required this.maxLength,
      @required this.isObscured,
      @required this.controller,
      @required this.helperText,
      @required this.errorMessage})
      : super(key: key);

  @override
  State<StatefulWidget> createState() => _SignUpTextFieldState();
}

class _SignUpTextFieldState extends State<SignUpTextField> {
  @override
  Widget build(BuildContext context) {
    return TextField(
      textInputAction: TextInputAction.done,
      inputFormatters: [widget.regex],
      maxLength: widget.maxLength,
      maxLengthEnforced: widget.maxLength == null ? false : true,
      obscureText: widget.isObscured,
      controller: widget.controller,
      decoration: InputDecoration(
        helperText: widget.helperText,
        contentPadding: EdgeInsets.all(2.0),
        isDense: true,
        errorText: widget.errorMessage,
        errorStyle: const TextStyle(
          color: Colors.red,
          fontWeight: FontWeight.bold,
        ),
      ),
      style: TextStyle(
        fontSize: 22.0,
        color: Colors.black54,
      ),
    );
  }
}
