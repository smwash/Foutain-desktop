import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:foutain_desktop/services/database.dart';
import 'package:foutain_desktop/utils/enums.dart';

final menuSelectorProvider =
    StateProvider<MenuSelector>((ref) => MenuSelector.hymn);

final searchQueryProvider = StateProvider<String>((ref) => 'query');

final widescrnstateProvider =
    StateProvider<WideScrnState>((ref) => WideScrnState.initial);

final databaseProvider = StateProvider<LocalDB>((ref) => LocalDB());

final favbkmarkProvider =
    StateProvider<FavMarkSelector>((ref) => FavMarkSelector.initial);
