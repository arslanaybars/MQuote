import 'package:flutter/material.dart';
import 'package:mquote/screens/screen_builder.dart';
import 'package:mquote/util/quote_util.dart';

class Quotes extends StatefulWidget {
  @override
  _QuotesState createState() => _QuotesState();
}

class _QuotesState extends State<Quotes> {
  var quoteUtil = QuoteUtil();
  @override
  initState() {
    super.initState();
    // Add listeners to this class
    if (quoteUtil.quotes == null) {
      quoteUtil.quotes = quoteUtil.getData();
    }
  }

  @override
  Widget build(BuildContext context) {
    return ScreenBuilder(0);
  }
}
