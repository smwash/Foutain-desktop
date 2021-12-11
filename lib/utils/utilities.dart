import 'enums.dart';

String sngBkTitle(MenuSelector select) {
  //String sk;
  if (select == MenuSelector.hymn) return 'Hymn Book';
  if (select == MenuSelector.injili) return 'Nyimbo Za Injili';
  if (select == MenuSelector.tenzi) return 'Tenzi Za Rohoni';
  if (select == MenuSelector.kikuyu) return 'Nyimbo Cia Kiroho';
  if (select == MenuSelector.enyimba) return 'Enyimba Za Kristo';
  return 'Hymn Book';
  //return sk;
}

extension CapExtension on String {
  String get inCaps =>
      this.isNotEmpty ? '${this[0].toUpperCase()}${this.substring(1)}' : '';
  String get allInCaps => this.toUpperCase();
  String get capitalizeFirstofEach => this
      .replaceAll(RegExp(' +'), ' ')
      .split(" ")
      .map((str) => str.inCaps)
      .join(" ");
}

String stringToHtml(String text, String query) {
  query = query.toLowerCase().trim();
  int qLength = query.split(' ').length;
  if (qLength > 1) {
    List<String> splittedQuery = [];
    query.split(' ').forEach((e) => splittedQuery.add('(?=.*$e)'));
    final regex = RegExp(splittedQuery.join(''));
    if (regex.hasMatch(text.toLowerCase())) {
      splittedQuery.forEach((e) {
        e = e.replaceAll('(?=.*', '').replaceAll(')', '');
        text = text.replaceAll(e, '<b>$e</b>');
      });
    }
  } else {
    text = text.replaceAll(query, '<b>$query</b>');
  }
  return text;
}

List<String> songSelectors = [
  'Hymn Book',
  'Nyimbo Za Injili',
  'Enyimba Za Kristo',
  'Nyimbo Cia Kiroho',
  'Tenzi Za Rohoni',
];

class BibleNmExtract {
  final int bkNum;
  final String bkName;

  BibleNmExtract(
    this.bkNum,
    this.bkName,
  );
}

List<BibleNmExtract> bibleShrtNm = [
  BibleNmExtract(10, 'Genesis'),
  BibleNmExtract(20, 'Exodus'),
  BibleNmExtract(30, 'Leviticus'),
  BibleNmExtract(40, 'Numbers'),
  BibleNmExtract(50, 'Deuteronomy'),
  BibleNmExtract(60, 'Joshua'),
  BibleNmExtract(70, 'Judges'),
  BibleNmExtract(80, 'Ruth'),
  BibleNmExtract(90, '1 Samuel'),
  BibleNmExtract(100, '2 Samuel'),
  BibleNmExtract(110, '1 Kings'),
  BibleNmExtract(120, '2 Kings'),
  BibleNmExtract(130, '1 Chronicles'),
  BibleNmExtract(140, '2 Chronicles'),
  BibleNmExtract(150, 'Ezra'),
  BibleNmExtract(160, 'Nehemiah'),
  BibleNmExtract(190, 'Esther'),
  BibleNmExtract(220, 'Job'),
  BibleNmExtract(230, 'Psalms'),
  BibleNmExtract(240, 'Proverbs'),
  BibleNmExtract(250, 'Ecclesiastes'),
  BibleNmExtract(260, 'Song of Solomon'),
  BibleNmExtract(290, 'Isaiah'),
  BibleNmExtract(300, 'Jeremiah'),
  BibleNmExtract(310, 'Lamentations'),
  BibleNmExtract(330, 'Ezekiel'),
  BibleNmExtract(340, 'Daniel'),
  BibleNmExtract(350, 'Hosea'),
  BibleNmExtract(360, 'Joel'),
  BibleNmExtract(370, 'Amos'),
  BibleNmExtract(380, 'Obadiah'),
  BibleNmExtract(390, 'Jonah'),
  BibleNmExtract(400, 'Micah'),
  BibleNmExtract(410, 'Nahum'),
  BibleNmExtract(420, 'Habakkuk'),
  BibleNmExtract(430, 'Zephaniah'),
  BibleNmExtract(440, 'Haggai'),
  BibleNmExtract(450, 'Zechariah'),
  BibleNmExtract(460, 'Malachi'),
  BibleNmExtract(470, 'Matthew'),
  BibleNmExtract(480, 'Mark'),
  BibleNmExtract(490, 'Luke'),
  BibleNmExtract(500, 'John'),
  BibleNmExtract(510, 'Acts'),
  BibleNmExtract(520, 'Romans'),
  BibleNmExtract(530, '1 Corinthians'),
  BibleNmExtract(540, '2 Corinthians'),
  BibleNmExtract(550, 'Galatians'),
  BibleNmExtract(560, 'Ephesians'),
  BibleNmExtract(570, 'Philippians'),
  BibleNmExtract(580, 'Colossians'),
  BibleNmExtract(590, '1 Thessalonians'),
  BibleNmExtract(600, '2 Thessalonians'),
  BibleNmExtract(610, '1 Timothy'),
  BibleNmExtract(620, '2 Timothy'),
  BibleNmExtract(630, 'Titus'),
  BibleNmExtract(640, 'Philemon'),
  BibleNmExtract(650, 'Hebrews'),
  BibleNmExtract(660, 'James'),
  BibleNmExtract(670, '1 Peter'),
  BibleNmExtract(680, '2 Peter'),
  BibleNmExtract(690, '1 John'),
  BibleNmExtract(700, '2 John'),
  BibleNmExtract(710, '3 John'),
  BibleNmExtract(720, 'Jude'),
  BibleNmExtract(730, 'Revelation'),
];
