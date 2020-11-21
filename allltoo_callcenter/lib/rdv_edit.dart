import 'package:flutter/material.dart';
import 'models/rdv.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class RdvEdit extends StatefulWidget {
  final int rdvID;
  RdvEdit({this.rdvID});

  @override
  _RdvEditState createState() => _RdvEditState();
}

class _RdvEditState extends State<RdvEdit> {

  Future<Rdv> fetchRdvs() async {
    var url = 'http://10.0.2.2:8000/api/v1/' + widget.rdvID.toString() + '?format=json';
    var response = await http.get(url);
    Rdv rdv;
    if(response.statusCode == 200){
      var rdvJson = json.decode(response.body);
      rdv  = Rdv.fromJson(rdvJson);
      return rdv;
    }
  }
  Rdv rdv;
  TextEditingController _titleController = TextEditingController();
  TextEditingController _contentController = TextEditingController();

  @override
  void initState(){
    fetchRdvs().then((value){
      setState(() {
        rdv = value;
        _titleController.text = rdv.prospect.nom;
        _contentController.text = rdv.prospect.adresse;

      });
    });
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Edit rdv')),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          children: <Widget>[
            TextField(
              controller: _titleController,
              decoration: InputDecoration(
                  hintText: 'Note title'
              ),
            ),

            Container(height: 8),

            TextField(
              controller: _contentController,
              decoration: InputDecoration(
                  hintText: 'Note content'
              ),
            ),

            Container(height: 16),

            SizedBox(
              width: double.infinity,
              height: 35,
              child: RaisedButton(
                child: Text('Submit', style: TextStyle(color: Colors.white)),
                color: Theme.of(context).primaryColor,
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
