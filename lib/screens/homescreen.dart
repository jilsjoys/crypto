import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:http/http.dart' as http;

class Homescreen extends StatefulWidget {
  const Homescreen({Key? key}) : super(key: key);

  @override
  _HomescreenState createState() => _HomescreenState();
}

class _HomescreenState extends State<Homescreen> {
  List data = [];
  String url =
      "https://api.nomics.com/v1/currencies/ticker?key=501928ec5729180c41474630006dbf822fdeacc1&interval=1d,30d&convert=INR&per-page=100&page=1\"";

  @override
  void initState() {
    super.initState();

    // fetch_data_from_api();
  }

  Future<String> fetch_data_from_api() async {
    var jsondata = await http.get(Uri.parse(url));
    var fetchdata = jsonDecode(jsondata.body);
    setState(() {
      data = fetchdata;
      //  print(data);
    });
    return "Success";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
        builder: (context, Snap) {
          if (Snap.connectionState == ConnectionState.none ||

              // ignore: unnecessary_null_comparison
              Snap.hasData == null) {
            //print('project snapshot data is: ${projectSnap.data}');
            return Center(
                child: CircularProgressIndicator(
              color: Colors.redAccent,
            ));
          }
          return ListView.builder(
              itemCount: data.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Card(
                    elevation: 5,
                    shadowColor: Colors.blueAccent,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15.0),
                    ),
                    color: Colors.white,
                    child: Stack(children: [
                      ListTile(
                          onTap: () {
                            print(data[index]["logo_url"]);
                          },
                          title: Text(data[index]["id"]),
                          subtitle: Text(data[index]["name"]),
                          leading: Container(
                              child: data[index]["logo_url"]
                                          .toString()
                                          .substring(data[index]["logo_url"]
                                                  .toString()
                                                  .length -
                                              2) ==
                                      "vg"
                                  ? CircleAvatar(
                                      child: new SvgPicture.network(
                                        data[index]["logo_url"],
                                        fit: BoxFit.scaleDown,
                                      ),
                                    )
                                  : CircleAvatar(
                                      child: new Image.network(
                                        data[index]["logo_url"],
                                        fit: BoxFit.scaleDown,
                                      ),
                                    )))
                    ]),
                  ),
                );
              });
        },
        future: fetch_data_from_api(),
      ),
    );
  }
}
