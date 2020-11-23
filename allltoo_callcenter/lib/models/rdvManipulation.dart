import 'package:flutter/foundation.dart';

class RdvManipulation {
  int id;
  String remarque;

  RdvManipulation(
      {
        this.id,
        @required this.remarque,
      }
      );

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'remarque': remarque,
    };
  }
}