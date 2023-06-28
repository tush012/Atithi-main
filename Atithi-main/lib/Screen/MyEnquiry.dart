import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../Helper/Color.dart';
import '../Helper/Constant.dart';
import '../New_model/GetEnquiryModel.dart';
import '../api/api_services.dart';

class MyEnquiry extends StatefulWidget {
  const MyEnquiry({Key? key}) : super(key: key);

  @override
  State<MyEnquiry> createState() => _MyEnquiryState();
}

class _MyEnquiryState extends State<MyEnquiry> {

  Future<Null> refreshFunction()async{
    await  _getEnquiry();
  }
  @override
  void initState() {
    super.initState();
    _getEnquiry();
  }

  GetEnquiryModel? getEnquiryModel;
  _getEnquiry() async {
    print("Enquiryyyy Apiiiii");
    var headers = {
      'Cookie': 'ci_session=1db2867fc5f287b9d5f70d2589a2e26f9e99c911'
    };
    var request = http.MultipartRequest('POST', Uri.parse('${ApiService.getenquiries}'));

    request.headers.addAll(headers);
    http.StreamedResponse response = await request.send();
    if (response.statusCode == 200) {
      var finalResponse = await response.stream.bytesToString();
      final jsonResponse = GetEnquiryModel.fromJson(json.decode(finalResponse));
      print("Get Enquiry****$jsonResponse");
      setState(() {
        getEnquiryModel = GetEnquiryModel.fromJson(json.decode(finalResponse));
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
        title: Text("My Enquiry"),
        elevation: 0,
        centerTitle: true,
        backgroundColor: colors.primary,
      ),
      body: SingleChildScrollView(
        child: RefreshIndicator(
          onRefresh: refreshFunction,
          child: Column(
            children: [
              SizedBox(height: 10,),
              getEnquiryModel == null ? Center(
                  child: CircularProgressIndicator(color: colors.primary,)
              ):
              Container(
                height: MediaQuery.of(context).size.height/1.1,
                child: ListView.builder(
                    // shrinkWrap: true,
                    itemCount: getEnquiryModel?.data?.length,
                    scrollDirection: Axis.vertical,
                    // physics: const AlwaysScrollableScrollPhysics(),
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
                                    Image.network("${ApiService.imageUrl}${getEnquiryModel?.data?[index].profileImage}"),
                                  ),
                                ),
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
                                                Text("${getEnquiryModel?.data?[index].uname}"),
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
                                                Text("${getEnquiryModel?.data?[index].mobile}"),
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
                                                Text("${getEnquiryModel?.data?[index].cityName}"),
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
                                                Text("${getEnquiryModel?.data?[index].eventName}"),
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
                                                Text("${getEnquiryModel?.data?[index].description}"),
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
            ],
          ),
        ),
      ),
    );
  }
}
