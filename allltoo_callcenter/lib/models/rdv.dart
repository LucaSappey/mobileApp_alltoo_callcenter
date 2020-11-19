class Rdv{
  int id;
  String prospect;
  String date;

  Rdv(this.id, this.prospect, this.date);

  Rdv.fromJson(Map<String, dynamic> json){
    id = json['id'];
    prospect = json['nom_prospect'];
    date = json['date'];
  }
}