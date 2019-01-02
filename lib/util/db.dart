import 'package:sqflite/sqflite.dart';
import 'dart:async';
import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:mquote/model/quote.dart';

class Db {
  static final Db _dbHelper = Db._internal();

  String tblMQuotes = "mquotes";

  String colId = "id";
  String colQuote = "quote";
  String colAuthor = "author";
  String colFav = "fav";

  Db._internal();

  factory Db() {
    return _dbHelper;
  }

  static Database _db;

  Future<Database> get db async {
    if (_db == null) {
      _db = await initializeDb();
    }
    return _db;
  }

  Future<Database> initializeDb() async {
    Directory dir = await getApplicationDocumentsDirectory();
    String path = dir.path + "mquotes.db";
    var dbMQuotes = await openDatabase(path, version: 1, onCreate: _createDb);
    return dbMQuotes;
  }

  void _createDb(Database db, int newVersion) async {
    await db.execute(
        "CREATE TABLE $tblMQuotes($colId INTEGER PRIMARY KEY, $colQuote TEXT, " +
            "$colAuthor TEXT, $colFav INTEGER DEFAULT 0)");
    _initializeQuotes();
  }

  Future<int> insertQuote(Quote quote) async {
    Database db = await this.db;
    var result = await db.insert(tblMQuotes, quote.toMap());
    return result;
  }

  Future<List> getQuotes() async {
    Database db = await this.db;
    var result = await db.rawQuery("SELECT * FROM $tblMQuotes");
    return result;
  }

  Future<List> getFavQuotes() async {
    Database db = await this.db;
    var result =
        await db.rawQuery("SELECT * FROM $tblMQuotes WHERE $colFav = 1");
    return result;
  }

  Future<int> getCount() async {
    Database db = await this.db;
    var result = Sqflite.firstIntValue(
        await db.rawQuery("SELECT COUNT(1) FROM $tblMQuotes"));
    return result;
  }

  Future<int> updateQuote(Quote quote) async {
    Database db = await this.db;
    var result = await db.update(tblMQuotes, quote.toMap(),
        where: "$colId = ?", whereArgs: [quote.id]);
    return result;
  }

  Future<int> deleteQuote(int id) async {
    var db = await this.db;
    var result =
        await db.rawDelete("DELETE FROM $tblMQuotes Where $colId = $id");
    return result;
  }

