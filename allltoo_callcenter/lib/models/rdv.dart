class Rdv {
  int id;
  Prospect prospect;
  String date;

  Rdv({this.id, this.prospect, this.date});

  Rdv.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    prospect = json['prospect'] != null
        ? new Prospect.fromJson(json['prospect'])
        : null;
    date = json['date'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    if (this.prospect != null) {
      data['prospect'] = this.prospect.toJson();
    }
    data['date'] = this.date;
    return data;
  }
}

class Prospect {
  int id;
  String nom;

  Prospect({this.id, this.nom});

  Prospect.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    nom = json['nom'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['nom'] = this.nom;
    return data;
  }
}
