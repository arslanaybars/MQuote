import 'package:flutter/material.dart';
import 'app.dart';
import 'package:admob_flutter/admob_flutter.dart';

void main() {
  Admob.initialize('ca-app-pub-3940256099942544~3347511713');
  runApp(MQuoteApp());
}
