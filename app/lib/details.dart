import 'dart:async';
import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart';

import './quote.dart';

class DetailsPage extends StatefulWidget {
  const DetailsPage({Key? key}) : super(key: key);

  @override
  _DetailsPageState createState() => _DetailsPageState();
}

class _DetailsPageState extends State<DetailsPage> {
  String _url = "https://api.quotable.io/random";
  late StreamController _streamController;
  late Stream _stream;
  late Response response;
  int counter = 0;

  getQuotes() async {
    _streamController.add("waiting");
    response = await get(Uri.parse(_url));
    _streamController.add(json.decode(response.body));
  }

  @override
  void initState() {
    super.initState();
    _streamController = StreamController();
    _stream = _streamController.stream;
    getQuotes();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color.fromRGBO(251, 234, 235, 1.0),
        appBar: AppBar(
          backgroundColor: Color.fromRGBO(47, 60, 123, 1.0),
          title: const Text("Motivation for the day"),
        ),
        body: Center(
          child: StreamBuilder(
              stream: _stream,
              builder: (BuildContext ctx, AsyncSnapshot snapshot) {
                if (snapshot.data == "waiting") {
                  return Center(child: Text("Waiting of the Quotes....."));
                }
                return GestureDetector(
                  onDoubleTap: () {
                    getQuotes();
                  },
                  child: Stack(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(4.0),
                        child: Center(
                            child: Text(
                          snapshot.data['content'].toString().toUpperCase(),
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              letterSpacing: 0.8,
                              fontSize: 25.0,
                              color: Color.fromRGBO(47, 60, 126, 1.0),
                              fontWeight: FontWeight.bold),
                        )),
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(bottom: 50.0),
                            child: Center(
                                child: Text(
                              "-" +
                                  snapshot.data['author']
                                      .toString()
                                      .toUpperCase(),
                              textAlign: TextAlign.right,
                              style: TextStyle(
                                  letterSpacing: 0.8,
                                  fontSize: 18.0,
                                   color: Color.fromRGBO(47, 60, 126, 1.0),
                                  fontWeight: FontWeight.bold),
                            )),
                          ),
                        ],
                      ),
                    ],
                  ),
                );
              }),
        ),
        );
  }
}
