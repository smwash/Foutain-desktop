class DbHelper {
  DbHelper._init();
  static DbHelper intance = DbHelper._init();
  final int dbversion = 1;
  final String bibleTbl = 'bible';
  final String songsTbl = 'songs';
  final String notesTable = 'notes';
  final String databaseNm = 'fountain.db';
  final String rcntSrchTable = 'rsntSearch';
  final String dictionaryTbl = 'dictionary';

  //RECENT SEARCHES
  final String _rsid = 'id';
  final String _rsquery = 'query';
  final String _rsresults = 'results';

  String createRSearchesTable() {
    return '''
        CREATE TABLE $rcntSrchTable(
          $_rsid INTEGER PRIMARY KEY AUTOINCREMENT,
          $_rsquery TEXT,
           $_rsresults INTEGER
            )
      ''';
  }
}
