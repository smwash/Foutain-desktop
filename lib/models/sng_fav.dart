import 'dart:convert';

class FavSong {
  final int id;
  final int songId;
  final String songCat;

  FavSong({
    required this.id,
    required this.songId,
    required this.songCat,
  });

  FavSong copyWith({
    int? id,
    int? songId,
    String? songCat,
  }) {
    return FavSong(
      id: id ?? this.id,
      songId: songId ?? this.songId,
      songCat: songCat ?? this.songCat,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'songId': songId,
      'songCat': songCat,
    };
  }

  factory FavSong.fromMap(Map<String, dynamic> map) {
    return FavSong(
      id: map['id'],
      songId: map['songId'],
      songCat: map['songCat'],
    );
  }

  String toJson() => json.encode(toMap());

  factory FavSong.fromJson(String source) =>
      FavSong.fromMap(json.decode(source));

  @override
  String toString() => 'FavSong(id: $id, songId: $songId, songCat: $songCat)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is FavSong &&
        other.id == id &&
        other.songId == songId &&
        other.songCat == songCat;
  }

  @override
  int get hashCode => id.hashCode ^ songId.hashCode ^ songCat.hashCode;
}
