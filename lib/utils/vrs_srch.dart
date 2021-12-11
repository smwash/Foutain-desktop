
  import 'package:foutain_desktop/models/bible_mdl.dart';

    List<Bible> verseSearcher(String t, List<Bible> books) {
    List<Bible> bks = [];
    int qLength = t.split(' ').length;
    if (qLength > 1) {
      bks = chainedWhereClause(t, books);
    } else
      bks = books
          .where((e) => e.text.toLowerCase().contains(t.toLowerCase()))
          .toList();
    return bks;
  }

List<Bible> chainedWhereClause(String q, List<Bible> books) {
    List<Bible> bks = [];
    int l = q.split(' ').length;
    List<String> splitString = q.split(' ');
    if (l <= 2) {
      bks = books
          .where((e) =>
              e.text.toLowerCase().contains(splitString[0].toLowerCase()))
          .where((e) =>
              e.text.toLowerCase().contains(splitString[1].toLowerCase()))
          .toList();
    }
    if (l > 2 && l <= 3) {
      bks = books
          .where((e) =>
              e.text.toLowerCase().contains(splitString[0].toLowerCase()))
          .where((e) =>
              e.text.toLowerCase().contains(splitString[1].toLowerCase()))
          .where((e) =>
              e.text.toLowerCase().contains(splitString[2].toLowerCase()))
          .toList();
    }
    if (l > 3 && l <= 4) {
      bks = books
          .where((e) =>
              e.text.toLowerCase().contains(splitString[0].toLowerCase()))
          .where((e) =>
              e.text.toLowerCase().contains(splitString[1].toLowerCase()))
          .where((e) =>
              e.text.toLowerCase().contains(splitString[2].toLowerCase()))
          .where((e) =>
              e.text.toLowerCase().contains(splitString[3].toLowerCase()))
          .toList();
    }
    if (l > 4 && l <= 5) {
      bks = books
          .where((e) =>
              e.text.toLowerCase().contains(splitString[0].toLowerCase()))
          .where((e) =>
              e.text.toLowerCase().contains(splitString[1].toLowerCase()))
          .where((e) =>
              e.text.toLowerCase().contains(splitString[2].toLowerCase()))
          .where((e) =>
              e.text.toLowerCase().contains(splitString[3].toLowerCase()))
          .where((e) =>
              e.text.toLowerCase().contains(splitString[4].toLowerCase()))
          .toList();
    }
    if (l > 5 && l <= 6) {
      bks = books
          .where((e) =>
              e.text.toLowerCase().contains(splitString[0].toLowerCase()))
          .where((e) =>
              e.text.toLowerCase().contains(splitString[1].toLowerCase()))
          .where((e) =>
              e.text.toLowerCase().contains(splitString[2].toLowerCase()))
          .where((e) =>
              e.text.toLowerCase().contains(splitString[3].toLowerCase()))
          .where((e) =>
              e.text.toLowerCase().contains(splitString[4].toLowerCase()))
          .where((e) =>
              e.text.toLowerCase().contains(splitString[5].toLowerCase()))
          .toList();
    }
    if (l > 6 && l <= 7) {
      bks = books
          .where((e) =>
              e.text.toLowerCase().contains(splitString[0].toLowerCase()))
          .where((e) =>
              e.text.toLowerCase().contains(splitString[1].toLowerCase()))
          .where((e) =>
              e.text.toLowerCase().contains(splitString[2].toLowerCase()))
          .where((e) =>
              e.text.toLowerCase().contains(splitString[3].toLowerCase()))
          .where((e) =>
              e.text.toLowerCase().contains(splitString[4].toLowerCase()))
          .where((e) =>
              e.text.toLowerCase().contains(splitString[5].toLowerCase()))
          .where((e) =>
              e.text.toLowerCase().contains(splitString[6].toLowerCase()))
          .toList();
    }
    if (l > 7 && l <= 8) {
      bks = books
          .where((e) =>
              e.text.toLowerCase().contains(splitString[0].toLowerCase()))
          .where((e) =>
              e.text.toLowerCase().contains(splitString[1].toLowerCase()))
          .where((e) =>
              e.text.toLowerCase().contains(splitString[2].toLowerCase()))
          .where((e) =>
              e.text.toLowerCase().contains(splitString[3].toLowerCase()))
          .where((e) =>
              e.text.toLowerCase().contains(splitString[4].toLowerCase()))
          .where((e) =>
              e.text.toLowerCase().contains(splitString[5].toLowerCase()))
          .where((e) =>
              e.text.toLowerCase().contains(splitString[6].toLowerCase()))
          .where((e) =>
              e.text.toLowerCase().contains(splitString[7].toLowerCase()))
          .toList();
    }
    if (l > 8 && l <= 9) {
      bks = books
          .where((e) =>
              e.text.toLowerCase().contains(splitString[0].toLowerCase()))
          .where((e) =>
              e.text.toLowerCase().contains(splitString[1].toLowerCase()))
          .where((e) =>
              e.text.toLowerCase().contains(splitString[2].toLowerCase()))
          .where((e) =>
              e.text.toLowerCase().contains(splitString[3].toLowerCase()))
          .where((e) =>
              e.text.toLowerCase().contains(splitString[4].toLowerCase()))
          .where((e) =>
              e.text.toLowerCase().contains(splitString[5].toLowerCase()))
          .where((e) =>
              e.text.toLowerCase().contains(splitString[6].toLowerCase()))
          .where((e) =>
              e.text.toLowerCase().contains(splitString[7].toLowerCase()))
          .where((e) =>
              e.text.toLowerCase().contains(splitString[8].toLowerCase()))
          .toList();
    }
    if (l > 9 && l <= 10) {
      bks = books
          .where((e) =>
              e.text.toLowerCase().contains(splitString[0].toLowerCase()))
          .where((e) =>
              e.text.toLowerCase().contains(splitString[1].toLowerCase()))
          .where((e) =>
              e.text.toLowerCase().contains(splitString[2].toLowerCase()))
          .where((e) =>
              e.text.toLowerCase().contains(splitString[3].toLowerCase()))
          .where((e) =>
              e.text.toLowerCase().contains(splitString[4].toLowerCase()))
          .where((e) =>
              e.text.toLowerCase().contains(splitString[5].toLowerCase()))
          .where((e) =>
              e.text.toLowerCase().contains(splitString[6].toLowerCase()))
          .where((e) =>
              e.text.toLowerCase().contains(splitString[7].toLowerCase()))
          .where((e) =>
              e.text.toLowerCase().contains(splitString[8].toLowerCase()))
          .where((e) =>
              e.text.toLowerCase().contains(splitString[9].toLowerCase()))
          .toList();
    }
    if (l > 10 && l <= 11) {
      bks = books
          .where((e) =>
              e.text.toLowerCase().contains(splitString[0].toLowerCase()))
          .where((e) =>
              e.text.toLowerCase().contains(splitString[1].toLowerCase()))
          .where((e) =>
              e.text.toLowerCase().contains(splitString[2].toLowerCase()))
          .where((e) =>
              e.text.toLowerCase().contains(splitString[3].toLowerCase()))
          .where((e) =>
              e.text.toLowerCase().contains(splitString[4].toLowerCase()))
          .where((e) =>
              e.text.toLowerCase().contains(splitString[5].toLowerCase()))
          .where((e) =>
              e.text.toLowerCase().contains(splitString[6].toLowerCase()))
          .where((e) =>
              e.text.toLowerCase().contains(splitString[7].toLowerCase()))
          .where((e) =>
              e.text.toLowerCase().contains(splitString[8].toLowerCase()))
          .where((e) =>
              e.text.toLowerCase().contains(splitString[9].toLowerCase()))
          .where((e) =>
              e.text.toLowerCase().contains(splitString[10].toLowerCase()))
          .toList();
    }
    if (l > 11 && l <= 12) {
      bks = books
          .where((e) =>
              e.text.toLowerCase().contains(splitString[0].toLowerCase()))
          .where((e) =>
              e.text.toLowerCase().contains(splitString[1].toLowerCase()))
          .where((e) =>
              e.text.toLowerCase().contains(splitString[2].toLowerCase()))
          .where((e) =>
              e.text.toLowerCase().contains(splitString[3].toLowerCase()))
          .where((e) =>
              e.text.toLowerCase().contains(splitString[4].toLowerCase()))
          .where((e) =>
              e.text.toLowerCase().contains(splitString[5].toLowerCase()))
          .where((e) =>
              e.text.toLowerCase().contains(splitString[6].toLowerCase()))
          .where((e) =>
              e.text.toLowerCase().contains(splitString[7].toLowerCase()))
          .where((e) =>
              e.text.toLowerCase().contains(splitString[8].toLowerCase()))
          .where((e) =>
              e.text.toLowerCase().contains(splitString[9].toLowerCase()))
          .where((e) =>
              e.text.toLowerCase().contains(splitString[10].toLowerCase()))
          .where((e) =>
              e.text.toLowerCase().contains(splitString[11].toLowerCase()))
          .toList();
    }
    if (l > 12 && l <= 13) {
      bks = books
          .where((e) =>
              e.text.toLowerCase().contains(splitString[0].toLowerCase()))
          .where((e) =>
              e.text.toLowerCase().contains(splitString[1].toLowerCase()))
          .where((e) =>
              e.text.toLowerCase().contains(splitString[2].toLowerCase()))
          .where((e) =>
              e.text.toLowerCase().contains(splitString[3].toLowerCase()))
          .where((e) =>
              e.text.toLowerCase().contains(splitString[4].toLowerCase()))
          .where((e) =>
              e.text.toLowerCase().contains(splitString[5].toLowerCase()))
          .where((e) =>
              e.text.toLowerCase().contains(splitString[6].toLowerCase()))
          .where((e) =>
              e.text.toLowerCase().contains(splitString[7].toLowerCase()))
          .where((e) =>
              e.text.toLowerCase().contains(splitString[8].toLowerCase()))
          .where((e) =>
              e.text.toLowerCase().contains(splitString[9].toLowerCase()))
          .where((e) =>
              e.text.toLowerCase().contains(splitString[10].toLowerCase()))
          .where((e) =>
              e.text.toLowerCase().contains(splitString[11].toLowerCase()))
          .where((e) =>
              e.text.toLowerCase().contains(splitString[12].toLowerCase()))
          .toList();
    }
    if (l > 13 && l <= 14) {
      bks = books
          .where((e) =>
              e.text.toLowerCase().contains(splitString[0].toLowerCase()))
          .where((e) =>
              e.text.toLowerCase().contains(splitString[1].toLowerCase()))
          .where((e) =>
              e.text.toLowerCase().contains(splitString[2].toLowerCase()))
          .where((e) =>
              e.text.toLowerCase().contains(splitString[3].toLowerCase()))
          .where((e) =>
              e.text.toLowerCase().contains(splitString[4].toLowerCase()))
          .where((e) =>
              e.text.toLowerCase().contains(splitString[5].toLowerCase()))
          .where((e) =>
              e.text.toLowerCase().contains(splitString[6].toLowerCase()))
          .where((e) =>
              e.text.toLowerCase().contains(splitString[7].toLowerCase()))
          .where((e) =>
              e.text.toLowerCase().contains(splitString[8].toLowerCase()))
          .where((e) =>
              e.text.toLowerCase().contains(splitString[9].toLowerCase()))
          .where((e) =>
              e.text.toLowerCase().contains(splitString[10].toLowerCase()))
          .where((e) =>
              e.text.toLowerCase().contains(splitString[11].toLowerCase()))
          .where((e) =>
              e.text.toLowerCase().contains(splitString[12].toLowerCase()))
          .where((e) =>
              e.text.toLowerCase().contains(splitString[13].toLowerCase()))
          .toList();
    }
    if (l > 14 && l <= 15) {
      bks = books
          .where((e) =>
              e.text.toLowerCase().contains(splitString[0].toLowerCase()))
          .where((e) =>
              e.text.toLowerCase().contains(splitString[1].toLowerCase()))
          .where((e) =>
              e.text.toLowerCase().contains(splitString[2].toLowerCase()))
          .where((e) =>
              e.text.toLowerCase().contains(splitString[3].toLowerCase()))
          .where((e) =>
              e.text.toLowerCase().contains(splitString[4].toLowerCase()))
          .where((e) =>
              e.text.toLowerCase().contains(splitString[5].toLowerCase()))
          .where((e) =>
              e.text.toLowerCase().contains(splitString[6].toLowerCase()))
          .where((e) =>
              e.text.toLowerCase().contains(splitString[7].toLowerCase()))
          .where((e) =>
              e.text.toLowerCase().contains(splitString[8].toLowerCase()))
          .where((e) =>
              e.text.toLowerCase().contains(splitString[9].toLowerCase()))
          .where((e) =>
              e.text.toLowerCase().contains(splitString[10].toLowerCase()))
          .where((e) =>
              e.text.toLowerCase().contains(splitString[11].toLowerCase()))
          .where((e) =>
              e.text.toLowerCase().contains(splitString[12].toLowerCase()))
          .where((e) =>
              e.text.toLowerCase().contains(splitString[13].toLowerCase()))
          .where((e) =>
              e.text.toLowerCase().contains(splitString[14].toLowerCase()))
          .toList();
    }
    if (l > 15 && l <= 16) {
      bks = books
          .where((e) =>
              e.text.toLowerCase().contains(splitString[0].toLowerCase()))
          .where((e) =>
              e.text.toLowerCase().contains(splitString[1].toLowerCase()))
          .where((e) =>
              e.text.toLowerCase().contains(splitString[2].toLowerCase()))
          .where((e) =>
              e.text.toLowerCase().contains(splitString[3].toLowerCase()))
          .where((e) =>
              e.text.toLowerCase().contains(splitString[4].toLowerCase()))
          .where((e) =>
              e.text.toLowerCase().contains(splitString[5].toLowerCase()))
          .where((e) =>
              e.text.toLowerCase().contains(splitString[6].toLowerCase()))
          .where((e) =>
              e.text.toLowerCase().contains(splitString[7].toLowerCase()))
          .where((e) =>
              e.text.toLowerCase().contains(splitString[8].toLowerCase()))
          .where((e) =>
              e.text.toLowerCase().contains(splitString[9].toLowerCase()))
          .where((e) =>
              e.text.toLowerCase().contains(splitString[10].toLowerCase()))
          .where((e) =>
              e.text.toLowerCase().contains(splitString[11].toLowerCase()))
          .where((e) =>
              e.text.toLowerCase().contains(splitString[12].toLowerCase()))
          .where((e) =>
              e.text.toLowerCase().contains(splitString[13].toLowerCase()))
          .where((e) =>
              e.text.toLowerCase().contains(splitString[14].toLowerCase()))
          .where((e) =>
              e.text.toLowerCase().contains(splitString[15].toLowerCase()))
          .toList();
    }
    if (l > 16 && l <= 17) {
      bks = books
          .where((e) =>
              e.text.toLowerCase().contains(splitString[0].toLowerCase()))
          .where((e) =>
              e.text.toLowerCase().contains(splitString[1].toLowerCase()))
          .where((e) =>
              e.text.toLowerCase().contains(splitString[2].toLowerCase()))
          .where((e) =>
              e.text.toLowerCase().contains(splitString[3].toLowerCase()))
          .where((e) =>
              e.text.toLowerCase().contains(splitString[4].toLowerCase()))
          .where((e) =>
              e.text.toLowerCase().contains(splitString[5].toLowerCase()))
          .where((e) =>
              e.text.toLowerCase().contains(splitString[6].toLowerCase()))
          .where((e) =>
              e.text.toLowerCase().contains(splitString[7].toLowerCase()))
          .where((e) =>
              e.text.toLowerCase().contains(splitString[8].toLowerCase()))
          .where((e) =>
              e.text.toLowerCase().contains(splitString[9].toLowerCase()))
          .where((e) =>
              e.text.toLowerCase().contains(splitString[10].toLowerCase()))
          .where((e) =>
              e.text.toLowerCase().contains(splitString[11].toLowerCase()))
          .where((e) =>
              e.text.toLowerCase().contains(splitString[12].toLowerCase()))
          .where((e) =>
              e.text.toLowerCase().contains(splitString[13].toLowerCase()))
          .where((e) =>
              e.text.toLowerCase().contains(splitString[14].toLowerCase()))
          .where((e) =>
              e.text.toLowerCase().contains(splitString[15].toLowerCase()))
          .where((e) =>
              e.text.toLowerCase().contains(splitString[16].toLowerCase()))
          .toList();
    }
    if (l > 17 && l <= 18) {
      bks = books
          .where((e) =>
              e.text.toLowerCase().contains(splitString[0].toLowerCase()))
          .where((e) =>
              e.text.toLowerCase().contains(splitString[1].toLowerCase()))
          .where((e) =>
              e.text.toLowerCase().contains(splitString[2].toLowerCase()))
          .where((e) =>
              e.text.toLowerCase().contains(splitString[3].toLowerCase()))
          .where((e) =>
              e.text.toLowerCase().contains(splitString[4].toLowerCase()))
          .where((e) =>
              e.text.toLowerCase().contains(splitString[5].toLowerCase()))
          .where((e) =>
              e.text.toLowerCase().contains(splitString[6].toLowerCase()))
          .where((e) =>
              e.text.toLowerCase().contains(splitString[7].toLowerCase()))
          .where((e) =>
              e.text.toLowerCase().contains(splitString[8].toLowerCase()))
          .where((e) =>
              e.text.toLowerCase().contains(splitString[9].toLowerCase()))
          .where((e) =>
              e.text.toLowerCase().contains(splitString[10].toLowerCase()))
          .where((e) =>
              e.text.toLowerCase().contains(splitString[11].toLowerCase()))
          .where((e) =>
              e.text.toLowerCase().contains(splitString[12].toLowerCase()))
          .where((e) =>
              e.text.toLowerCase().contains(splitString[13].toLowerCase()))
          .where((e) =>
              e.text.toLowerCase().contains(splitString[14].toLowerCase()))
          .where((e) =>
              e.text.toLowerCase().contains(splitString[15].toLowerCase()))
          .where((e) =>
              e.text.toLowerCase().contains(splitString[16].toLowerCase()))
          .where((e) => e.text.toLowerCase().contains(splitString[17].toLowerCase()))
          .toList();
    }
    if (l > 18 && l <= 19) {
      bks = books
          .where((e) =>
              e.text.toLowerCase().contains(splitString[0].toLowerCase()))
          .where((e) =>
              e.text.toLowerCase().contains(splitString[1].toLowerCase()))
          .where((e) =>
              e.text.toLowerCase().contains(splitString[2].toLowerCase()))
          .where((e) =>
              e.text.toLowerCase().contains(splitString[3].toLowerCase()))
          .where((e) =>
              e.text.toLowerCase().contains(splitString[4].toLowerCase()))
          .where((e) =>
              e.text.toLowerCase().contains(splitString[5].toLowerCase()))
          .where((e) =>
              e.text.toLowerCase().contains(splitString[6].toLowerCase()))
          .where((e) =>
              e.text.toLowerCase().contains(splitString[7].toLowerCase()))
          .where((e) =>
              e.text.toLowerCase().contains(splitString[8].toLowerCase()))
          .where((e) =>
              e.text.toLowerCase().contains(splitString[9].toLowerCase()))
          .where((e) =>
              e.text.toLowerCase().contains(splitString[10].toLowerCase()))
          .where((e) =>
              e.text.toLowerCase().contains(splitString[11].toLowerCase()))
          .where((e) =>
              e.text.toLowerCase().contains(splitString[12].toLowerCase()))
          .where((e) =>
              e.text.toLowerCase().contains(splitString[13].toLowerCase()))
          .where((e) =>
              e.text.toLowerCase().contains(splitString[14].toLowerCase()))
          .where((e) =>
              e.text.toLowerCase().contains(splitString[15].toLowerCase()))
          .where((e) =>
              e.text.toLowerCase().contains(splitString[16].toLowerCase()))
          .where((e) => e.text.toLowerCase().contains(splitString[17].toLowerCase()))
          .where((e) => e.text.toLowerCase().contains(splitString[18].toLowerCase()))
          .toList();
    }
    if (l == 20) {
      bks = books
          .where((e) =>
              e.text.toLowerCase().contains(splitString[0].toLowerCase()))
          .where((e) =>
              e.text.toLowerCase().contains(splitString[1].toLowerCase()))
          .where((e) =>
              e.text.toLowerCase().contains(splitString[2].toLowerCase()))
          .where((e) =>
              e.text.toLowerCase().contains(splitString[3].toLowerCase()))
          .where((e) =>
              e.text.toLowerCase().contains(splitString[4].toLowerCase()))
          .where((e) =>
              e.text.toLowerCase().contains(splitString[5].toLowerCase()))
          .where((e) =>
              e.text.toLowerCase().contains(splitString[6].toLowerCase()))
          .where((e) =>
              e.text.toLowerCase().contains(splitString[7].toLowerCase()))
          .where((e) =>
              e.text.toLowerCase().contains(splitString[8].toLowerCase()))
          .where((e) =>
              e.text.toLowerCase().contains(splitString[9].toLowerCase()))
          .where((e) =>
              e.text.toLowerCase().contains(splitString[10].toLowerCase()))
          .where((e) =>
              e.text.toLowerCase().contains(splitString[11].toLowerCase()))
          .where((e) =>
              e.text.toLowerCase().contains(splitString[12].toLowerCase()))
          .where((e) =>
              e.text.toLowerCase().contains(splitString[13].toLowerCase()))
          .where((e) =>
              e.text.toLowerCase().contains(splitString[14].toLowerCase()))
          .where((e) =>
              e.text.toLowerCase().contains(splitString[15].toLowerCase()))
          .where((e) =>
              e.text.toLowerCase().contains(splitString[16].toLowerCase()))
          .where((e) => e.text.toLowerCase().contains(splitString[17].toLowerCase()))
          .where((e) => e.text.toLowerCase().contains(splitString[18].toLowerCase()))
          .where((e) => e.text.toLowerCase().contains(splitString[19].toLowerCase()))
          .toList();
    }
    if (l == 21) {
      bks = books
          .where((e) =>
              e.text.toLowerCase().contains(splitString[0].toLowerCase()))
          .where((e) =>
              e.text.toLowerCase().contains(splitString[1].toLowerCase()))
          .where((e) =>
              e.text.toLowerCase().contains(splitString[2].toLowerCase()))
          .where((e) =>
              e.text.toLowerCase().contains(splitString[3].toLowerCase()))
          .where((e) =>
              e.text.toLowerCase().contains(splitString[4].toLowerCase()))
          .where((e) =>
              e.text.toLowerCase().contains(splitString[5].toLowerCase()))
          .where((e) =>
              e.text.toLowerCase().contains(splitString[6].toLowerCase()))
          .where((e) =>
              e.text.toLowerCase().contains(splitString[7].toLowerCase()))
          .where((e) =>
              e.text.toLowerCase().contains(splitString[8].toLowerCase()))
          .where((e) =>
              e.text.toLowerCase().contains(splitString[9].toLowerCase()))
          .where((e) =>
              e.text.toLowerCase().contains(splitString[10].toLowerCase()))
          .where((e) =>
              e.text.toLowerCase().contains(splitString[11].toLowerCase()))
          .where((e) =>
              e.text.toLowerCase().contains(splitString[12].toLowerCase()))
          .where((e) =>
              e.text.toLowerCase().contains(splitString[13].toLowerCase()))
          .where((e) =>
              e.text.toLowerCase().contains(splitString[14].toLowerCase()))
          .where((e) =>
              e.text.toLowerCase().contains(splitString[15].toLowerCase()))
          .where((e) =>
              e.text.toLowerCase().contains(splitString[16].toLowerCase()))
          .where((e) => e.text.toLowerCase().contains(splitString[17].toLowerCase()))
          .where((e) => e.text.toLowerCase().contains(splitString[18].toLowerCase()))
          .where((e) => e.text.toLowerCase().contains(splitString[19].toLowerCase()))
          .where((e) => e.text.toLowerCase().contains(splitString[20].toLowerCase()))
          .toList();
    }
    if (l == 22) {
      bks = books
          .where((e) =>
              e.text.toLowerCase().contains(splitString[0].toLowerCase()))
          .where((e) =>
              e.text.toLowerCase().contains(splitString[1].toLowerCase()))
          .where((e) =>
              e.text.toLowerCase().contains(splitString[2].toLowerCase()))
          .where((e) =>
              e.text.toLowerCase().contains(splitString[3].toLowerCase()))
          .where((e) =>
              e.text.toLowerCase().contains(splitString[4].toLowerCase()))
          .where((e) =>
              e.text.toLowerCase().contains(splitString[5].toLowerCase()))
          .where((e) =>
              e.text.toLowerCase().contains(splitString[6].toLowerCase()))
          .where((e) =>
              e.text.toLowerCase().contains(splitString[7].toLowerCase()))
          .where((e) =>
              e.text.toLowerCase().contains(splitString[8].toLowerCase()))
          .where((e) =>
              e.text.toLowerCase().contains(splitString[9].toLowerCase()))
          .where((e) =>
              e.text.toLowerCase().contains(splitString[10].toLowerCase()))
          .where((e) =>
              e.text.toLowerCase().contains(splitString[11].toLowerCase()))
          .where((e) =>
              e.text.toLowerCase().contains(splitString[12].toLowerCase()))
          .where((e) =>
              e.text.toLowerCase().contains(splitString[13].toLowerCase()))
          .where((e) =>
              e.text.toLowerCase().contains(splitString[14].toLowerCase()))
          .where((e) =>
              e.text.toLowerCase().contains(splitString[15].toLowerCase()))
          .where((e) =>
              e.text.toLowerCase().contains(splitString[16].toLowerCase()))
          .where((e) => e.text.toLowerCase().contains(splitString[17].toLowerCase()))
          .where((e) => e.text.toLowerCase().contains(splitString[18].toLowerCase()))
          .where((e) => e.text.toLowerCase().contains(splitString[19].toLowerCase()))
          .where((e) => e.text.toLowerCase().contains(splitString[20].toLowerCase()))
          .where((e) => e.text.toLowerCase().contains(splitString[21].toLowerCase()))
          .toList();
    }
    if (l == 23) {
      bks = books
          .where((e) =>
              e.text.toLowerCase().contains(splitString[0].toLowerCase()))
          .where((e) =>
              e.text.toLowerCase().contains(splitString[1].toLowerCase()))
          .where((e) =>
              e.text.toLowerCase().contains(splitString[2].toLowerCase()))
          .where((e) =>
              e.text.toLowerCase().contains(splitString[3].toLowerCase()))
          .where((e) =>
              e.text.toLowerCase().contains(splitString[4].toLowerCase()))
          .where((e) =>
              e.text.toLowerCase().contains(splitString[5].toLowerCase()))
          .where((e) =>
              e.text.toLowerCase().contains(splitString[6].toLowerCase()))
          .where((e) =>
              e.text.toLowerCase().contains(splitString[7].toLowerCase()))
          .where((e) =>
              e.text.toLowerCase().contains(splitString[8].toLowerCase()))
          .where((e) =>
              e.text.toLowerCase().contains(splitString[9].toLowerCase()))
          .where((e) =>
              e.text.toLowerCase().contains(splitString[10].toLowerCase()))
          .where((e) =>
              e.text.toLowerCase().contains(splitString[11].toLowerCase()))
          .where((e) =>
              e.text.toLowerCase().contains(splitString[12].toLowerCase()))
          .where((e) =>
              e.text.toLowerCase().contains(splitString[13].toLowerCase()))
          .where((e) =>
              e.text.toLowerCase().contains(splitString[14].toLowerCase()))
          .where((e) =>
              e.text.toLowerCase().contains(splitString[15].toLowerCase()))
          .where((e) =>
              e.text.toLowerCase().contains(splitString[16].toLowerCase()))
          .where((e) => e.text.toLowerCase().contains(splitString[17].toLowerCase()))
          .where((e) => e.text.toLowerCase().contains(splitString[18].toLowerCase()))
          .where((e) => e.text.toLowerCase().contains(splitString[19].toLowerCase()))
          .where((e) => e.text.toLowerCase().contains(splitString[20].toLowerCase()))
          .where((e) => e.text.toLowerCase().contains(splitString[21].toLowerCase()))
          .where((e) => e.text.toLowerCase().contains(splitString[22].toLowerCase()))
          .toList();
    }
    if (l == 24) {
      bks = books
          .where((e) =>
              e.text.toLowerCase().contains(splitString[0].toLowerCase()))
          .where((e) =>
              e.text.toLowerCase().contains(splitString[1].toLowerCase()))
          .where((e) =>
              e.text.toLowerCase().contains(splitString[2].toLowerCase()))
          .where((e) =>
              e.text.toLowerCase().contains(splitString[3].toLowerCase()))
          .where((e) =>
              e.text.toLowerCase().contains(splitString[4].toLowerCase()))
          .where((e) =>
              e.text.toLowerCase().contains(splitString[5].toLowerCase()))
          .where((e) =>
              e.text.toLowerCase().contains(splitString[6].toLowerCase()))
          .where((e) =>
              e.text.toLowerCase().contains(splitString[7].toLowerCase()))
          .where((e) =>
              e.text.toLowerCase().contains(splitString[8].toLowerCase()))
          .where((e) =>
              e.text.toLowerCase().contains(splitString[9].toLowerCase()))
          .where((e) =>
              e.text.toLowerCase().contains(splitString[10].toLowerCase()))
          .where((e) =>
              e.text.toLowerCase().contains(splitString[11].toLowerCase()))
          .where((e) =>
              e.text.toLowerCase().contains(splitString[12].toLowerCase()))
          .where((e) =>
              e.text.toLowerCase().contains(splitString[13].toLowerCase()))
          .where((e) =>
              e.text.toLowerCase().contains(splitString[14].toLowerCase()))
          .where((e) =>
              e.text.toLowerCase().contains(splitString[15].toLowerCase()))
          .where((e) =>
              e.text.toLowerCase().contains(splitString[16].toLowerCase()))
          .where((e) => e.text.toLowerCase().contains(splitString[17].toLowerCase()))
          .where((e) => e.text.toLowerCase().contains(splitString[18].toLowerCase()))
          .where((e) => e.text.toLowerCase().contains(splitString[19].toLowerCase()))
          .where((e) => e.text.toLowerCase().contains(splitString[20].toLowerCase()))
          .where((e) => e.text.toLowerCase().contains(splitString[21].toLowerCase()))
          .where((e) => e.text.toLowerCase().contains(splitString[22].toLowerCase()))
          .where((e) => e.text.toLowerCase().contains(splitString[23].toLowerCase()))
          .toList();
    }
    if (l == 25) {
      bks = books
          .where((e) =>
              e.text.toLowerCase().contains(splitString[0].toLowerCase()))
          .where((e) =>
              e.text.toLowerCase().contains(splitString[1].toLowerCase()))
          .where((e) =>
              e.text.toLowerCase().contains(splitString[2].toLowerCase()))
          .where((e) =>
              e.text.toLowerCase().contains(splitString[3].toLowerCase()))
          .where((e) =>
              e.text.toLowerCase().contains(splitString[4].toLowerCase()))
          .where((e) =>
              e.text.toLowerCase().contains(splitString[5].toLowerCase()))
          .where((e) =>
              e.text.toLowerCase().contains(splitString[6].toLowerCase()))
          .where((e) =>
              e.text.toLowerCase().contains(splitString[7].toLowerCase()))
          .where((e) =>
              e.text.toLowerCase().contains(splitString[8].toLowerCase()))
          .where((e) =>
              e.text.toLowerCase().contains(splitString[9].toLowerCase()))
          .where((e) =>
              e.text.toLowerCase().contains(splitString[10].toLowerCase()))
          .where((e) =>
              e.text.toLowerCase().contains(splitString[11].toLowerCase()))
          .where((e) =>
              e.text.toLowerCase().contains(splitString[12].toLowerCase()))
          .where((e) =>
              e.text.toLowerCase().contains(splitString[13].toLowerCase()))
          .where((e) =>
              e.text.toLowerCase().contains(splitString[14].toLowerCase()))
          .where((e) =>
              e.text.toLowerCase().contains(splitString[15].toLowerCase()))
          .where((e) =>
              e.text.toLowerCase().contains(splitString[16].toLowerCase()))
          .where((e) => e.text.toLowerCase().contains(splitString[17].toLowerCase()))
          .where((e) => e.text.toLowerCase().contains(splitString[18].toLowerCase()))
          .where((e) => e.text.toLowerCase().contains(splitString[19].toLowerCase()))
          .where((e) => e.text.toLowerCase().contains(splitString[20].toLowerCase()))
          .where((e) => e.text.toLowerCase().contains(splitString[21].toLowerCase()))
          .where((e) => e.text.toLowerCase().contains(splitString[22].toLowerCase()))
          .where((e) => e.text.toLowerCase().contains(splitString[23].toLowerCase()))
          .where((e) => e.text.toLowerCase().contains(splitString[24].toLowerCase()))
          .toList();
    }
    if (l == 26) {
      bks = books
          .where((e) =>
              e.text.toLowerCase().contains(splitString[0].toLowerCase()))
          .where((e) =>
              e.text.toLowerCase().contains(splitString[1].toLowerCase()))
          .where((e) =>
              e.text.toLowerCase().contains(splitString[2].toLowerCase()))
          .where((e) =>
              e.text.toLowerCase().contains(splitString[3].toLowerCase()))
          .where((e) =>
              e.text.toLowerCase().contains(splitString[4].toLowerCase()))
          .where((e) =>
              e.text.toLowerCase().contains(splitString[5].toLowerCase()))
          .where((e) =>
              e.text.toLowerCase().contains(splitString[6].toLowerCase()))
          .where((e) =>
              e.text.toLowerCase().contains(splitString[7].toLowerCase()))
          .where((e) =>
              e.text.toLowerCase().contains(splitString[8].toLowerCase()))
          .where((e) =>
              e.text.toLowerCase().contains(splitString[9].toLowerCase()))
          .where((e) =>
              e.text.toLowerCase().contains(splitString[10].toLowerCase()))
          .where((e) =>
              e.text.toLowerCase().contains(splitString[11].toLowerCase()))
          .where((e) =>
              e.text.toLowerCase().contains(splitString[12].toLowerCase()))
          .where((e) =>
              e.text.toLowerCase().contains(splitString[13].toLowerCase()))
          .where((e) =>
              e.text.toLowerCase().contains(splitString[14].toLowerCase()))
          .where((e) =>
              e.text.toLowerCase().contains(splitString[15].toLowerCase()))
          .where((e) =>
              e.text.toLowerCase().contains(splitString[16].toLowerCase()))
          .where((e) => e.text.toLowerCase().contains(splitString[17].toLowerCase()))
          .where((e) => e.text.toLowerCase().contains(splitString[18].toLowerCase()))
          .where((e) => e.text.toLowerCase().contains(splitString[19].toLowerCase()))
          .where((e) => e.text.toLowerCase().contains(splitString[20].toLowerCase()))
          .where((e) => e.text.toLowerCase().contains(splitString[21].toLowerCase()))
          .where((e) => e.text.toLowerCase().contains(splitString[22].toLowerCase()))
          .where((e) => e.text.toLowerCase().contains(splitString[23].toLowerCase()))
          .where((e) => e.text.toLowerCase().contains(splitString[24].toLowerCase()))
          .where((e) => e.text.toLowerCase().contains(splitString[25].toLowerCase()))
          .toList();
    }
    if (l == 27) {
      bks = books
          .where((e) =>
              e.text.toLowerCase().contains(splitString[0].toLowerCase()))
          .where((e) =>
              e.text.toLowerCase().contains(splitString[1].toLowerCase()))
          .where((e) =>
              e.text.toLowerCase().contains(splitString[2].toLowerCase()))
          .where((e) =>
              e.text.toLowerCase().contains(splitString[3].toLowerCase()))
          .where((e) =>
              e.text.toLowerCase().contains(splitString[4].toLowerCase()))
          .where((e) =>
              e.text.toLowerCase().contains(splitString[5].toLowerCase()))
          .where((e) =>
              e.text.toLowerCase().contains(splitString[6].toLowerCase()))
          .where((e) =>
              e.text.toLowerCase().contains(splitString[7].toLowerCase()))
          .where((e) =>
              e.text.toLowerCase().contains(splitString[8].toLowerCase()))
          .where((e) =>
              e.text.toLowerCase().contains(splitString[9].toLowerCase()))
          .where((e) =>
              e.text.toLowerCase().contains(splitString[10].toLowerCase()))
          .where((e) =>
              e.text.toLowerCase().contains(splitString[11].toLowerCase()))
          .where((e) =>
              e.text.toLowerCase().contains(splitString[12].toLowerCase()))
          .where((e) =>
              e.text.toLowerCase().contains(splitString[13].toLowerCase()))
          .where((e) =>
              e.text.toLowerCase().contains(splitString[14].toLowerCase()))
          .where((e) =>
              e.text.toLowerCase().contains(splitString[15].toLowerCase()))
          .where((e) =>
              e.text.toLowerCase().contains(splitString[16].toLowerCase()))
          .where((e) => e.text.toLowerCase().contains(splitString[17].toLowerCase()))
          .where((e) => e.text.toLowerCase().contains(splitString[18].toLowerCase()))
          .where((e) => e.text.toLowerCase().contains(splitString[19].toLowerCase()))
          .where((e) => e.text.toLowerCase().contains(splitString[20].toLowerCase()))
          .where((e) => e.text.toLowerCase().contains(splitString[21].toLowerCase()))
          .where((e) => e.text.toLowerCase().contains(splitString[22].toLowerCase()))
          .where((e) => e.text.toLowerCase().contains(splitString[23].toLowerCase()))
          .where((e) => e.text.toLowerCase().contains(splitString[24].toLowerCase()))
          .where((e) => e.text.toLowerCase().contains(splitString[25].toLowerCase()))
          .where((e) => e.text.toLowerCase().contains(splitString[26].toLowerCase()))
          .toList();
    }
    if (l == 28) {
      bks = books
          .where((e) =>
              e.text.toLowerCase().contains(splitString[0].toLowerCase()))
          .where((e) =>
              e.text.toLowerCase().contains(splitString[1].toLowerCase()))
          .where((e) =>
              e.text.toLowerCase().contains(splitString[2].toLowerCase()))
          .where((e) =>
              e.text.toLowerCase().contains(splitString[3].toLowerCase()))
          .where((e) =>
              e.text.toLowerCase().contains(splitString[4].toLowerCase()))
          .where((e) =>
              e.text.toLowerCase().contains(splitString[5].toLowerCase()))
          .where((e) =>
              e.text.toLowerCase().contains(splitString[6].toLowerCase()))
          .where((e) =>
              e.text.toLowerCase().contains(splitString[7].toLowerCase()))
          .where((e) =>
              e.text.toLowerCase().contains(splitString[8].toLowerCase()))
          .where((e) =>
              e.text.toLowerCase().contains(splitString[9].toLowerCase()))
          .where((e) =>
              e.text.toLowerCase().contains(splitString[10].toLowerCase()))
          .where((e) =>
              e.text.toLowerCase().contains(splitString[11].toLowerCase()))
          .where((e) =>
              e.text.toLowerCase().contains(splitString[12].toLowerCase()))
          .where((e) =>
              e.text.toLowerCase().contains(splitString[13].toLowerCase()))
          .where((e) =>
              e.text.toLowerCase().contains(splitString[14].toLowerCase()))
          .where((e) =>
              e.text.toLowerCase().contains(splitString[15].toLowerCase()))
          .where((e) =>
              e.text.toLowerCase().contains(splitString[16].toLowerCase()))
          .where((e) => e.text.toLowerCase().contains(splitString[17].toLowerCase()))
          .where((e) => e.text.toLowerCase().contains(splitString[18].toLowerCase()))
          .where((e) => e.text.toLowerCase().contains(splitString[19].toLowerCase()))
          .where((e) => e.text.toLowerCase().contains(splitString[20].toLowerCase()))
          .where((e) => e.text.toLowerCase().contains(splitString[21].toLowerCase()))
          .where((e) => e.text.toLowerCase().contains(splitString[22].toLowerCase()))
          .where((e) => e.text.toLowerCase().contains(splitString[23].toLowerCase()))
          .where((e) => e.text.toLowerCase().contains(splitString[24].toLowerCase()))
          .where((e) => e.text.toLowerCase().contains(splitString[25].toLowerCase()))
          .where((e) => e.text.toLowerCase().contains(splitString[26].toLowerCase()))
          .where((e) => e.text.toLowerCase().contains(splitString[27].toLowerCase()))
          .toList();
    }
    if (l == 29) {
      bks = books
          .where((e) =>
              e.text.toLowerCase().contains(splitString[0].toLowerCase()))
          .where((e) =>
              e.text.toLowerCase().contains(splitString[1].toLowerCase()))
          .where((e) =>
              e.text.toLowerCase().contains(splitString[2].toLowerCase()))
          .where((e) =>
              e.text.toLowerCase().contains(splitString[3].toLowerCase()))
          .where((e) =>
              e.text.toLowerCase().contains(splitString[4].toLowerCase()))
          .where((e) =>
              e.text.toLowerCase().contains(splitString[5].toLowerCase()))
          .where((e) =>
              e.text.toLowerCase().contains(splitString[6].toLowerCase()))
          .where((e) =>
              e.text.toLowerCase().contains(splitString[7].toLowerCase()))
          .where((e) =>
              e.text.toLowerCase().contains(splitString[8].toLowerCase()))
          .where((e) =>
              e.text.toLowerCase().contains(splitString[9].toLowerCase()))
          .where((e) =>
              e.text.toLowerCase().contains(splitString[10].toLowerCase()))
          .where((e) =>
              e.text.toLowerCase().contains(splitString[11].toLowerCase()))
          .where((e) =>
              e.text.toLowerCase().contains(splitString[12].toLowerCase()))
          .where((e) =>
              e.text.toLowerCase().contains(splitString[13].toLowerCase()))
          .where((e) =>
              e.text.toLowerCase().contains(splitString[14].toLowerCase()))
          .where((e) =>
              e.text.toLowerCase().contains(splitString[15].toLowerCase()))
          .where((e) =>
              e.text.toLowerCase().contains(splitString[16].toLowerCase()))
          .where((e) => e.text.toLowerCase().contains(splitString[17].toLowerCase()))
          .where((e) => e.text.toLowerCase().contains(splitString[18].toLowerCase()))
          .where((e) => e.text.toLowerCase().contains(splitString[19].toLowerCase()))
          .where((e) => e.text.toLowerCase().contains(splitString[20].toLowerCase()))
          .where((e) => e.text.toLowerCase().contains(splitString[21].toLowerCase()))
          .where((e) => e.text.toLowerCase().contains(splitString[22].toLowerCase()))
          .where((e) => e.text.toLowerCase().contains(splitString[23].toLowerCase()))
          .where((e) => e.text.toLowerCase().contains(splitString[24].toLowerCase()))
          .where((e) => e.text.toLowerCase().contains(splitString[25].toLowerCase()))
          .where((e) => e.text.toLowerCase().contains(splitString[26].toLowerCase()))
          .where((e) => e.text.toLowerCase().contains(splitString[27].toLowerCase()))
          .where((e) => e.text.toLowerCase().contains(splitString[28].toLowerCase()))
          .toList();
    }
    if (l == 30) {
      bks = books
          .where((e) =>
              e.text.toLowerCase().contains(splitString[0].toLowerCase()))
          .where((e) =>
              e.text.toLowerCase().contains(splitString[1].toLowerCase()))
          .where((e) =>
              e.text.toLowerCase().contains(splitString[2].toLowerCase()))
          .where((e) =>
              e.text.toLowerCase().contains(splitString[3].toLowerCase()))
          .where((e) =>
              e.text.toLowerCase().contains(splitString[4].toLowerCase()))
          .where((e) =>
              e.text.toLowerCase().contains(splitString[5].toLowerCase()))
          .where((e) =>
              e.text.toLowerCase().contains(splitString[6].toLowerCase()))
          .where((e) =>
              e.text.toLowerCase().contains(splitString[7].toLowerCase()))
          .where((e) =>
              e.text.toLowerCase().contains(splitString[8].toLowerCase()))
          .where((e) =>
              e.text.toLowerCase().contains(splitString[9].toLowerCase()))
          .where((e) =>
              e.text.toLowerCase().contains(splitString[10].toLowerCase()))
          .where((e) =>
              e.text.toLowerCase().contains(splitString[11].toLowerCase()))
          .where((e) =>
              e.text.toLowerCase().contains(splitString[12].toLowerCase()))
          .where((e) =>
              e.text.toLowerCase().contains(splitString[13].toLowerCase()))
          .where((e) =>
              e.text.toLowerCase().contains(splitString[14].toLowerCase()))
          .where((e) =>
              e.text.toLowerCase().contains(splitString[15].toLowerCase()))
          .where((e) =>
              e.text.toLowerCase().contains(splitString[16].toLowerCase()))
          .where((e) => e.text.toLowerCase().contains(splitString[17].toLowerCase()))
          .where((e) => e.text.toLowerCase().contains(splitString[18].toLowerCase()))
          .where((e) => e.text.toLowerCase().contains(splitString[19].toLowerCase()))
          .where((e) => e.text.toLowerCase().contains(splitString[20].toLowerCase()))
          .where((e) => e.text.toLowerCase().contains(splitString[21].toLowerCase()))
          .where((e) => e.text.toLowerCase().contains(splitString[22].toLowerCase()))
          .where((e) => e.text.toLowerCase().contains(splitString[23].toLowerCase()))
          .where((e) => e.text.toLowerCase().contains(splitString[24].toLowerCase()))
          .where((e) => e.text.toLowerCase().contains(splitString[25].toLowerCase()))
          .where((e) => e.text.toLowerCase().contains(splitString[26].toLowerCase()))
          .where((e) => e.text.toLowerCase().contains(splitString[27].toLowerCase()))
          .where((e) => e.text.toLowerCase().contains(splitString[28].toLowerCase()))
          .where((e) => e.text.toLowerCase().contains(splitString[29].toLowerCase()))
          .toList();
    }
    return bks;
  }