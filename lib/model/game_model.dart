// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:flutter/material.dart';

class GameModel {
  final int id;
  String text;
  Color color;
  bool enabled;

  GameModel({
    required this.id,
    this.text = '',
    this.color = Colors.white,
    this.enabled = true,
  });

  GameModel copyWith({
    int? id,
    String? text,
    Color? color,
    bool? enabled,
  }) {
    return GameModel(
      id: id ?? this.id,
      text: text ?? this.text,
      color: color ?? this.color,
      enabled: enabled ?? this.enabled,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'text': text,
      'color': color.value,
      'enabled': enabled,
    };
  }

  factory GameModel.fromMap(Map<String, dynamic> map) {
    return GameModel(
      id: map['id'] as int,
      text: map['text'] as String,
      color: Color(map['color'] as int),
      enabled: map['enabled'] as bool,
    );
  }

  String toJson() => json.encode(toMap());

  factory GameModel.fromJson(String source) =>
      GameModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'GameModel(id: $id, text: $text, color: $color, enabled: $enabled)';
  }

  @override
  bool operator ==(covariant GameModel other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.text == text &&
        other.color == color &&
        other.enabled == enabled;
  }

  @override
  int get hashCode {
    return id.hashCode ^ text.hashCode ^ color.hashCode ^ enabled.hashCode;
  }
}
