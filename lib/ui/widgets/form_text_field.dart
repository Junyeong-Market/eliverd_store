import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class FormTextField extends StatefulWidget {
  final regex;
  final maxLength;
  final isObscured;
  final controller;
  final helperText;
  final errorMessage;

  const FormTextField({
    Key key,
    @required this.controller,
    this.errorMessage,
    this.helperText,
    this.regex,
    this.isObscured,
    this.maxLength,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() => _FormTextFieldState();
}

class _FormTextFieldState extends State<FormTextField> {
  @override
  Widget build(BuildContext context) {
    return TextField(
      textInputAction: TextInputAction.done,
      inputFormatters: widget.regex is List ? widget.regex : [widget.regex],
      maxLength: widget.maxLength,
      maxLengthEnforced: widget.maxLength == null ? false : true,
      obscureText: widget.isObscured == null ? false : widget.isObscured,
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
