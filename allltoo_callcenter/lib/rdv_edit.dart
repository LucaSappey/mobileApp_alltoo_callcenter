import 'package:allltoo_callcenter/models/rdvDetails.dart';
import 'package:flutter/material.dart';
import 'models/api_response.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'models/rdvManipulation.dart';

class RdvEdit extends StatefulWidget {
  final int rdvID;
  RdvEdit({this.rdvID});

  @override
  _RdvEditState createState() => _RdvEditState();
}

class _RdvEditState extends State<RdvEdit> {

  Future<RdvDetails> fetchRdv() async {
    var url = 'http://10.0.2.2:8000/api/v1/' + widget.rdvID.toString();
    var response = await http.get(url);
    RdvDetails rdv;
    if(response.statusCode == 200){
      var rdvJson = json.decode(response.body);
      rdv  = RdvDetails.fromJson(rdvJson);
    }
    return rdv;
  }

  bool get isEditing => widget.rdvID != null;
  var url = 'http://10.0.2.2:8000/api/v1/';
  Map<String, String> headers = {"Content-type": "application/json"};

  RdvDetails rdv;
  //TextEditingController _statutController = TextEditingController();
  TextEditingController _remarqueController = TextEditingController();


  Future<APIResponse<bool>> updateRdv(RdvManipulation rdv) async {
    return http.put(url + widget.rdvID.toString() + '/', headers: headers, body: jsonEncode(rdv.toJson())).then((data) {
      if (data.statusCode == 200) {
        return APIResponse<bool>(data: true);
      }
      return APIResponse<bool>(error: true, errorMessage: 'An error occured');
    })
        .catchError((_) => APIResponse<bool>(error: true, errorMessage: 'An error occured'));
  }


  @override
  void initState(){
    if(isEditing) {
      fetchRdv().then((value) {
        setState(() {
          rdv = value;
          _remarqueController.text = rdv.remarque;
        });
      });
    }
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
              controller: _remarqueController,
              decoration: InputDecoration(
                  hintText: 'Remarque'
              ),
            ),

            Container(height: 16),

            SizedBox(
              width: double.infinity,
              height: 35,
              child: RaisedButton(
                child: Text('Submit', style: TextStyle(color: Colors.white)),
                color: Theme.of(context).primaryColor,
                onPressed: () async {

                  final rdv = RdvManipulation(
                    id: widget.rdvID,
                    remarque: _remarqueController.text,
                  );

                  final result = await updateRdv(rdv);

                  final title = 'Envoyé';
                  final text = result.error ? (result.errorMessage ?? "Une erreur s'est produite") : 'Vos informations ont bien été enregistrées';

                  showDialog(
                      context: context,
                      builder: (_) => AlertDialog(
                        title: Text(title),
                        content: Text(text),
                        actions: <Widget>[
                          FlatButton(
                            child: Text('Ok'),
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                          )
                        ],
                      )
                  )
                      .then((data) {
                  if (result.data) {
                    Navigator.of(context).pop();
                    }
                  });
                },
                ),
            )
          ],
        ),
      ),
    );
  }
}
