import 'package:flutter/foundation.dart';

class RdvDetails {
  int id;
  Prospect prospect;
  String remarque;

  RdvDetails({this.id, this.prospect, this.remarque});

  RdvDetails.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    prospect = json['prospect'] != null
        ? new Prospect.fromJson(json['prospect'])
        : null;
    remarque = json['remarque'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    if (this.prospect != null) {
      data['prospect'] = this.prospect.toJson();
    }
    data['remarque'] = this.remarque;
    return data;
  }
}

class Prospect {
  int id;
  String nom;
  String adresse;
  String email;
  String telephone;
  String remarque;

  Prospect(
      {this.id,
        this.nom,
        this.adresse,
        this.email,
        this.telephone,
        this.remarque});

  Prospect.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    nom = json['nom'];
    adresse = json['adresse'];
    email = json['email'];
    telephone = json['telephone'];
    remarque = json['remarque'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['nom'] = this.nom;
    data['adresse'] = this.adresse;
    data['email'] = this.email;
    data['telephone'] = this.telephone;
    data['remarque'] = this.remarque;
    return data;
  }
}
