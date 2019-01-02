import 'package:flutter/material.dart';
import 'package:mquote/screens/screen_builder.dart';

import 'package:mquote/util/quote_util.dart';

class FavQuotes extends StatefulWidget {
  @override
  _FavQuotesState createState() => _FavQuotesState();
}

class _FavQuotesState extends State<FavQuotes> {
  var quoteUtil = new QuoteUtil();
  @override
  initState() {
    super.initState();
    // Add listeners to this class
    if (quoteUtil.favQuotes == null) {
      quoteUtil.favQuotes = quoteUtil.getFavData();
    }
  }

  @override
  Widget build(BuildContext context) {
    return ScreenBuilder(1);
  }
}
