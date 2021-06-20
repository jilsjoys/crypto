import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class Details extends StatefulWidget {
  String iconurl;
  String name;
  String id;

  String symbol;
  String perc;
  String marketcap;

  Details({
    required this.iconurl,
    required this.id,
    required this.marketcap,
    required this.symbol,
    required this.name,
    required this.perc,
  });

  @override
  _DetailsState createState() => _DetailsState();
}

class _DetailsState extends State<Details> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.name,
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
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          SizedBox(
            height: 20,
          ),
          Center(
            child: Container(
                child: widget.iconurl
                            .toString()
                            .substring(widget.iconurl.toString().length - 2) ==
                        "vg"
                    ? CircleAvatar(
                        backgroundColor: Colors.transparent,
                        radius: 50,
                        child: new SvgPicture.network(
                          widget.iconurl,
                          fit: BoxFit.scaleDown,
                        ),
                      )
                    : CircleAvatar(
                        backgroundColor: Colors.transparent,
                        radius: 50,
                        child: new Image.network(
                          widget.iconurl,
                          fit: BoxFit.scaleDown,
                        ),
                      )),
          ),
          SizedBox(
            height: 20,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                widget.symbol,
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 20,
                    fontWeight: FontWeight.bold),
              ),
            ],
          ),
          SizedBox(
            height: 20,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 8.0, right: 8),
            child: Card(
              elevation: 7,
              shadowColor: Colors.black,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15.0),
              ),
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Market Cap : ",
                      style: TextStyle(color: Colors.black54, fontSize: 20),
                    ),
                    Text(
                      widget.marketcap,
                      style: TextStyle(color: Colors.black, fontSize: 20),
                    ),
                  ],
                ),
              ),
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 8.0, right: 8),
            child: Card(
              elevation: 7,
              shadowColor: Colors.black,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15.0),
              ),
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Price change (24hrs) : ",
                      style: TextStyle(color: Colors.black54, fontSize: 20),
                    ),
                    Text(
                      widget.perc.toString(),
                      style: TextStyle(color: Colors.black, fontSize: 20),
                    ),
                    Text(
                      "%",
                      style: TextStyle(color: Colors.black, fontSize: 20),
                    )
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
