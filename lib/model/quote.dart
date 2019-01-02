class Quote {
  int _id;
  String _quote;
  String _author;
  int _fav;

  Quote(this._quote, this._author, [this._fav]);

  Quote.withId(this._id, this._quote, this._author, [this._fav]);

  Quote.onlyQuote(this._quote);

  int get id => _id;
  String get quote => _quote;
  String get author => _author;
  int get fav => _fav;

  set quote(String q) {
    if (q.length < 1000) {
      _quote = q;
    }
  }

  set author(String a) {
    if (a.length < 255) {
      _author = a;
    }
  }

  set fav(int f) {
    if (f > 0) {
      _fav = 1;
    } else {
      _fav = 0;
    }
  }

  Map<String, dynamic> toMap() {
    var map = Map<String, dynamic>();
    map["quote"] = _quote;
    map["author"] = _author;
    map["fav"] = _fav;
    if (_id != null) {
      map["id"] = _id;
    }

    return map;
  }

  Quote.fromObject(dynamic o) {
    this._id = o["id"];
    this._quote = o["quote"];
    this._author = o["author"];
    this._fav = o["fav"];
  }
}
