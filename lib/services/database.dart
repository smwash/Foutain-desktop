import 'dart:async';
import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/services.dart';
import 'package:foutain_desktop/models/bible_mdl.dart';
import 'package:foutain_desktop/models/recent_srchs.dart';
import 'package:foutain_desktop/models/song_mdl.dart';
import 'package:foutain_desktop/utils/db_utils.dart';
import 'package:foutain_desktop/utils/enums.dart';
import 'package:foutain_desktop/utils/vrs_srch.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';

class LocalDB {
  final int dbversion = 1;
  final String bibleTbl = 'bible';
  final String songsTbl = 'songs';
  final String notesTable = 'notes';
  final String databaseNm = 'fountain.db';
  final String rcntSrchTable = 'rsntSearch';
  final String dictionaryTbl = 'dictionary';

  final dbHelper = DbHelper.intance;
  static Database? _database;

  Future<Database> get database async {
    //if (_database != null) return _database!;
    _database = await initiateDatabase();
    return _database!;
  }

  Future<Database> initiateDatabase() async {
    sqfliteFfiInit();
    String databasePath = await databaseFactoryFfi.getDatabasesPath();
    String path = join(databasePath, dbHelper.databaseNm);
    DatabaseFactory databaseFactory = databaseFactoryFfi;
    var exists = await databaseExists(path);
    //if (!exists) {
    try {
      await Directory(dirname(path)).create(recursive: true);
      ByteData data = await rootBundle.load('assets/fountain.db');
      List<int> bytes =
          data.buffer.asUint8List(data.offsetInBytes, data.lengthInBytes);
      await File(path).writeAsBytes(bytes, flush: true);
    } catch (e) {
      print(e);
    }
    //}
    return await databaseFactory.openDatabase(
      path,
      options:
          OpenDatabaseOptions(onCreate: _onCreate, version: dbHelper.dbversion),
    );
  }

  Future<void> _onCreate(Database db, int version) async {
    await db.execute(dbHelper.createRSearchesTable());

    db.execute(
        "ALTER TABLE ${dbHelper.songsTbl} ADD COLUMN isFavorite INTEGER;");
    db.execute("ALTER TABLE ${dbHelper.bibleTbl} ADD COLUMN notes TEXT;");
    db.execute("ALTER TABLE ${dbHelper.bibleTbl} ADD COLUMN hasNotes INTEGER;");
    db.execute(
        "ALTER TABLE ${dbHelper.bibleTbl} ADD COLUMN hlgtColor INTEGER;");
    db.execute(
        "ALTER TABLE ${dbHelper.bibleTbl} ADD COLUMN isBkMarked INTEGER;");
    db.execute(
        "ALTER TABLE ${dbHelper.bibleTbl} ADD COLUMN ntDtCreated INTEGER;");
    db.execute(
        "ALTER TABLE ${dbHelper.bibleTbl} ADD COLUMN hglghtDtCreated INTEGER;");
    db.execute(
        "ALTER TABLE ${dbHelper.bibleTbl} ADD COLUMN bkmkDtCreated INTEGER;");
    db.execute(
        "ALTER TABLE ${dbHelper.bibleTbl} ADD COLUMN isHighlighted INTEGER;");
  }

  Future<List<Song>> getSongsByVrs(int songId, String cat) async {
    Database db = await database;
    List<Map<String, dynamic>> result = await db.query(
      dbHelper.songsTbl,
      where: 'songId = ? and category = ?',
      groupBy: 'vrsNumber',
      whereArgs: [songId, cat],
    );
    List<Song> songs = result.map((e) => Song.fromMap(e)).toList();
    return songs;
  }

  //BIBILE
  Future<List<Bible>> getOldTest(int st, ed) async {
    Database db = await database;
    List<Map<String, dynamic>> result = await db.query(
      dbHelper.bibleTbl,
      where: 'bkNumber between $st and $ed',
      groupBy: 'bkNumber',
    );
    List<Bible> books = result.map((e) => Bible.fromMap(e)).toList();
    return books;
  }

