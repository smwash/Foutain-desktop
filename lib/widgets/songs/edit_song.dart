import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:foutain_desktop/models/song_mdl.dart';
import 'package:foutain_desktop/providers/general_providers.dart';
import 'package:foutain_desktop/providers/song_providers.dart';
import 'package:foutain_desktop/utils/extensions.dart';

class EditSong extends ConsumerStatefulWidget {
  static void showDialog(BuildContext context) {
    showGeneralDialog(
      barrierLabel: 'Edit Song',
      barrierDismissible: true,
      transitionDuration: const Duration(milliseconds: 200),
      context: context,
      pageBuilder: (_, __, ___) {
        return Consumer(
          builder: (context, ref, child) {
            return const EditSong();
          },
        );
      },
      transitionBuilder: (_, anim, __, child) {
        return SlideTransition(
          position: Tween(
            begin: const Offset(0, 1),
            end: const Offset(0, 0),
          ).animate(anim),
          child: child,
        );
      },
    );
  }

  const EditSong({Key? key}) : super(key: key);

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _EditSongState();
}

class _EditSongState extends ConsumerState<EditSong> {
  final TextEditingController titleController = TextEditingController();
  final TextEditingController sngNumberController = TextEditingController();
  final TextEditingController verseController = TextEditingController();

  @override
  void initState() {
    super.initState();
    titleController.text = ref.read(songSetterProvider)!.title;
    sngNumberController.text =
        ref.read(songSetterProvider)!.sngNumber.toString();
    verseController.text = ref.read(songSetterProvider)!.verse;
    bjkb();
  }

  bjkb() async {
    final song = ref.read(songSetterProvider);
    final db = ref.read(songsRepositoryProvider);
    List<Song> songs = await db.getSongsById(song!.songId, song.category);
    List<Song> vrsNumbers = await ref
        .read(databaseProvider)
        .getSongsByVrs(song.songId, song.category);
    List<String> songShare = [];
    //songShare.add('${song.sngNumber}.  ${song.title}\n');
    vrsNumbers.forEach((el) {
      List<Song> vs1 = songs.where((e) => e.vrsNumber == el.vrsNumber).toList();
      songShare.add(song.hasChorus == 1 && el.vrsNumber == 2
          ? '\n[CHORUS]\n'
          : song.verse == 'CHORUS'
              ? '\n[CHORUS]\n'
              : '\n[VERSE ${el.vrsNumber}]\n');
      vs1.forEach((e) => songShare.add('${e.verse}\n'));
    });
    verseController.text = songShare.join(' ');
    //songShare.join(' ')
  }

  handleVerses() {
    List<Song> vrsNumbers = [];
    List<String> songStrings = [];
    final song = ref.read(songSetterProvider);
    final songs = ref.read(editSongProvider);
    List<Song> songlist = songs
        .where((e) => e.songId == song!.songId && e.category == song.category)
        .toList();
    for (var e in songlist) {
      vrsNumbers.add(e);
      //songStrings.add('${e.verse}\n');
    }
    final groupedList = songh(vrsNumbers).values;
    print(groupedList.length);
    for (var item in groupedList) {}
    for (var el in vrsNumbers) {
      List<Song> vs1 =
          vrsNumbers.where((e) => e.vrsNumber == el.vrsNumber).toList();
      for (var e in vs1) {
        songStrings.add('${e.verse}\n');
      }
      songStrings.add(song!.hasChorus == 1 && el.vrsNumber == 2
          ? '\t\n[CHORUS]\n'
          : song.verse == 'CHORUS'
              ? '\t\n[CHORUS]\n'
              : '\t\n[VERSE ${el.vrsNumber}]\n');
    }
    // verseController.text = songStrings.join(' ');
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      insetPadding: EdgeInsets.symmetric(
          horizontal: MediaQuery.of(context).size.width * 0.15,
          vertical: MediaQuery.of(context).size.height * 0.15),
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 10.h, horizontal: 15.w),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Edit Song',
                  style: TextStyle(fontWeight: FontWeight.w600),
                ),
                Row(
                  children: [
                    ElevatedButton(
                      style: ButtonStyle(
                        overlayColor: MaterialStateProperty.all(
                            Theme.of(context).primaryColor),
                        backgroundColor: MaterialStateProperty.all(
                            Theme.of(context).colorScheme.secondary),
                      ),
                      child: const Text('Update'),
                      onPressed: () {},
                    ),
                    SizedBox(width: 15.w),
                    ElevatedButton(
                        style: ButtonStyle(
                          overlayColor: MaterialStateProperty.all(
                              Theme.of(context).colorScheme.secondary),
                          backgroundColor: MaterialStateProperty.all(
                              Theme.of(context).primaryColor),
                        ),
                        onPressed: () => Navigator.pop(context),
                        child: const Text('Close')),
                  ],
                )
              ],
            ),
            const Divider(),
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 10.h),
                    Row(
                      children: [
                        Expanded(
                            flex: 2,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text('Title'),
                                TextField(controller: titleController),
                              ],
                            )),
                        SizedBox(width: 20.w),
                        Expanded(
                            child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Song Number'),
                            TextField(controller: sngNumberController),
                          ],
                        )),
                      ],
                    ),
                    SizedBox(height: 15.h),
                    Text('Verses'),
                    TextField(
                      controller: verseController,
                      minLines: 100,
                      maxLines: null,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
