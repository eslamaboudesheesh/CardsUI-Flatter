// import 'package:flutter/material.dart';
// import 'package:flutter/rendering.dart';
// import 'package:valu/constants/colors.dart';
// import 'package:valu/constants/font_sizes.dart';
// import 'package:valu/models/jmr_models/mobile/customer/payment/upcoming-pay-det/upcoming_pay_det_response.dart';

// class DueCard extends StatelessWidget {
//   CustomerDue row;
//   final ValueChanged<bool> onTab;
//   final bool isExpanded;

//   DueCard(this.row, this.onTab, this.isExpanded);

//   Widget build(BuildContext context) {
//     return Container(
//         color: Colors.transparent,
//         padding: EdgeInsets.symmetric(vertical: 3.0, horizontal: 10.0),
//         child: ClipRRect(
//           borderRadius: new BorderRadius.circular(15.0),
//           child: Container(
//             child: Card(
//               elevation: 1.6,
//               child: ExpansionTile(
//                 initiallyExpanded: isExpanded,
//                 onExpansionChanged: onTab,
//                 title: Container(
//                   padding: EdgeInsets.only(top: 7.0, bottom: 7.0),
//                   child: Row(
//                     children: <Widget>[
//                       Image.asset(
//                         "resources/icons/ic_due_payment.png",
//                         width: 65,
//                         height: 40,
//                         alignment: Alignment.topCenter,
//                       ),
//                       Expanded(
//                         child: Column(
//                           crossAxisAlignment: CrossAxisAlignment.start,
//                           mainAxisAlignment: MainAxisAlignment.center,
//                           children: <Widget>[
//                             Container(
//                               margin: EdgeInsets.symmetric(
//                                   vertical: 0, horizontal: 0),
//                               padding: EdgeInsets.symmetric(
//                                   vertical: 5, horizontal: 0),
//                               child: Text("${row.dueDate} ",
//                                   style: TextStyle(
//                                       color: Colors.black,
//                                       fontSize: FontSizes.medium)),
//                             ),
//                             Container(
//                               margin: EdgeInsets.symmetric(
//                                   vertical: 0, horizontal: 0),
//                               padding: EdgeInsets.symmetric(
//                                   vertical: 0, horizontal: 0),
//                               child: Text(
//                                   // FlutterI18n.translate(
//                                   //     context, "apply_to_valu_message"),
//                                   "${row.totDue} EGP ",
//                                   style: TextStyle(
//                                     color: Colorspalette.valuAccentColor,
//                                     fontSize: FontSizes.medium,
//                                   )),
//                             ),
//                           ],
//                         ),
//                       ),
//                       (row.canPay != null)
//                           ? RaisedButton(
//                               padding: EdgeInsets.all(0.0),
//                               onPressed: () {},
//                               color: Colorspalette.valuAccentColor,
//                               shape: new RoundedRectangleBorder(
//                                   borderRadius: new BorderRadius.circular(5.0)),
//                               child: Text(
//                                 'Pay Now',
//                                 style: TextStyle(
//                                     fontSize: 15, color: Colors.white),
//                               ),
//                             )
//                           : Opacity(
//                               opacity: 0.7, //with 50% opacity

//                               child: RaisedButton(
//                                 padding: EdgeInsets.all(0.0),
//                                 onPressed: null,
//                                 shape: new RoundedRectangleBorder(
//                                     borderRadius:
//                                         new BorderRadius.circular(5.0)),
//                                 child: Text(
//                                   'Pay Now',
//                                   style: TextStyle(
//                                       fontSize: 15,
//                                       color: Colors.grey[600],
//                                       fontWeight: FontWeight.bold),
//                                 ),
//                               ),
//                             )
//                     ],
//                   ),
//                 ),
//                 children: <Widget>[
//                   Divider(
//                     color: Colors.grey,
//                   ),
                  
//                       SingleChildScrollView(child: DuePaymentDetails(row.pucrhaseDues))
                   
//                 ],
//               ),
//             ),
//           ),
//         ));
//   }
// }

// class DuePaymentDetails extends StatelessWidget {
//   List<PucrhaseDue> row;

//   DuePaymentDetails(this.row);

//   @override
//   Widget build(BuildContext context) {
//     return test();
//   }

//   test() {
//     List<Widget> list = new List<Widget>();
//     for (int i = 0; i < row.length; i++) {
//       return Container(
//             padding: EdgeInsets.only(top: 5.0),
//             child: Column(
//               children: <Widget>[
//                 SizedBox(
//                   height: 40.0,
//                   child: ListTile(
//                     title: Text("Vendor Name: "),
//                     trailing: Text(row[i].vendorName,
//                         style: TextStyle(
//                             fontSize: FontSizes.medium,
//                             color: Colorspalette.valuAccentColor,
//                             fontWeight: FontWeight.w600)),
//                   ),
//                 ),
//                 SizedBox(
//                   height: 40.0,
//                   child: ListTile(
//                     title: Text("Loan Number: "),
//                     trailing: Text("${row[i].refNum}",
//                         style: TextStyle(
//                             fontSize: FontSizes.medium,
//                             color: Colorspalette.valuAccentColor,
//                             fontWeight: FontWeight.w600)),
//                   ),
//                 ),
//                 ListTile(
//                   title: Text("Installment Amount "),
//                   trailing: Text(
//                     "${row[i].totOverDue}",
//                     style: TextStyle(
//                         fontSize: FontSizes.medium,
//                         color: Colorspalette.valuAccentColor,
//                         fontWeight: FontWeight.w600),
//                   ),
//                 ),
//                 Padding(
//                   padding: EdgeInsets.only(left: 20.0, right: 20.0),
//                   child: Divider(
//                     color: Colors.grey,
//                     height: 0.0,
//                   ),
//                 ),
//               ],
//             ),
        
//       );
//     }
//   }
  
// }
