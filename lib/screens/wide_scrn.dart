import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:foutain_desktop/providers/general_providers.dart';
import 'package:foutain_desktop/utils/enums.dart';
import 'package:foutain_desktop/widgets/bible/wide_scrn_verses.dart';
import 'package:foutain_desktop/widgets/songs/song_wide_scrn.dart';

class WideScreen extends ConsumerStatefulWidget {
  const WideScreen({Key? key}) : super(key: key);
  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _WideScreenState();
}

class _WideScreenState extends ConsumerState<WideScreen> {
  @override
  Widget build(BuildContext context) {
    final scrnstateProvider = ref.watch(widescrnstateProvider.state).state;
    if (scrnstateProvider == WideScrnState.song) {
      return const SongWideScreen();
    } else if (scrnstateProvider == WideScrnState.bible) {
      return const BibleVrsScreen();
    }
    return Container(color: Colors.white);
  }
}
