import 'dart:math';

import 'package:flutter/material.dart';

import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';

import 'package:flutter_share_me/flutter_share_me.dart';
import 'package:mquote/model/quote.dart';
import 'package:mquote/util/quote_util.dart';

import 'package:admob_flutter/admob_flutter.dart';

class ScreenBuilder extends StatefulWidget {
  final int isFavorite;
  ScreenBuilder(this.isFavorite);
  @override
  _ScreenBuilderState createState() => _ScreenBuilderState(isFavorite);
}

class _ScreenBuilderState extends State<ScreenBuilder> {
  int isFavorite;
  _ScreenBuilderState(this.isFavorite);
  var quoteUtil = new QuoteUtil();

  int currentGeneratedIndex;
  Quote currentQuote;
  int quoteCount = 0;
  List<Quote> quotes;
  List<Quote> favQuotes;
  // store past position for the current session
  List<int> pastPositions = new List<int>();

  // AdmobInterstitial interstitialAd;

  @override
  Widget build(BuildContext context) {
    var qs = isFavorite == 1 ? quoteUtil.favQuotes : quoteUtil.quotes;
    if (currentGeneratedIndex == null) {
      Future.delayed(const Duration(seconds: 1), () {
        setState(() {
          // Here you can write your code for open new view
          if (qs != null && qs.length > 0) {
            currentGeneratedIndex = generateScreenData(qs);
            quoteCount = qs.length;
          }

          if (isFavorite == 1 && quoteUtil.favQuotes.length == 0) {
            currentGeneratedIndex = generateScreenData(qs, -1);
          }
        });
      });
      return Center(child: const CircularProgressIndicator());
    } else {
      if (currentQuote == null) {
        generateScreenData(qs);
        quoteCount = qs.length;
      }

      // interstitialAd = AdmobInterstitial(
      //   adUnitId: 'ca-app-pub-3940256099942544/1033173712',
      //   listener: (AdmobAdEvent event, Map<String, dynamic> args) {
      //     if (event == AdmobAdEvent.closed) interstitialAd.load();
      //   },
      // );
      // interstitialAd.load();

      return Center(
        child: GestureDetector(
          onTap: () {
            setState(() {
              if (currentGeneratedIndex == -1) {
                currentGeneratedIndex = generateScreenData(qs, -1);
              } else {
                currentGeneratedIndex = generateScreenData(qs);
              }
            });
          },
          onLongPress: () {
            if (pastPositions != null) {
              setState(() {
                if (pastPositions.length > 2) {
                  pastPositions.removeAt(pastPositions.length - 1);
                  currentQuote = qs[generateScreenData(
                      qs, pastPositions[pastPositions.length - 1])];
                }
              });
            }
          },
          child: Scaffold(
            floatingActionButton: Padding(
              padding: const EdgeInsets.all(20.0),
              child: FloatingActionButton(
                onPressed: () {
                  if (currentQuote.fav == 1) {
                    quoteUtil.unFav(currentQuote);
                  } else {
                    quoteUtil.fav(currentQuote);
                  }
                  setState(() {
                    currentGeneratedIndex =
                        generateScreenData(qs, currentGeneratedIndex);
                  });
                },
                child: Icon(
                  currentQuote.fav == 1
                      ? Icons.favorite
                      : Icons.favorite_border,
                ),
              ),
            ),
            body: Container(
              color: Colors.grey,
              alignment: Alignment.center,
              child: Padding(
                padding: EdgeInsets.only(right: 20.0, left: 20.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    // AdmobBanner(
                    //   adUnitId: 'ca-app-pub-3940256099942544/6300978111',
                    //   adSize: AdmobBannerSize.SMART_BANNER,
                    // ),
                    Padding(
                        padding: const EdgeInsets.only(
                            bottom: 8.0, left: 8.0, right: 8.0),
                        child: Row(
                          children: <Widget>[
                            Align(
                              alignment: Alignment.bottomLeft,
                              child: IconButton(
                                icon: Icon(
                                  Icons.share,
                                  color: Colors.black54,
                                ),
                                tooltip: 'Share quote',
                                onPressed: () async {
                                  var response = await FlutterShareMe()
                                      .shareToSystem(
                                          msg: "\"" +
                                              currentQuote.quote +
                                              "\"" +
                                              " " +
                                              currentQuote.author);
                                  if (response == 'success') {
                                    Scaffold.of(context).showSnackBar(SnackBar(
                                      content: Text(
                                        'Quote shared',
                                        style: TextStyle(color: Colors.white),
                                      ),
                                      duration: Duration(seconds: 2),
                                      backgroundColor: Colors.blueAccent,
                                    ));
                                  }
                                },
                              ),
                            ),
                            Align(
                              alignment: Alignment.bottomLeft,
                              child: IconButton(
                                icon: Icon(
                                  Icons.content_copy,
                                  color: Colors.black45,
                                ),
                                tooltip: 'Copy to clipboard',
                                onPressed: () {
                                  Clipboard.setData(ClipboardData(
                                          text: "\"" +
                                              currentQuote.quote +
                                              "\"" +
                                              " " +
                                              currentQuote.author))
                                      .then((data) {
                                    Scaffold.of(context).showSnackBar(SnackBar(
                                      content: Text(
                                        'Quote coppied to clipboard',
                                        style: TextStyle(color: Colors.white),
                                      ),
                                      duration: Duration(seconds: 2),
                                      backgroundColor: Colors.blueAccent,
                                    ));
                                  });
                                },
                              ),
                            ),
                          ],
                        )),
                    Text(
                      currentQuote.quote ?? "aa",
                      style: Theme.of(context).textTheme.body1,
                    ),
                    Align(
                      alignment: Alignment.centerRight,
                      child: Text(
                        currentQuote.author ?? "",
                        textAlign: TextAlign.left,
                        style: Theme.of(context).textTheme.body2,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      );
    }
  }

  int generateScreenData(List<Quote> quotes, [int currentGeneratedIndex]) {
    if (currentGeneratedIndex == -1) {
      currentQuote = Quote.onlyQuote("You dont have any favorite quote 😔");
    }

    if (currentGeneratedIndex != null) return currentGeneratedIndex;

    var generatedNumber = generateRandomNumber(quotes.length);
    print(generatedNumber);
    if (quotes != null || quotes.length > 0)
      currentQuote = quotes[generatedNumber];

    // var rng = new Random();
    // var position = rng.nextInt(101);
    // if (position % 10 == 0) {
    //   interstitialAd.show();
    // }

    return generatedNumber;
  }

  int generateRandomNumber([int qCount]) {
    var rng = new Random();
    var totalQuoteCount = quoteCount == 0 ? qCount : quoteCount;
    var position = rng.nextInt(totalQuoteCount);
    passPostionDetective();

    if (pastPositions.contains(position) && totalQuoteCount > 5) {
      generateRandomNumber();
    }

    pastPositions.add(position);
    return position;
  }

  void passPostionDetective() {
    if (pastPositions.length > 5) {
      for (int i = 0; i < pastPositions.length; i++) {
        pastPositions.removeAt(0);
        if (pastPositions.length < 5) {
          continue;
        }
      }
    }
  }

  @override
  void dispose() {
    // interstitialAd.dispose();
    super.dispose();
  }
}
