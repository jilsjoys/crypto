import 'dart:async';
import 'dart:convert';

import 'package:crypto/screens/favourite.dart';
import 'package:favorite_button/favorite_button.dart';
import 'package:crypto/screens/details.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:http/http.dart' as http;

List<String> favt = <String>[];
List<String> imag = <String>[];

class Homescreen extends StatefulWidget {
  const Homescreen({Key? key}) : super(key: key);

  @override
  _HomescreenState createState() => _HomescreenState();
}

class _HomescreenState extends State<Homescreen> {
  Offset position = Offset(287.7, 115.0);
  List data = [];
  String url =
      "https://api.nomics.com/v1/currencies/ticker?key=501928ec5729180c41474630006dbf822fdeacc1&convert=INR&";

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
      body: SafeArea(
        child: Stack(children: [
          FutureBuilder(
            builder: (context, Snap) {
              if (Snap.connectionState == ConnectionState.none ||

                  // ignore: unnecessary_null_comparison
                  Snap.hasData == null) {
                //print('project snapshot data is: ${projectSnap.data}');
                return Center(
                    child: CircularProgressIndicator(
                  color: Colors.redAccent,
                ));
              } else
                return ListView.builder(
                    itemCount: data.length,
                    itemBuilder: (context, index) {
                      bool f = false;
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Card(
                          elevation: 7,
                          shadowColor: Colors.black,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15.0),
                          ),
                          color: Colors.white,
                          child: Padding(
                            padding: const EdgeInsets.all(4.0),
                            child: Column(
                              children: [
                                ListTile(
                                    onTap: () {
                                      print(data[index]["1d"]
                                          ["price_change_pct"]);
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) => Details(
                                                    name: data[index]["name"],
                                                    id: data[index]["id"],
                                                    symbol: data[index]
                                                        ["symbol"],
                                                    iconurl: data[index]
                                                        ["logo_url"],
                                                    marketcap: data[index]
                                                        ["market_cap"],
                                                    perc: data[index]["1d"][
                                                                "price_change_pct"] !=
                                                            null
                                                        ? data[index]["1d"]
                                                            ["price_change_pct"]
                                                        : "error",
                                                  )));
                                    },
                                    title: Padding(
                                      padding: const EdgeInsets.only(left: 8.0),
                                      child: Text(data[index]["id"]),
                                    ),
                                    subtitle: Padding(
                                      padding: const EdgeInsets.only(left: 8.0),
                                      child: Text(data[index]["name"]),
                                    ),
                                    trailing: StarButton(
                                      iconSize: 35,
                                      iconColor: Colors.redAccent,
                                      valueChanged: (_) {
                                        if (favt
                                            .contains(data[index]["name"])) {
                                          favt.remove(data[index]["name"]);
                                          imag.remove(data[index]["logo_url"]);
                                        } else {
                                          favt.add(data[index]["name"]);
                                          imag.add(data[index]["logo_url"]);
                                          print(favt[0]);
                                        }
                                      },
                                    ),
                                    leading: Container(
                                        child: data[index]["logo_url"]
                                                    .toString()
                                                    .substring(data[index]
                                                                ["logo_url"]
                                                            .toString()
                                                            .length -
                                                        2) ==
                                                "vg"
                                            ? CircleAvatar(
                                                backgroundColor:
                                                    Colors.transparent,
                                                child: new SvgPicture.network(
                                                  data[index]["logo_url"],
                                                  fit: BoxFit.scaleDown,
                                                ),
                                              )
                                            : CircleAvatar(
                                                backgroundColor:
                                                    Colors.transparent,
                                                child: new Image.network(
                                                  data[index]["logo_url"],
                                                  fit: BoxFit.scaleDown,
                                                ),
                                              ))),
                              ],
                            ),
                          ),
                        ),
                      );
                    });
            },
            future: fetch_data_from_api(),
          ),
          Positioned(
              left: position.dx,
              top: position.dy,
              child: Draggable(
                  feedback: Container(
                      child: FloatingActionButton(
                          child: Icon(Icons.star_border),
                          onPressed: () {
                            Navigator.push(context,
                                MaterialPageRoute(builder: (context) => Fav()));
                          })),
                  child: Container(
                    child: FloatingActionButton(
                        child: Icon(Icons.star),
                        onPressed: () {
                          Navigator.push(context,
                              MaterialPageRoute(builder: (context) => Fav()));
                        }),
                  ),
                  childWhenDragging: Container(),
                  onDragEnd: (details) {
                    setState(() {
                      position = details.offset;
                    });
                    print(position);
                    print(position.dx);
                    print(position.dy);
                  })),
        ]),
      ),
    );
  }
}
