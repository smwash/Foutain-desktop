import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:foutain_desktop/models/recent_srchs.dart';
import 'package:foutain_desktop/providers/general_providers.dart';
import 'package:foutain_desktop/providers/rcnt_serch_providers.dart';
import 'package:sqflite/sqflite.dart';

abstract class BaseRecentSearchRepository {
  Future<void> addRcntSearch(RecentSrch s);
  Future<List<RecentSrch>> getRcntSrch();
  Future<void> deleteRcntSrch(RecentSrch s);
  Future<void> deleteAllRcntSearch();
  Future<List<RecentSrch>> getSrchByWord(String w);
}

class RecentSearchRepository implements BaseRecentSearchRepository {
  final Reader _read;
  const RecentSearchRepository(this._read);

  @override
  Future<int> addRcntSearch(RecentSrch s) async {
    try {
      final db = await _read(databaseProvider).database;
      String query = _read(rcntSearchProvider);
      List<RecentSrch> list = await getSrchByWord(query);
      List<RecentSrch> filterlist =
          list.where((e) => e.query == query).toList();
      for (var item in filterlist) {
        await deleteRcntSrch(item);
      }
      // int results = _read(searchWordFromBibleProvider)
      //     .maybeWhen(data: (data) => data.length, orElse: () => 0);
      // RecentSrch s =
      //     RecentSrch(query: _read(rcntSearchProvider), results: results);
      return await db.insert(_read(databaseProvider).rcntSrchTable, s.toMap(),
          conflictAlgorithm: ConflictAlgorithm.replace);
    } catch (e) {
      throw Exception(e);
    }
  }

  @override
  Future<List<RecentSrch>> getRcntSrch() async {
    try {
      final db = await _read(databaseProvider).database;
      List<Map<String, dynamic>> result = await db
          .query(_read(databaseProvider).rcntSrchTable, orderBy: 'id DESC');
      List<RecentSrch> list = result.map((e) => RecentSrch.fromMap(e)).toList();
      return list;
    } catch (e) {
      throw Exception(e);
    }
  }

  @override
  Future<void> deleteRcntSrch(RecentSrch s) async {
    try {
      final db = await _read(databaseProvider).database;
      await db.delete(_read(databaseProvider).rcntSrchTable,
          where: 'query = ?', whereArgs: [s.query]);
    } catch (e) {
      throw Exception(e);
    }
  }

  @override
  Future<void> deleteAllRcntSearch() async {
    try {
      final db = await _read(databaseProvider).database;
      List<RecentSrch> list = await getRcntSrch();
      for (var e in list) {
        await db.delete(_read(databaseProvider).rcntSrchTable,
            where: 'id = ${e.id}');
      }
    } catch (e) {
      throw Exception(e);
    }
  }

  @override
  Future<List<RecentSrch>> getSrchByWord(String w) async {
    try {
      final db = await _read(databaseProvider).database;
      List<Map<String, dynamic>> result = await db.query(
          _read(databaseProvider).rcntSrchTable,
          where: 'query = ?',
          whereArgs: [w]);
      List<RecentSrch> list = result.map((e) => RecentSrch.fromMap(e)).toList();
      return list;
    } catch (e) {
      throw Exception(e);
    }
  }
}
