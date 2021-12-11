import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:foutain_desktop/models/song_mdl.dart';
import 'package:foutain_desktop/providers/general_providers.dart';
import 'package:sqflite/sqflite.dart';

abstract class BaseSongsRepository {
  Future<void> insertSong(Song song);
  Future<List<Song>> getSongs();
  Future<List<Song>> getSongsByCategory(String category);
  Future<List<Song>> getSongsById(int songId, String category);
  Future<void> updateSong(Song song);
}

class SongsRepository implements BaseSongsRepository {
  final Reader _read;
  const SongsRepository(this._read);

  @override
  Future<List<Song>> getSongs() async {
    try {
      final db = await _read(databaseProvider).database;
      List<Map<String, dynamic>> result =
          await db.query(_read(databaseProvider).songsTbl);
      return result.map((e) => Song.fromMap(e)).toList();
    } catch (e) {
      throw Exception(e);
    }
  }

  @override
  Future<List<Song>> getSongsByCategory(String category) async {
    try {
      final db = await _read(databaseProvider).database;
      List<Map<String, dynamic>> result = await db.query(
          _read(databaseProvider).songsTbl,
          where: 'category = ?',
          whereArgs: [category]);
      List<Song> songs = result.map((e) => Song.fromMap(e)).toList();
      return songs;
    } catch (e) {
      throw Exception(e);
    }
  }

  @override
  Future<List<Song>> getSongsById(int songId, String category) async {
    try {
      final db = await _read(databaseProvider).database;
      List<Map<String, dynamic>> result = await db.query(
          _read(databaseProvider).songsTbl,
          where: 'songId = ? and category = ?',
          whereArgs: [songId, category]);
      return result.map((e) => Song.fromMap(e)).toList();
    } catch (e) {
      throw Exception(e);
    }
  }

  @override
  Future<void> insertSong(Song song) async {
    try {
      final db = await _read(databaseProvider).database;
      await db.insert(_read(databaseProvider).songsTbl, song.toMap(),
          conflictAlgorithm: ConflictAlgorithm.replace);
    } catch (e) {
      throw Exception(e);
    }
  }

  @override
  Future<void> updateSong(Song song) async {
    try {
      final db = await _read(databaseProvider).database;
      await db.update(
        _read(databaseProvider).songsTbl,
        song.toMap(),
        where: 'id = ${song.id}',
      );
    } catch (e) {
      throw Exception(e);
    }
  }
}
