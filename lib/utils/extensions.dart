import 'package:foutain_desktop/models/bible_mdl.dart';
import 'package:foutain_desktop/models/song_mdl.dart';

extension Iterables<E> on Iterable<E> {
  Map<K, List<E>> groupBy<K>(K Function(E) keyFunction) => fold(
      <K, List<E>>{},
      (Map<K, List<E>> map, E element) =>
          map..putIfAbsent(keyFunction(element), () => <E>[]).add(element));
}

Map<int, List<Song>> songh(List<Song> songs) {
  // if (songs.first.hasChorus == 1) {
  //   final list = songs.groupBy((e) => e.vrsNumber).values.toList()[1];
  //   List.generate(songs.groupBy((e) => e.vrsNumber).values.length * 2, (index) {
  //     if (index.isEven) {
  //       songs.insertAll(index + 2, list);
  //     }
  //   });
  // }
  final sortedSongs = songs.groupBy((e) => e.vrsNumber);
  //print(sortedSongs.length);
  return sortedSongs;
}

Map<int, List<Bible>> groupBibleByBkNo(List<Bible> songs) {
  final sortedBible = songs.groupBy((e) => e.bkNumber);
  return sortedBible;
}
