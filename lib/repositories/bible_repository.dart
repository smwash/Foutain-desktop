import 'package:foutain_desktop/models/bible_mdl.dart';

abstract class BaseBibleRepository {
  Future<void> insertSong(Bible song);
  Future<List<Bible>> getSongs();
  Future<List<Bible>> getSongsByCategory(String category);
  Future<List<Bible>> getSongsById(int songId, String category);
  Future<void> updateBible(Bible song);
}
