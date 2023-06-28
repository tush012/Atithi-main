
import 'dart:convert';

import 'package:doctorapp/Screen/HomeScreen.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import '../Helper/Color.dart';
import '../New_model/EventListModel.dart';
import '../api/api_services.dart';
import 'Bottom.dart';
import 'EnquiryForm.dart';


class EventDetails extends StatefulWidget {
  const EventDetails({Key? key}) : super(key: key);

  @override
  State<EventDetails> createState() => _EventDetailsState();
}

class _EventDetailsState extends State<EventDetails> {

  Future<Null> refreshFunction()async{
    await nearByEvevt();
  }

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration(milliseconds: 400),(){
      return nearByEvevt();
    });
  }

  String? cities;
  EventListModel? eventListModel;
  nearByEvevt() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    cities = preferences.getString("cities");
    print("Citiesss id noww ${cities}");
    var headers = {
      'Cookie': 'ci_session=e6545df7c1714023144b9f63cc94cd2118c2e751'
    };
    var request = http.MultipartRequest('POST', Uri.parse('${ApiService.geteventmanagers}'));
    request.fields.addAll({
      'city_id': cities.toString(),
    });
    print("City id in event manager page ${request.fields}");
    request.headers.addAll(headers);
    http.StreamedResponse response = await request.send();
    if (response.statusCode == 200) {
      var finalResponse = await response.stream.bytesToString();
      final jsonResponse = EventListModel.fromJson(json.decode(finalResponse));
      setState(() {
        eventListModel = jsonResponse;
      });
    }
    else {
      print(response.reasonPhrase);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: colors.primary,
        title: Text("Details"),
      ),
      body: RefreshIndicator(
        onRefresh: refreshFunction,
        child: Column(
          children: [
            SizedBox(height: 10,),
            Positioned(
              child: eventListModel == null ? Center(
                  child: CircularProgressIndicator(color: colors.primary,)
              ):
              InkWell(
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => EventDetails()));
                },
                child: ListView.builder(
                    shrinkWrap: true,
                    itemCount: eventListModel?.data?.length,
                    scrollDirection: Axis.vertical,
                    physics: AlwaysScrollableScrollPhysics(),
                    itemBuilder: (BuildContext context, int index){
                      return  Card(
                        margin: EdgeInsets.all(10),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                        elevation: 5.0,
                        child: Padding(
                          padding: const EdgeInsets.all(8),
                          child: Container(
                            height: MediaQuery.of(context).size.width/1.1,
                            width: MediaQuery.of(context).size.width/1,
                            child:Column(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Container(
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      // image: DecorationImage(image: AssetImage('assets/images/img.png'),fit: BoxFit.fill)
                                    ),
                                    height: 140,
                                    width: MediaQuery.of(context).size.width,
                                    child:
                                    // Image.asset('assets/images/img.png'),
                                    Image.network("${eventListModel?.data?[index].profileImage}"),
                                  ),
                                ),
                                // SizedBox(
                                //   height: 15,
                                // ),
                                Container(
                                  // alignment: Alignment.topRight,
                                  // margin: EdgeInsets.only(left: 20),
                                  child: Padding(
                                    padding: const EdgeInsets.all(10),
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Padding(padding: EdgeInsets.only(top: 25)),
                                        Row(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Container(
                                                width: MediaQuery.of(context).size.width/2.2,
                                                child: Row(
                                                  children: [
                                                    Text("Name:",textAlign: TextAlign.right),
                                                  ],
                                                )),
                                            Container(child: Row(
                                              children: [
                                                Text("${eventListModel?.data?[index].uname}"),
                                              ],
                                            )),
                                          ],
                                        ),
                                        SizedBox(height: 7),
                                        Row(
                                          children: [
                                            Container(
                                                width: MediaQuery.of(context).size.width/2.2,

                                                child: Row(
                                                  children: const [
                                                    Text("Mobile no:",textAlign: TextAlign.right),
                                                  ],
                                                )),
                                            Container(child: Row(
                                              children: [
                                                Text("${eventListModel?.data?[index].mobile}"),
                                              ],
                                            )),
                                          ],
                                        ),
                                        SizedBox(height: 7),
                                        Row(
                                          children: [
                                            Container(
                                                width: MediaQuery.of(context).size.width/2.2,
                                                child: Row(
                                                  children: [
                                                    Text("City",textAlign: TextAlign.right),
                                                  ],
                                                )),
                                            Container(child: Row(
                                              children: [
                                                Text("${eventListModel?.data?[index].cityName}"),
                                              ],
                                            ))
                                          ],
                                        ),
                                        SizedBox(height: 7),
                                        Row(
                                          children: [
                                            Container(
                                                width: MediaQuery.of(context).size.width/2.2,

                                                child: Row(
                                                  children: [
                                                    Text("Event Name:",textAlign: TextAlign.right),
                                                  ],
                                                )),
                                            Container(child: Row(
                                              children: [
                                                Text("${eventListModel?.data?[index].eventName}"),
                                              ],
                                            ))
                                          ],
                                        ),
                                        SizedBox(height: 7),
                                        Row(
                                          children: [
                                            Container(
                                                width: MediaQuery.of(context).size.width/2.2,

                                                child: Row(
                                                  children: [
                                                    Text("Description:",textAlign: TextAlign.right),
                                                  ],
                                                )),
                                            Container(child: Row(
                                              children: [
                                                Text("${eventListModel?.data?[index].description}"),
                                              ],
                                            )),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    }
                ),
              ),
              // InkWell(
              //   onTap: (){
              //     Navigator.push(context, MaterialPageRoute(builder:(context)=>EventDetails()));
              //   },
              //   child: Card(
              //       margin: EdgeInsets.all(10),
              //       shape: RoundedRectangleBorder(
              //           borderRadius: BorderRadius.circular(20)),
              //       elevation: 5.0,
              //       child: Container(
              //         height: MediaQuery
              // s            .of(context)
              //             .size
              //             .width / 3,
              //         width: MediaQuery
              //             .of(context)
              //             .size
              //             .width / 1,
              //         child: Row(
              //           children: [
              //             Padding(padding: EdgeInsets.all(10)),
              //             Container(
              //               decoration: BoxDecoration(
              //                 borderRadius: BorderRadius.circular(10),
              //               ),
              //               height: 140,
              //               width: 140,
              //               child: Image.asset("assets/images/food.png"),
              //             ),
              //             SizedBox(
              //               height: 20,
              //             ),
              //             Container(
              //               alignment: Alignment.topRight,
              //               margin: EdgeInsets.only(left: 10),
              //               child: Column(
              //                 crossAxisAlignment: CrossAxisAlignment.start,
              //                 children: [
              //                   Padding(padding: EdgeInsets.only(top: 20)),
              //                   Row(
              //                     crossAxisAlignment: CrossAxisAlignment.start,
              //                     children: [
              //                       Text("Name: ", textAlign: TextAlign.right,),
              //                       Text(" First User"),
              //                     ],
              //                   ),
              //                   SizedBox(height: 3,),
              //                   Row(
              //                     children: [
              //                       Text("Mobile no:", textAlign: TextAlign.right,),
              //                       Text(" 9012345678"),
              //                     ],
              //                   ),
              //                   SizedBox(height: 3,),
              //
              //                   Row(
              //                     children: [
              //                       Text("KM:", textAlign: TextAlign.right),
              //                       Text(" 4 KM")
              //                     ],
              //                   )
              //                 ],
              //               ),
              //             )
              //           ],
              //         ),
              //       ),
              //   ),
              // ),
              // InkWell(
              //     onTap: (){
              //       Navigator.push(context, MaterialPageRoute(builder:(context)=>EventDetails()));
              //     },
              //     child:
              //     Card(
              //         margin: EdgeInsets.all(10),
              //         shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
              //         elevation: 5.0,
              //         child: Container(
              //           height: MediaQuery.of(context).size.width/3,
              //           width: MediaQuery.of(context).size.width/1 ,
              //           child:Row(
              //             children: [
              //               Padding(padding: EdgeInsets.all(10)),
              //               Container(
              //                 decoration: BoxDecoration(
              //                   borderRadius: BorderRadius.circular(10),
              //                 ),
              //                 height: 140,
              //                 width: 140,
              //                 child: Image.asset("assets/images/tent.png"),
              //               ),
              //               SizedBox(
              //                 height: 20,
              //               ),
              //               Container(
              //                 alignment: Alignment.topRight,
              //                 margin: EdgeInsets.only(left: 10),
              //                 child: Column(
              //                   crossAxisAlignment: CrossAxisAlignment.start,
              //                   children: [
              //                     Padding(padding: EdgeInsets.only(top: 20),),
              //                     Row(
              //                       crossAxisAlignment: CrossAxisAlignment.start,
              //                       children: [
              //                         Text("Name: ",textAlign: TextAlign.right,),
              //                         Text(" First User"),
              //                       ],
              //                     ),
              //                     SizedBox(height: 3,),
              //                     Row(
              //                       children: [
              //                         Text("Mobile no:",textAlign: TextAlign.right,),
              //                         Text(" 9012345678"),
              //                       ],
              //                     ),
              //                     SizedBox(height: 3,),
              //
              //                     Row(
              //                       children: [
              //                         Text("KM:",textAlign: TextAlign.right),
              //                         Text(" 4 KM")
              //                       ],
              //                     )
              //                   ],
              //                 ),
              //               )
              //             ],
              //           ) ,
              //         )
              //     ),
              // ),
              // InkWell(
              //   onTap: (){
              //     Navigator.push(context, MaterialPageRoute(builder:(context)=>EventDetails()));
              //   },
              //   child: Card(
              //     margin: EdgeInsets.all(10),
              //     shape: RoundedRectangleBorder(
              //         borderRadius: BorderRadius.circular(20)),
              //     elevation: 5.0,
              //     child: Container(
              //       height: MediaQuery
              //           .of(context)
              //           .size
              //           .width / 3,
              //       width: MediaQuery
              //           .of(context)
              //           .size
              //           .width / 1,
              //       child: Row(
              //         children: [
              //           Padding(padding: EdgeInsets.all(10)),
              //           Container(
              //             decoration: BoxDecoration(
              //               borderRadius: BorderRadius.circular(10),
              //             ),
              //             height: 140,
              //             width: 140,
              //             child: Image.asset("assets/images/food.png"),
              //           ),
              //           SizedBox(
              //             height: 20,
              //           ),
              //           Container(
              //             alignment: Alignment.topRight,
              //             margin: EdgeInsets.only(left: 10),
              //             child: Column(
              //               crossAxisAlignment: CrossAxisAlignment.start,
              //               children: [
              //                 Padding(padding: EdgeInsets.only(top: 20)),
              //                 Row(
              //                   crossAxisAlignment: CrossAxisAlignment.start,
              //                   children: [
              //                     Text("Name: ", textAlign: TextAlign.right,),
              //                     Text(" First User"),
              //                   ],
              //                 ),
              //                 SizedBox(height: 3,),
              //                 Row(
              //                   children: [
              //                     Text("Mobile no:", textAlign: TextAlign.right,),
              //                     Text(" 9012345678"),
              //                   ],
              //                 ),
              //                 SizedBox(height: 3,),
              //
              //                 Row(
              //                   children: [
              //                     Text("KM:", textAlign: TextAlign.right),
              //                     Text(" 4 KM")
              //                   ],
              //                 )
              //               ],
              //             ),
              //           )
              //         ],
              //       ),
              //     ),
              //   ),
              // ),
              // InkWell(
              //   onTap: (){
              //     Navigator.push(context, MaterialPageRoute(builder:(context)=>EventDetails()));
              //   },
              //   child:Card(
              //       margin: EdgeInsets.all(10),
              //       shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
              //       elevation: 5.0,
              //       child: Container(
              //         height: MediaQuery.of(context).size.width/3,
              //         width: MediaQuery.of(context).size.width/1 ,
              //         child:Row(
              //           children: [
              //             Padding(padding: EdgeInsets.all(10)),
              //             Container(
              //               decoration: BoxDecoration(
              //                 borderRadius: BorderRadius.circular(10),
              //               ),
              //               height: 140,
              //               width: 140,
              //               child: Image.asset("assets/images/tent.png"),
              //             ),
              //             SizedBox(
              //               height: 20,
              //             ),
              //             Container(
              //               alignment: Alignment.topRight,
              //               margin: EdgeInsets.only(left: 10),
              //               child: Column(
              //                 crossAxisAlignment: CrossAxisAlignment.start,
              //                 children: [
              //                   Padding(padding: EdgeInsets.only(top: 20)),
              //                   Row(
              //                     crossAxisAlignment: CrossAxisAlignment.start,
              //                     children: [
              //                       Text("Name: ",textAlign: TextAlign.right,),
              //                       Text(" First User"),
              //                     ],
              //                   ),
              //                   SizedBox(height: 3),
              //                   Row(
              //                     children: [
              //                       Text("Mobile no:",textAlign: TextAlign.right,),
              //                       Text(" 9012345678"),
              //                     ],
              //                   ),
              //                   SizedBox(height: 3,),
              //
              //                   Row(
              //                     children: [
              //                       Text("KM:",textAlign: TextAlign.right),
              //                       Text(" 4 KM")
              //                     ],
              //                   )
              //                 ],
              //               ),
              //             )
              //           ],
              //         ) ,
              //       )
              //   ),
              // ),
            ),
            SizedBox(
              height: 200,
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                height: 50,
                width: MediaQuery.of(context).size.width/1.3,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(backgroundColor: colors.primary),
                  onPressed: (){
                    // Fluttertoast.showToast(msg: "Enquiry submit successfully");
                    Navigator.push(context, MaterialPageRoute(builder: (context) => EnquiryForm()));
                  },
                  child: Text("Enquiry",style: TextStyle(fontSize: 15)
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
