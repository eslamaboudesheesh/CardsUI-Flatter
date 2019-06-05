import 'package:flutter/material.dart';
import 'CustomIcon.dart';

class ProductCard extends StatelessWidget {
  int cardColor;
  String imgUrl;
  String title;
  String previousPrice;
  String price;
  String id;
  String desc;

  ProductCard(this.cardColor, this.imgUrl, this.title, this.previousPrice,
      this.price, this.id, this.desc);

  @override
  Widget build(BuildContext context) {
    return InkWell(
        onTap: () {
          Navigator.push(context,
              MaterialPageRoute(builder: (BuildContext context) {
            return AnotherPage(
              imagUrl: this.imgUrl,
              title: this.title,
              id: this.id,
              desc: this.desc,
            );
          }));
        },
        child: Hero(
          tag: "ID$id",
          child: Container(
            width: double.infinity,
            height: 290.0,
            decoration: BoxDecoration(
                color: Color(cardColor),
                borderRadius: BorderRadius.circular(20.0),
                border:
                    Border.all(color: Colors.grey.withOpacity(.3), width: .2)),
            child: Column(
              children: <Widget>[
                SizedBox(
                  height: 8.0,
                ),
                Image.asset(imgUrl, width: 281.0, height: 191.0),
                Material(
                  child: Text(title,
                      style: TextStyle(fontSize: 25.0, fontFamily: "Raleway")),
                  color: Colors.transparent,
                ),
              ],
            ),
          ),
        ));
  }
}

class AnotherPage extends StatelessWidget {
  final String imagUrl;
  final String title;
  final String id;
  final String desc;
  const AnotherPage({Key key, this.imagUrl, this.title, this.id, this.desc})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Hero(
          tag: "ID$id",
          child: Container(
              child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              new Image.asset(imagUrl),
              Material(
                child: Container(
                  padding: EdgeInsets.only(left: 20.0, right: 20.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text(
                        title,
                        style: TextStyle(
                          fontFamily: 'Raleway',
                          fontSize: 20.0,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      SizedBox(
                        child: Container(
                          height: 30.0,
                          width: 60.0,
                          alignment: Alignment.centerRight,
                          margin: EdgeInsets.only(),
                          child: Image.asset(
                            imagUrl,
                            fit: BoxFit.contain,
                          ),
                        ),
                      )
                    ],
                  ),
                ),
                color: Colors.transparent,
              )
            ],
          ))),
    );
  }
}
