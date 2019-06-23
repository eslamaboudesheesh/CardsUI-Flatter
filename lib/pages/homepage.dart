import 'package:flutter/material.dart';
import 'package:startagain/widget/ProductCard.dart';

class Homepage extends StatefulWidget {
  @override
  _MyAppState createState() => new _MyAppState();
}

class _MyAppState extends State<Homepage> with SingleTickerProviderStateMixin {

  AnimationController _controller;
  Animation<Offset> _offsetFloat;
  Animation<Offset> _headerOffsetFloat;

  @override


  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 1000),
    )..addListener(() {
        setState(() {});
      });
    _controller.forward();
    _headerOffsetFloat =
        Tween<Offset>(begin: Offset(0.0, 2.0), end: Offset.zero)
            .animate(_controller);
    _offsetFloat = Tween<Offset>(begin: Offset(0.0, 5.0), end: Offset.zero)
        .animate(_controller);
  }

  @override
  void dispose() {
    _controller.dispose();

    super.dispose();
  }

      @override

  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
          child: Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: 50.0, vertical: 30.0),
            child: new Column(
              children: <Widget>[
                SlideTransition(
                  position: _offsetFloat,
                  child: ProductCard(
                      0xFFfaecfb,
                      "assets/shoes_01.png",
                      "Hybrid Rocket WNS",
                      "\$999.00",
                      "\$749",
                      "12",
                      "For help getting started with Flutter, view our online documentation, which offers tutorials, samples, guidance on mobile development, and a full API reference"),
                ),
                SizedBox(
                  height: 32.0,
                ),
                SlideTransition(
                  position: _offsetFloat,
                  child: ProductCard(
                      0xFFf8e1da,
                      "assets/shoes_02.png",
                      "Hybrid Runner ARS",
                      "\$699",
                      "\$599",
                      "13",
                      "For help getting started with Flutter, view our online documentation, which offers tutorials, samples, guidance on mobile development, and a full API reference"),
                )
              ],
            ),
          ),
        ));
  }
}