  Future<List<Bible>> getAllBks() async {
    Database db = await database;
    List<Map<String, dynamic>> result =
        await db.query(dbHelper.bibleTbl, groupBy: 'bkNumber');
    List<Bible> books = result.map((e) => Bible.fromMap(e)).toList();
    return books;
  }

  Future<List<Bible>> getBkChapters(int bk) async {
    Database db = await database;
    List<Map<String, dynamic>> result = await db.query(dbHelper.bibleTbl,
        where: 'bkNumber = $bk', groupBy: 'chapter');
    List<Bible> songs = result.map((e) => Bible.fromMap(e)).toList();
    return songs;
  }

  Future<List<Bible>> getBookChapters(int bk) async {
    Database db = await database;
    List<Map<String, dynamic>> result =
        await db.query(dbHelper.bibleTbl, where: 'bkNumber = $bk');
    List<Bible> songs = result.map((e) => Bible.fromMap(e)).toList();
    return songs;
  }

  Future<Bible> getBbleFrmDictionary(String bkName, int chap, vrs) async {
    Database db = await database;
    List<Map<String, dynamic>> result = await db.query(dbHelper.bibleTbl,
        where: 'bkName = ? and chapter = ? and verse = ?',
        whereArgs: [bkName, chap, vrs]);
    List<Bible> songs = result.map((e) => Bible.fromMap(e)).toList();
    return songs[0];
  }

  Future<List<Bible>> getChaptVrss(Bible b) async {
    Database db = await database;
    List<Map<String, dynamic>> result = await db.query(dbHelper.bibleTbl,
        where: 'bkNumber = ${b.bkNumber} and chapter = ${b.chapter}');
    List<Bible> chapters = result.map((e) => Bible.fromMap(e)).toList();
    return chapters;
  }

  Future<List<Bible>> getSearchtVrss(
      {required String t,
      String? book,
      BookSelector? bk,
      TestaSelector? tm}) async {
    Database db = await database;
    List<Bible> bks = [];

    if (bk == BookSelector.allBooks && tm == TestaSelector.bothOldNew) {
      List<Map<String, dynamic>> result = await db.query(dbHelper.bibleTbl);
      List<Bible> books = result.map((e) => Bible.fromMap(e)).toList();
      bks = verseSearcher(t, books);
    }
    if (bk == BookSelector.allBooks && tm == TestaSelector.newTest) {
      List<Map<String, dynamic>> result = await db.query(dbHelper.bibleTbl,
          where: 'bkNumber between 40 and 66');
      List<Bible> books = result.map((e) => Bible.fromMap(e)).toList();
      bks = verseSearcher(t, books);
    }
    if (bk == BookSelector.allBooks && tm == TestaSelector.oldTest) {
      List<Map<String, dynamic>> result =
          await db.query(dbHelper.bibleTbl, where: 'bkNumber between 1 and 39');
      List<Bible> books = result.map((e) => Bible.fromMap(e)).toList();
      bks = verseSearcher(t, books);
    }
    if (bk == BookSelector.single) {
      List<Map<String, dynamic>> result = await db
          .query(dbHelper.bibleTbl, where: 'bkName = ?', whereArgs: [book]);
      List<Bible> books = result.map((e) => Bible.fromMap(e)).toList();
      bks = verseSearcher(t, books);
    }
    return bks;
  }

  Future<List<Bible>> getBkMarkedBible() async {
    Database db = await database;
    List<Map<String, dynamic>> result =
        await db.query(dbHelper.bibleTbl, where: 'isBkMarked = 1');
    List<Bible> chapters = result.map((e) => Bible.fromMap(e)).toList();
    return chapters;
  }

  Future<List<Bible>> getBibleHighlights() async {
    Database db = await database;
    List<Map<String, dynamic>> result =
        await db.query(dbHelper.bibleTbl, where: 'isHighlighted = 1');
    List<Bible> chapters = result.map((e) => Bible.fromMap(e)).toList();
    return chapters;
  }

  Future<void> updateBible(Bible b) async {
    Database db = await database;
    await db.update(dbHelper.bibleTbl, b.toMap(),
        where: 'id = ?', whereArgs: [b.id]);
  }
}
