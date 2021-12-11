import 'package:foutain_desktop/models/song_mdl.dart';

extension Iterables<E> on Iterable<E> {
  Map<K, List<E>> groupBy<K>(K Function(E) keyFunction) => fold(
      <K, List<E>>{},
      (Map<K, List<E>> map, E element) =>
          map..putIfAbsent(keyFunction(element), () => <E>[]).add(element));
}

Map<int, List<Song>> songh(List<Song> songs) {
  final releaseDateMap = songs.groupBy((e) => e.vrsNumber);
  return releaseDateMap;
}

Map<String, List<Song>> groupBySongCategory(List<Song> songs) {
  final sortedSongs = songs.groupBy((e) => e.category);
  return sortedSongs;
}
