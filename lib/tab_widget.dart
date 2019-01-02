import 'package:flutter/material.dart';
import 'package:mquote/model/quote.dart';
import 'package:mquote/util/db.dart';

class TabWidget extends StatelessWidget {
  final Color color;
  final int isFavQuotes;

  TabWidget(this.color, this.isFavQuotes);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: color,
      child: Center(
        child: Text("Fav " + isFavQuotes.toString()),
      ),
    );
  }
}

// TabWidget(Colors.grey, 0),
// TabWidget(Colors.blueGrey, 1),
