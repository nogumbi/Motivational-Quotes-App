import 'dart:js';

import 'package:flutter/material.dart';



import './details.dart';

// import './quote.dart';

void main() {
  runApp(MaterialApp(
    title: 'QuteQuote',
    initialRoute: "/details",
    routes: {
      
      "/details": (context) => DetailsPage(),
     
    },
  ));
}
