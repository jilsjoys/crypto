import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
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

    fetch_data_from_api();
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
      body: SafeArea(
          child: Stack(
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.max,
            children: [
              new SizedBox(
                height: 70,
              ),
              Expanded(
                child: ListView.builder(
                    itemCount: data.length,
                    itemBuilder: (context, index) {
                      return new Card(
                          color: Colors.white,
                          child: Stack(children: [
                            ListTile(
                              onTap: () {
                                print(data[index]["logo_url"]);
                              },
                              title: Text(data[index]["logo_url"]),
                              leading: Image.network(
                                data[index]["logo_url"],
                                fit: BoxFit.contain,
                                
                                
                              ),
                            ),
                          ]));
                    }),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.only(top: 15, right: 15, left: 15),
            child: Container(
              decoration: BoxDecoration(boxShadow: [
                BoxShadow(
                  color: Colors.grey,
                  blurRadius: 8.0,
                ),
              ], borderRadius: BorderRadius.circular(60), color: Colors.white),
              padding: EdgeInsets.all(20),
              child: Row(
                children: [Icon(Icons.menu), Spacer(), Icon(Icons.favorite)],
              ),
            ),
          ),
        ],
      )),
    );
  }
}
