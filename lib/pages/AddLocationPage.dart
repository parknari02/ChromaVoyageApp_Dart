// import 'package:chromavoyage_client/widgets/AddLocationWidget.dart';
// import 'package:flutter/material.dart';

// class AddLocationPage extends StatelessWidget {
//   final locationController = TextEditingController();

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       // appBar: AppBar(
//       //   title: Text('Add Location'),
//       // ),
//       body: Center(
//       child: SingleChildScrollView(
//         child: Column(
//           children: [
            
//             Container(
//               width: 390,
//               height: 789,
//               clipBehavior: Clip.antiAlias,
//               decoration: BoxDecoration(color: Colors.white),
//               child: Stack(
//                 children: [
//                   AddLocation(),
//                   Positioned(
                    
//                     left: 52,
//                     top: 31,
//                     child: SizedBox(
//                       width: 54,
//                       height: 11,
//                       child: Text(
//                         '박나리님',
//                         textAlign: TextAlign.center,
//                         style: TextStyle(
//                           color: Color(0xFF462193),
//                           fontSize: 12,
//                           fontFamily: 'Do Hyeon',
//                           fontWeight: FontWeight.w400,
//                           height: 0,
//                         ),
//                       ),
//                     ),
//                   ),
                 
//                   Positioned(
//                     left: 155,
//                     top: 325,
//                     child: Opacity(
//                       opacity: 0.50,
//                       child: Container(
//                         width: 79,
//                         height: 99.74,
//                         child: Stack(
//                           children: [
                            
//                             Positioned(
//                               left: 0,
//                               top: 5.92,
//                               child: Container(
//                                 width: 79,
//                                 height: 79,
//                                 decoration: ShapeDecoration(
//                                   color: Color(0xFFEDE5FF),
//                                   shape: OvalBorder(),
//                                   shadows: [
//                                     BoxShadow(
//                                       color: Color(0x19000000),
//                                       blurRadius: 4,
//                                       offset: Offset(0, 4),
//                                       spreadRadius: 0,
//                                     ),
//                                   ],
//                                 ),
//                               ),
//                             ),
//                             Positioned(
//                               left: 7.90,
//                               top: 0,
//                               child: SizedBox(
//                                 width: 64.19,
//                                 height: 99.74,
//                                 child: Text(
//                                   'c',
//                                   textAlign: TextAlign.center,
//                                   style: TextStyle(
//                                     color: Colors.white,
//                                     fontSize: 64,
//                                     fontFamily: 'Inter',
//                                     fontWeight: FontWeight.w800,
//                                     height: 0,
//                                   ),
//                                 ),
//                               ),
//                             ),
//                           ],
//                         ),
//                       ),
//                     ),
//                   ),
//                   Positioned(
//                     left: 86,
//                     top: 417,
//                     child: SizedBox(
//                       width: 218,
//                       height: 49,
//                       child: Opacity(
//                         opacity: 0.50,
//                         child: Text.rich(
//                           TextSpan(
//                             children: [
//                               TextSpan(
//                                 text: 'Chroma Voyage\n',
//                                 style: TextStyle(
//                                   color: Color(0xFFB28EFF),
//                                   fontSize: 16,
//                                   fontFamily: 'Koulen',
//                                   fontWeight: FontWeight.w400,
//                                   height: 0,
//                                 ),
//                               ),
//                               TextSpan(
//                                 text: ' ',
//                                 style: TextStyle(
//                                   color: Colors.white,
//                                   fontSize: 16,
//                                   fontFamily: 'Inter',
//                                   fontWeight: FontWeight.w800,
//                                   height: 0,
//                                 ),
//                               ),
//                             ],
//                           ),
//                           textAlign: TextAlign.center,
//                         ),
//                       ),
//                     ),
//                   ),
//                   Positioned(
//                     left: 0,
//                     top: 711,
//                     child: Container(
//                       width: 390,
//                       height: 78,
//                       decoration: BoxDecoration(
//                         color: Color(0xFF6540B4),
//                         boxShadow: [
//                           BoxShadow(
//                             color: Color(0x3F000000),
//                             blurRadius: 4,
//                             offset: Offset(0, 4),
//                             spreadRadius: 0,
//                           ),
//                         ],
//                       ),
//                     ),
//                   ),
//                   Positioned(
//                     left: 33,
//                     top: 732,
//                     child: Container(
//                       width: 45,
//                       height: 45,
//                       clipBehavior: Clip.antiAlias,
//                       decoration: BoxDecoration(),
//                       child: Stack(
//                         children: [
//                           Text("지도"),
//                         ],
//                       ),
//                     ),
//                   ),
                  
//                   Positioned(
//                     left: 167,
//                     top: 718,
//                     child: Opacity(
//                       opacity: 0.85,
//                       child: Container(
//                         width: 55.33,
//                         height: 69.85,
//                         child: Stack(
//                           children: [
//                             Positioned(
//                               left: 0,
//                               top: 4.15,
//                               child: Container(
//                                 width: 55.33,
//                                 height: 55.33,
//                                 decoration: ShapeDecoration(
//                                   gradient: LinearGradient(
//                                     begin: Alignment(0.00, -1.00),
//                                     end: Alignment(0, 1),
//                                     colors: [Colors.white, Color(0xE2FAFAFA), Color(0x00D9D9D9)],
//                                   ),
//                                   shape: OvalBorder(
//                                     side: BorderSide(width: 3, color: Colors.white),
//                                   ),
//                                   shadows: [
//                                     BoxShadow(
//                                       color: Color(0x19000000),
//                                       blurRadius: 4,
//                                       offset: Offset(0, 4),
//                                       spreadRadius: 0,
//                                     ),
//                                   ],
//                                 ),
//                               ),
//                             ),
//                             Positioned(
//                               left: 5.53,
//                               top: 0,
//                               child: SizedBox(
//                                 width: 44.95,
//                                 height: 69.85,
//                                 child: Text(
//                                   'c',
//                                   textAlign: TextAlign.center,
//                                   style: TextStyle(
//                                     color: Colors.white,
//                                     fontSize: 44,
//                                     fontFamily: 'Inter',
//                                     fontWeight: FontWeight.w700,
//                                     height: 0,
//                                   ),
//                                 ),
//                               ),
//                             ),
//                           ],
//                         ),
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           ],
//         ),
//       ),
//       )
//     );
//   }
// }

// void main() {
//   runApp(MaterialApp(
//     home: AddLocationPage(),
//   ));
// }