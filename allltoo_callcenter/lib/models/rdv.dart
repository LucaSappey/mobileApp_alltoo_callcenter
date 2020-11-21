class Rdv{
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

class Prospect{
  int id;
  String nom;
  String adresse;

  Prospect({this.id, this.nom, this.adresse});

  Prospect.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    nom = json['nom'];
    adresse = json['adresse'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['nom'] = this.nom;
    data['adresse'] = this.adresse;
    return data;
  }
}