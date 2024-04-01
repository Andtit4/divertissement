import 'package:flutter/material.dart';

void notifyListeners() {
  if (_listener != null) {
    _listener!();
  }
}

VoidCallback? _listener;

void addListener(VoidCallback listener) {
  _listener = listener;
}

void removeListener() {
  _listener = null;
}
