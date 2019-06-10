import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'CustomIcon.dart';
import 'package:advanced_share/advanced_share.dart';

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


void handleResponse(response, {String appName}) {
    if (response == 0) {
      print("failed.");
    } else if (response == 1) {
      print("success");
    } else if (response == 2) {
      print("application isn't installed");
    
    }
  }

  void gmail() {
    AdvancedShare
        .gmail(subject: "Advanced Share", msg: "Mail body", url: this.imagUrl)
        .then((response) {
      handleResponse(response, appName: "Gmail");
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(),
        body: Wrap(
          children: <Widget>[
            Column(
              children: <Widget>[
                Hero(
                    tag: "ID$id",
                    child: Container(
                       height: 280,
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Expanded(child:  new Image.asset(
                              imagUrl,
                              fit: BoxFit.contain,
                              width: MediaQuery.of(context).size.width,
                            ),)
                           
                          ],
                        ))),
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
                            height: 50.0,
                            width: 50.0,
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
                ),
                Container(
                 
                  padding: EdgeInsets.only(left: 20.0, top: 0.0, right:40.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      SizedBox(
                    width:300.0 ,
                    height: 120.0,
                    child: Text(desc , softWrap: true, style: TextStyle(fontSize: 14.0 , fontFamily:"Raleway" ),),
                  )
                    ],
                  )
                ),

                Container(alignment: Alignment.bottomCenter,
                margin: EdgeInsets.only(top: 80.0),
                child: InkWell(
                  onTap: (){},
                  child:FlatButton.icon(
          color: Colors.white,
          icon: Icon(Icons.share),
          label: Text('Share element'), 
          onPressed: () {

            gmail();
          }
        ),
                ),
                
                 ),
                 
              ],
            ),
          ],
        ));
  }
}
