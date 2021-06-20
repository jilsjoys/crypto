import 'package:crypto/screens/homescreen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class Fav extends StatefulWidget {
  @override
  _FavState createState() => _FavState();
}

class _FavState extends State<Fav> {
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(
            "Favourites",
            style: TextStyle(color: Colors.black54),
          ),
          leading: IconButton(
            icon: Icon(Icons.keyboard_arrow_left),
            iconSize: 32,
            color: Colors.black54,
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          backgroundColor: Colors.white,
        ),
        body: ListView.builder(
            itemCount: favt.length,
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.only(left: 8.0, right: 8, top: 5),
                child: Card(
                    elevation: 7,
                    shadowColor: Colors.black,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15.0),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Row(
                        children: [
                          Container(
                              child: imag[index].toString().substring(
                                          imag[index].toString().length - 2) ==
                                      "vg"
                                  ? CircleAvatar(
                                      backgroundColor: Colors.transparent,
                                      child: new SvgPicture.network(
                                        imag[index],
                                        fit: BoxFit.scaleDown,
                                      ),
                                    )
                                  : CircleAvatar(
                                      backgroundColor: Colors.transparent,
                                      child: new Image.network(
                                        imag[index],
                                        fit: BoxFit.scaleDown,
                                      ),
                                    )),
                          SizedBox(
                            width: 20,
                          ),
                          Text(
                            favt[index],
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 18,
                                fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    )),
              );
            }));
  }
}
