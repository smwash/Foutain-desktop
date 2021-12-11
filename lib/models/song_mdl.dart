import 'dart:convert';

class Song {
  final int id;
  final int songId;
  final String verse;
  final String title;
  final int sngNumber;
  final int lnNumber;
  final int vrsNumber;
  final int hasChorus;
  final int? isFavorite;
  final String category;

  Song({
    required this.id,
    required this.songId,
    required this.verse,
    required this.title,
    required this.sngNumber,
    required this.lnNumber,
    required this.vrsNumber,
    required this.hasChorus,
    this.isFavorite,
    required this.category,
  });

  Song copyWith({
    int? id,
    int? songId,
    String? verse,
    String? title,
    int? sngNumber,
    int? lnNumber,
    int? vrsNumber,
    int? hasChorus,
    int? isFavorite,
    String? category,
  }) {
    return Song(
      id: id ?? this.id,
      songId: songId ?? this.songId,
      verse: verse ?? this.verse,
      title: title ?? this.title,
      sngNumber: sngNumber ?? this.sngNumber,
      lnNumber: lnNumber ?? this.lnNumber,
      vrsNumber: vrsNumber ?? this.vrsNumber,
      hasChorus: hasChorus ?? this.hasChorus,
      isFavorite: isFavorite ?? this.isFavorite,
      category: category ?? this.category,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'songId': songId,
      'verse': verse,
      'title': title,
      'sngNumber': sngNumber,
      'lnNumber': lnNumber,
      'vrsNumber': vrsNumber,
      'hasChorus': hasChorus,
      'isFavorite': isFavorite,
      'category': category,
    };
  }

  factory Song.fromMap(Map<String, dynamic> map) {
    return Song(
      id: map['id'],
      songId: map['songId'],
      verse: map['verse'],
      title: map['title'],
      sngNumber: map['sngNumber'],
      lnNumber: map['lnNumber'],
      vrsNumber: map['vrsNumber'],
      hasChorus: map['hasChorus'],
      isFavorite: map['isFavorite'] ?? 0,
      category: map['category'],
    );
  }

  String toJson() => json.encode(toMap());

  factory Song.fromJson(String source) => Song.fromMap(json.decode(source));

  @override
  String toString() {
    return 'Song(id: $id, songId: $songId, verse: $verse, title: $title, sngNumber: $sngNumber, isFavorite: $isFavorite, lnNumber: $lnNumber, vrsNumber: $vrsNumber, hasChorus: $hasChorus,  category: $category)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Song &&
        other.id == id &&
        other.songId == songId &&
        other.verse == verse &&
        other.title == title &&
        other.sngNumber == sngNumber &&
        other.lnNumber == lnNumber &&
        other.vrsNumber == vrsNumber &&
        other.hasChorus == hasChorus &&
        other.isFavorite == isFavorite &&
        other.category == category;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        songId.hashCode ^
        verse.hashCode ^
        title.hashCode ^
        sngNumber.hashCode ^
        lnNumber.hashCode ^
        vrsNumber.hashCode ^
        hasChorus.hashCode ^
        isFavorite.hashCode ^
        category.hashCode;
  }
}
