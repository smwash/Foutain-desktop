import 'dart:convert';
import 'package:flutter/material.dart';

class Bible {
  final int id;
  final int verse;
  final String text;
  final int chapter;
  final int bkNumber;
  final String bkName;
  final int? hasNotes;
  final String? notes;
  final int? isBkMarked;
  final Color? hlgtColor;
  final int? isHighlighted;
  final DateTime? ntDtCreated;
  final DateTime? bkmkDtCreated;
  final DateTime? hglghtDtCreated;

  Bible({
    required this.id,
    required this.verse,
    required this.text,
    required this.chapter,
    required this.bkNumber,
    required this.bkName,
    required this.hasNotes,
    this.notes,
    this.isBkMarked,
    this.hlgtColor,
    this.isHighlighted,
    this.ntDtCreated,
    this.bkmkDtCreated,
    this.hglghtDtCreated,
  });

  Bible copyWith({
    int? id,
    int? verse,
    String? text,
    int? chapter,
    int? bkNumber,
    String? bkName,
    int? hasNotes,
    String? notes,
    int? isBkMarked,
    Color? hlgtColor,
    int? isHighlighted,
    DateTime? ntDtCreated,
    DateTime? bkmkDtCreated,
    DateTime? hglghtDtCreated,
  }) {
    return Bible(
      id: id ?? this.id,
      verse: verse ?? this.verse,
      text: text ?? this.text,
      chapter: chapter ?? this.chapter,
      bkNumber: bkNumber ?? this.bkNumber,
      bkName: bkName ?? this.bkName,
      hasNotes: hasNotes ?? this.hasNotes,
      notes: notes ?? this.notes,
      isBkMarked: isBkMarked ?? this.isBkMarked,
      hlgtColor: hlgtColor ?? this.hlgtColor,
      isHighlighted: isHighlighted ?? this.isHighlighted,
      ntDtCreated: ntDtCreated ?? this.ntDtCreated,
      bkmkDtCreated: bkmkDtCreated ?? this.bkmkDtCreated,
      hglghtDtCreated: hglghtDtCreated ?? this.hglghtDtCreated,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'verse': verse,
      'text': text,
      'chapter': chapter,
      'bkNumber': bkNumber,
      'bkName': bkName,
      'hasNotes': hasNotes,
      'notes': notes,
      'isBkMarked': isBkMarked,
      'hlgtColor': hlgtColor!.value,
      'isHighlighted': isHighlighted,
      'ntDtCreated': ntDtCreated!.millisecondsSinceEpoch,
      'bkmkDtCreated': bkmkDtCreated!.millisecondsSinceEpoch,
      'hglghtDtCreated': hglghtDtCreated!.millisecondsSinceEpoch
    };
  }

  factory Bible.fromMap(Map<String, dynamic> map) {
    return Bible(
      id: map['id'],
      verse: map['verse'],
      text: map['text'],
      chapter: map['chapter'],
      bkNumber: map['bkNumber'],
      bkName: map['bkName'],
      hasNotes: map['hasNotes'] != null ? map['hasNotes'] : 0,
      notes: map['notes'] ?? '',
      isBkMarked: map['isBkMarked'] != null ? map['isBkMarked'] : 0,
      hlgtColor: map['hlgtColor'] != null ? Color(map['hlgtColor']) : null,
      isHighlighted: map['isHighlighted'] != null ? map['isHighlighted'] : 0,
      ntDtCreated: map['ntDtCreated'] != null
          ? DateTime.fromMillisecondsSinceEpoch(map['ntDtCreated'])
          : null,
      bkmkDtCreated: map['bkmkDtCreated'] != null
          ? DateTime.fromMillisecondsSinceEpoch(map['bkmkDtCreated'])
          : null,
      hglghtDtCreated: map['hglghtDtCreated'] != null
          ? DateTime.fromMillisecondsSinceEpoch(map['hglghtDtCreated'])
          : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory Bible.fromJson(String source) => Bible.fromMap(json.decode(source));

  @override
  String toString() {
    return 'Bible(id: $id, verse: $verse, text: $text, chapter: $chapter, bkNumber: $bkNumber, bkName: $bkName, hasNotes: $hasNotes, notes: $notes, isBkMarked: $isBkMarked, hlgtColor: $hlgtColor, isHighlighted: $isHighlighted, ntDtCreated: $ntDtCreated, bkmkDtCreated: $bkmkDtCreated, hglghtDtCreated: $hglghtDtCreated)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Bible &&
        other.id == id &&
        other.verse == verse &&
        other.text == text &&
        other.chapter == chapter &&
        other.bkNumber == bkNumber &&
        other.bkName == bkName &&
        other.hasNotes == hasNotes &&
        other.notes == notes &&
        other.isBkMarked == isBkMarked &&
        other.hlgtColor == hlgtColor &&
        other.isHighlighted == isHighlighted &&
        other.ntDtCreated == ntDtCreated &&
        other.bkmkDtCreated == bkmkDtCreated &&
        other.hglghtDtCreated == hglghtDtCreated;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        verse.hashCode ^
        text.hashCode ^
        chapter.hashCode ^
        bkNumber.hashCode ^
        bkName.hashCode ^
        hasNotes.hashCode ^
        notes.hashCode ^
        isBkMarked.hashCode ^
        hlgtColor.hashCode ^
        isHighlighted.hashCode ^
        ntDtCreated.hashCode ^
        bkmkDtCreated.hashCode ^
        hglghtDtCreated.hashCode;
  }
}
