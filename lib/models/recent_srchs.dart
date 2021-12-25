import 'dart:convert';

class RecentSrch {
  final int? id;
  final int results;
  final String query;

  RecentSrch({
    this.id,
    required this.results,
    required this.query,
  });

  RecentSrch copyWith({
    int? id,
    int? results,
    String? query,
  }) {
    return RecentSrch(
      id: id ?? this.id,
      results: results ?? this.results,
      query: query ?? this.query,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'results': results,
      'query': query,
    };
  }

  factory RecentSrch.fromMap(Map<String, dynamic> map) {
    return RecentSrch(
      id: map['id'],
      results: map['results'],
      query: map['query'],
    );
  }

  String toJson() => json.encode(toMap());

  factory RecentSrch.fromJson(String source) =>
      RecentSrch.fromMap(json.decode(source));

  @override
  String toString() => 'RecentSrch(id: $id, results: $results, query: $query)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is RecentSrch &&
        other.id == id &&
        other.results == results &&
        other.query == query;
  }

  @override
  int get hashCode => id.hashCode ^ results.hashCode ^ query.hashCode;
}