  void _initializeQuotes() {
insertQuote(Quote("You have power over your mind — not outside events. Realize this, and you will find strength.", "Marcus Aurelius",0));
insertQuote(Quote("Divide each difficulty into as many parts as is feasible and necessary to resolve it.", "René Descartes",0));
insertQuote(Quote("Be weird. Your strangeness is your magic.", "Parker Lewis",0));
insertQuote(Quote("What you seek is seeking you.", "Rumi",0));
insertQuote(Quote("If you have everything under control, you’re not moving fast enough.", "Mario Andretti",0));
insertQuote(Quote("One small positive thought can change your whole day.", "Unknown",0));
insertQuote(Quote("To escape criticism: do nothing, say nothing, be nothing.", "Elbert Hubbard",0));
insertQuote(Quote("What makes you different or weird—that’s your strength.", "Meryl Streep",0));
insertQuote(Quote("Your greatest dreams are all on the other side of the wall of fear and caution.", "Unknown",0));
insertQuote(Quote("Know your limits but never stop trying to exceed them.", "Unknown",0));
insertQuote(Quote("Stop managing your time. Start managing your focus.", "Robin Sharma",0));
insertQuote(Quote("The difference between ordinary and extraordinary is that little extra.", "Jimmy Johnson",0));
insertQuote(Quote("Peace in the world is everybody's business, no matter where you live or what you do.", "Betty Williams",0));
insertQuote(Quote("Balance is not something you find, it's something you create.", "Jana Kingsford",0));
insertQuote(Quote("Perfection is not attainable, but if we chase perfection, we can catch excellence.", "Vince Lombardi",0));
insertQuote(Quote("Always do your best. What you plant now, you will harvest later.", "Og Mandino",0));
insertQuote(Quote("People overestimate what they can do in a single day. And underestimate what they can do in their whole lives.", "Unknown",0));
insertQuote(Quote("Everything is difficult until you know how to do it.", "Anonymous",0));
insertQuote(Quote("Adopt the pace of nature, her secret is patience.", "Ralph Emerson",0));
insertQuote(Quote("Believe in your infinite potential. Your only limitations are those you set upon yourself.", "Roy T. Bennett",0));
insertQuote(Quote("Let your hopes, not your hurts, shape your future.", "Robert H. Schuller",0));
insertQuote(Quote("Perseverance is not a long race; it is many short races one after another.", "Walter Elliott",0));
insertQuote(Quote("Patience and perseverance have a magical effect before which difficulties disappear and obstacles vanish.", "John Quincy Adams",0));
insertQuote(Quote("Yesterday, you said tomorrow.", "Nike",0));
insertQuote(Quote("Do what you feel in your heart to be right. You’ll be criticized anyway.", "Eleanor Roosevelt",0));
insertQuote(Quote("Be curious about everything. Never stop learning. Never stop growing.", "Caley Alyssa",0));
insertQuote(Quote("Our greatest weakness lies in giving up. The most certain way to succeed is always to try just one more time.", "Thomas A. Edison",0));
insertQuote(Quote("Acknowledging the good that you already have in your life is the foundation for all abundance.", "Eckhart Tolle",0));
insertQuote(Quote("If people aren't laughing at your dreams, your dreams aren't big enough.", "Grayson Marshall",0));
insertQuote(Quote("Be careful how you are talking to yourself because you are listening.", "Lisa M. Hayes",0));
insertQuote(Quote("There are two primary choices in life: to accept conditions as they exist, or accept the responsibility for changing them.", "Denis Waitley",0));
insertQuote(Quote("You cannot protect yourself from sadness without protecting yourself from happiness.", "Jonathan Safran Foer",0));
insertQuote(Quote("You cannot change the circumstances but you can change yourself. That is something you have charge of.", "Jim Rohn",0));
insertQuote(Quote("Today is the most important day of our lives.", "Thich Nhat Hanh",0));
insertQuote(Quote("Nothing is impossible, the word itself says 'I'm possible'!", "Audrey Hepburn",0));
insertQuote(Quote("Inside of every problem lies an opportunity.", "Robert Kiyosaki",0));
insertQuote(Quote("Do what you dream of doing even while you're afraid.", "Arianna Huffington",0));
insertQuote(Quote("Worrying does not take away tomorrow's troubles, it takes away today's peace.", "Unknown",0));
insertQuote(Quote("The universe reveals its secrets to those who dare to follow their hearts.", "Ralph Smart",0));
insertQuote(Quote("A positive attitude causes a chain reaction of positive thoughts, events, and outcomes.", "Wade Boggs",0));
insertQuote(Quote("Life is a series of building, testing, changing and iterating.", "Lauren Mosenthal",0));
insertQuote(Quote("May your choices reflect your hopes, not your fears.", "Nelson Mandela",0));
insertQuote(Quote("It does not matter how slowly you go as long as you do not stop.", "Confucius",0));
insertQuote(Quote("To accomplish great things, we must not only act, but also dream, not only plan, but also believe.", "Anatole France",0));
insertQuote(Quote("Don't let the success of others discourage you. Let it inspire you.", "Unknown",0));
insertQuote(Quote("Never give up. Never let things out of your control dictate who you are.", "Unknown",0));
insertQuote(Quote("Any person capable of angering you becomes your master. They can anger you only when you permit yourself to be disturbed by them.", "Epictetus",0));
insertQuote(Quote("Let us make our future now, and let us make our dreams tomorrow's reality.", "Malala Yousafzai",0));
insertQuote(Quote("If you listen to your fears, you will die never knowing what a great person you might have been.", "Robert Schuller",0));
insertQuote(Quote("Every day of our lives, we are on the verge of making those slight changes that would make all the difference.", "Mignon McLaughlin",0));
insertQuote(Quote("Never look back unless you are planning to go that way.", "Henry David Thoreau",0));
insertQuote(Quote("By doing what you love you inspire and awaken the hearts of others.", "Satsuki Shibuya",0));

  }
}
