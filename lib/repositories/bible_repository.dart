import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:foutain_desktop/models/bible_mdl.dart';
import 'package:foutain_desktop/providers/general_providers.dart';

abstract class BaseBibleRepository {
  Future<List<Bible>> getAllBooks();
  Future<List<Bible>> getBkChapters(int bk);
  Future<List<Bible>> getChapterVerses(Bible b);
  Future<void> updateBible(Bible song);
}

class BibleRepository implements BaseBibleRepository {
  final Reader _read;
  BibleRepository(this._read);

  @override
  Future<List<Bible>> getAllBooks() async {
    try {
      final db = await _read(databaseProvider).database;
      List<Map<String, dynamic>> result =
          await db.query(_read(databaseProvider).bibleTbl);
      List<Bible> books = result.map((e) => Bible.fromMap(e)).toList();
      return books;
    } catch (e) {
      throw Exception(e);
    }
  }

  @override
  Future<void> updateBible(Bible b) async {
    try {
      final db = await _read(databaseProvider).database;
      await db.update(
        _read(databaseProvider).bibleTbl,
        b.toMap(),
        where: 'id = ?',
        whereArgs: [b.id],
      );
    } catch (e) {
      throw Exception(e);
    }
  }

  @override
  Future<List<Bible>> getBkChapters(int bk) async {
    try {
      final db = await _read(databaseProvider).database;
      List<Map<String, dynamic>> result = await db.query(
          _read(databaseProvider).bibleTbl,
          where: 'bkNumber = $bk',
          groupBy: 'chapter');
      List<Bible> books = result.map((e) => Bible.fromMap(e)).toList();
      return books;
    } catch (e) {
      throw Exception(e);
    }
  }

  @override
  Future<List<Bible>> getChapterVerses(Bible b) async {
    try {
      List<Bible> books = await getAllBooks();
      return books
          .where((e) => e.bkNumber == b.bkNumber && e.chapter == b.chapter)
          .toList();
    } catch (e) {
      throw Exception(e);
    }
  }
}

abstract class BibleState {
  const BibleState();
}

class BibleInitial extends BibleState {
  const BibleInitial();
}

class BibleLoading extends BibleState {
  const BibleLoading();
}

class BibleLoaded extends BibleState {
  final Bible bible;
  const BibleLoaded(this.bible);

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;

    return o is BibleLoaded && o.bible == bible;
  }

  @override
  int get hashCode => bible.hashCode;
}

class BibleError extends BibleState {
  final String message;
  const BibleError(this.message);

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;

    return o is BibleError && o.message == message;
  }

  @override
  int get hashCode => message.hashCode;
}
