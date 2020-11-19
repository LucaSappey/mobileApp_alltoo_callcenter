import 'dart:convert';
import 'package:flutter/material.dart';
import '../models/rdv.dart';
import 'package:http/http.dart' as http;

class RdvProvider with ChangeNotifier{

  RdvProvider(){
    this.fetchTasks();
  }
  List<Rdv> _rdvs = [];

  List<Rdv> get rdvs{
    return [..._rdvs];
  }

  fetchTasks() async{
    final url ='http://10.0.2.2:8000/api/v1/?format=json';
    final response = await http.get(url);
    if(response.statusCode == 200){
      var data = json.decode(response.body) as List;
      _rdvs = data.map<Rdv>((json) => Rdv.fromJson(json)).toList();
    }
  }
}
