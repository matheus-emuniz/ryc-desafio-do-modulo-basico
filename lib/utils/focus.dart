import 'package:flutter/material.dart';

void clearFocus(context) {
  FocusScope.of(context).requestFocus(FocusNode());
}