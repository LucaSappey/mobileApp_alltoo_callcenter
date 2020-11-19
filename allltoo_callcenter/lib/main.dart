import 'package:allltoo_callcenter/api/api.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'models/rdv.dart';
import 'package:intl/intl.dart';


void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => RdvProvider(),
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        home: Home(),
      ),
    );
  }
}
class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

String Date_To_String(DateTime date_rdv){
  var formatter = DateFormat("dd/MM/yyyy");
  var formatted = formatter.format(date_rdv);
  return formatted;
}

DateTime date_today(){
  var now = new DateTime.now();
  var nowUtc = now.add(new Duration(hours: 1));
  return nowUtc;
}

class _HomeState extends State<Home> {

  List<Rdv> _rdvs = List<Rdv>();

  Future<List<Rdv>> fetchRdvs() async {
    var url = 'http://10.0.2.2:8000/api/v1/?format=json';
    var response = await http.get(url);
    var rdvs = List<Rdv>();
    if(response.statusCode == 200){
      var rdvsJson = json.decode(response.body);
      for(var rdvJson in rdvsJson){
        rdvs.add(Rdv.fromJson(rdvJson));
      }
      return rdvs;
    }
  }

  @override
  void initState(){
    fetchRdvs().then((value){
      setState(() {
        _rdvs.addAll(value);
      });
    });
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Center(
            child: Text("Mes rendez-vous")
        ),
      ),
      body: ListView.builder(
        itemBuilder: (context, index){

          var date_rdv = DateTime.parse(_rdvs[index].date);
          var string_date_rdv = Date_To_String(date_rdv);

          if(date_rdv.isAfter(date_today()) || _rdvs[index].id == 1393)
            return Card(
              child: Padding(
                padding: const EdgeInsets.only(top:32.0, bottom: 32, left: 16.0, right: 16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text("${_rdvs[index].prospect} $index",
                      style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                          color: Colors.grey.shade600
                      )),
                    Text("${string_date_rdv}",
                        style: TextStyle(
                            color: Colors.grey.shade600)
                    )
                  ]
                ),
              ),
            );
          else
            return Text("");
        },
        itemCount: _rdvs.length,
      ),
      );
  }
}
