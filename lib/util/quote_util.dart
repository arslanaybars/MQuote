import 'dart:math';

import 'package:mquote/model/quote.dart';
import 'package:mquote/util/db.dart';

class QuoteUtil {
  static final QuoteUtil _quoteUtil = new QuoteUtil._internal();
  factory QuoteUtil() {
    return _quoteUtil;
  }
  QuoteUtil._internal();

  Db dbHelper = Db();
  int quoteCount = 0;
  Quote currentQuote;
  List<Quote> quotes;
  List<Quote> favQuotes;

  // store past position for the current session
  List<int> pastPositions = new List<int>();

  List<Quote> getData() {
    List<Quote> quoteList = List<Quote>();
    final dbFuture = dbHelper.initializeDb();
    dbFuture.then((result) {
      final quoteFuture = dbHelper.getQuotes();
      quoteFuture.then((result) {
        quoteCount = result.length;
        for (int i = 0; i < quoteCount; i++) {
          quoteList.add(Quote.fromObject(result[i]));
        }
      });
    });
    return quoteList;
  }

  List<Quote> getFavData() {
    List<Quote> quoteList = List<Quote>();
    final dbFuture = dbHelper.initializeDb();
    dbFuture.then((result) {
      final quoteFuture = dbHelper.getFavQuotes();
      quoteFuture.then((result) {
        var count = result.length;
        for (int i = 0; i < count; i++) {
          quoteList.add(Quote.fromObject(result[i]));
        }
      });
    });
    return quoteList;
  }

  void fav(Quote currentQuote) {
    print(currentQuote.author + " " + currentQuote.quote);
    currentQuote.fav = 1;
    favQuotes.add(currentQuote);
    dbHelper.updateQuote(currentQuote);
  }

  void unFav(Quote currentQuote) {
    currentQuote.fav = 0;
    favQuotes.remove(currentQuote);
    dbHelper.updateQuote(currentQuote);
  }

}
