// import 'dart:convert';
//
// import 'package:carousel_slider/carousel_slider.dart';
// import 'package:doctorapp/AuthenticationView/LoginScreen.dart';
// import 'package:doctorapp/Booking/booking_screen.dart';
// import 'package:doctorapp/Brand/BrandScreen.dart';
// import 'package:doctorapp/Helper/Color.dart';
// import 'package:doctorapp/Screen/Histroy.dart';
// import 'package:doctorapp/Static/privacy_Policy.dart';
// import 'package:doctorapp/api/api_services.dart';
//
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:http/http.dart' as http;
// import 'package:shared_preferences/shared_preferences.dart';
//
// import '../Awreness/Awareness_Inputs_screen.dart';
// import '../Editorial/editorial.dart';
// import '../Event/event_and_webiner.dart';
// import '../New_model/Check_plan_model.dart';
// import '../New_model/GetCountingModel.dart';
// import '../New_model/GetSelectCatModel.dart';
// import '../New_model/GetSliderModel.dart';
// import '../New_model/GetcategoryModel.dart';
// import '../New_model/getUserProfileModel.dart';
// import '../Profile/Update_password.dart';
// import '../Profile/profile_screen.dart';
// import '../Service/serviceScreen.dart';
// import '../SubscriptionPlan/addPosterScreen.dart';
// import '../SubscriptionPlan/subscription_plan.dart';
// import '../widgets/widgets/commen_slider.dart';
// import '../Product/Pharma_product_screen.dart';
// import 'TemplateScreen.dart';
// import 'WishlistScreen.dart';
//
// import '../Static/terms_condition.dart';
// import '../News/update_screen.dart';
// import 'filte_speciality.dart';
//
// class HomeScreen extends StatefulWidget {
//   final bool? speciality;
//   const HomeScreen({
//     Key? key, this.speciality
//   }) : super(key: key);
//
//   @override
//   State<HomeScreen> createState() => _HomeScreenState();
// }
//
// class _HomeScreenState extends State<HomeScreen> {
//   final GlobalKey<ScaffoldState> _key = GlobalKey();
//   SpeciplyData? localFilter;
//   int currentindex = 0;
//
//   // GetUserProfileModel? getprofile;
//   // getuserProfile() async {
//   //   SharedPreferences preferences = await SharedPreferences.getInstance();
//   //   String? userId = preferences.getString('userId');
//   //   print("getProfile--------------->${userId}");
//   //   var headers = {
//   //     'Cookie': 'ci_session=d9075fff59f39b7a82c03ca267be8899c1a9fbf8'
//   //   };
//   //   var request = http.MultipartRequest(
//   //       'POST', Uri.parse('${ApiService.getUserProfile}'));
//   //   request.fields.addAll({'user_id': '$userId'});
//   //   print("getProfile--------------->${request.fields}");
//   //   request.headers.addAll(headers);
//   //
//   //   http.StreamedResponse response = await request.send();
//   //
//   //   if (response.statusCode == 200) {
//   //     var finalResult = await response.stream.bytesToString();
//   //     final jsonResponse =
//   //         GetUserProfileModel.fromJson(json.decode(finalResult));
//   //     print("this is a ========>profile${jsonResponse}");
//   //     print("emailllllll${getprofile?.user?.mobile}");
//   //     setState(() {
//   //       getprofile = jsonResponse;
//   //     });
//   //   } else {
//   //     print(response.reasonPhrase);
//   //   }
//   // }
//
//   // GetSelectCatModel? selectCatModel;
//   // getCatApi() async {
//   //   SharedPreferences preferences = await SharedPreferences.getInstance();
//   //   String? Roll = preferences.getString('roll');
//   //   String? userId = preferences.getString('userId');
//   //   print("getRoll--------------->${Roll}");
//   //
//   //   var headers = {
//   //     'Cookie': 'ci_session=742f7d5e34b7f410d122da02dbbe7e75f06cadc8'
//   //   };
//   //   var request = http.MultipartRequest(
//   //       'POST', Uri.parse('${ApiService.selectCategory}'));
//   //   request.fields.addAll({'roll': '1', 'cat_type': "2", 'user_id': '$userId'});
//   //   print("this is a Response==========>${request.fields}");
//   //   request.headers.addAll(headers);
//   //   http.StreamedResponse response = await request.send();
//   //   if (response.statusCode == 200) {
//   //     //preferences.setString('id', "Id");
//   //     final result = await response.stream.bytesToString();
//   //     final finalResult = GetSelectCatModel.fromJson(jsonDecode(result));
//   //     print('_____Surendra _____${finalResult}_________');
//   //
//   //     setState(() {
//   //       selectCatModel = finalResult;
//   //     });
//   //   } else {
//   //     print(response.reasonPhrase);
//   //   }
//   // }
//
//   _CarouselSlider1() {
//     return CarouselSlider(
//       options: CarouselOptions(
//           onPageChanged: (index, result) {
//             setState(() {
//               _currentPost = index;
//             });
//           },
//           viewportFraction: 1.0,
//           initialPage: 0,
//           enableInfiniteScroll: true,
//           reverse: false,
//           autoPlay: true,
//           autoPlayInterval: Duration(seconds: 5),
//           autoPlayAnimationDuration: Duration(milliseconds: 500),
//           enlargeCenterPage: false,
//           scrollDirection: Axis.horizontal,
//           height: 180.0),
//       items: _sliderModel?.data?.map((item) {
//         return CommonSlider(file: item.image ?? '',);
//       }).toList(),
//     );
//   }
//
//   GetSliderModel? _sliderModel;
//   getSliderApi() async {
//     var headers = {
//       'Cookie': 'ci_session=ccb37a117d31b04c006884a89fbff3d1a39bffd7'
//     };
//     var request = http.Request('GET', Uri.parse('${ApiService.getSlider}'));
//     request.headers.addAll(headers);
//     http.StreamedResponse response = await request.send();
//     if (response.statusCode == 200) {
//       var result = await response.stream.bytesToString();
//       print("this is a response===========>${result}");
//       final finalResult = GetSliderModel.fromJson(json.decode(result));
//       print("this is a response===========>${finalResult}");
//       setState(() {
//         _sliderModel = finalResult;
//       });
//     } else {
//       print(response.reasonPhrase);
//     }
//   }
//
//   void initState() {
//     super.initState();
//     print("this is my speiality  ${widget.speciality}");
//     Future.delayed(Duration(milliseconds: 300), () {
//       return getSliderApi();
//     });
//     getSliderApi();
//     getCategory();
//     if(widget.speciality == true){
//       setState(() {
//       });
//     }
//   }
//
//   final GlobalKey<RefreshIndicatorState> _refreshIndicatorKey =
//       new GlobalKey<RefreshIndicatorState>();
//   Future<Null> _refresh() {
//     return callApi();
//   }
//
//   Future<Null> callApi() async {
//      // getuserProfile();
//     getSliderApi();
//
//   }
//
//   GetcategoryModel? getcategoryModel;
//   getCategory() async {
//     print("Get category APiiii");
//     var headers = {
//       'Cookie': 'ci_session=967018c55118c57e9b50bc9d10a91f021f6744e1'
//     };
//     var request = http.MultipartRequest('POST', Uri.parse('${ApiService.categories}'));
//
//     request.headers.addAll(headers);
//     http.StreamedResponse response = await request.send();
//     if (response.statusCode == 200) {
//       var  result = await response.stream.bytesToString();
//       var finalResult = GetcategoryModel.fromJson(jsonDecode(result));
//       if(finalResult.status == true){
//       }else{
//         // Navigator.push(context, MaterialPageRoute(builder: (context)=>SubscriptionPlan()));
//       }
//       print('category Apiii Responsee______${finalResult}');
//       setState(() {
//         getcategoryModel =  finalResult ;
//       });
//     }
//     else {
//     print(response.reasonPhrase);
//     }
//   }
//
//   CheckPlanModel? checkPlanModel;
//   checkSubscriptionApi() async {
//     SharedPreferences preferences = await SharedPreferences.getInstance();
//     String? userId = preferences.getString('userId');
//     String? role = preferences.getString('roll');
//     print('__________${role}_________');
//     var headers = {
//       'Cookie': 'ci_session=64caa747045713fca2e42eb930c7387e303fd583'
//     };
//     var request = http.MultipartRequest('POST', Uri.parse('${ApiService.getCheckSubscriptionApi}'));
//     request.fields.addAll({
//       'user_id': "$userId",
//       'type':role =="1" ?"doctor":'pharma'
//     });
//     print('___sadsfdsfsdfsdafgsdgdg_______${request.fields}_________');
//     request.headers.addAll(headers);
//
//     http.StreamedResponse response = await request.send();
//
//     if (response.statusCode == 200) {
//      var  result = await response.stream.bytesToString();
//      var finalResult = CheckPlanModel.fromJson(jsonDecode(result));
//      if(finalResult.status == true){
//        Navigator.push(context, MaterialPageRoute(builder: (context)=>AddPosterScreen()));
//      }else{
//        Navigator.push(context, MaterialPageRoute(builder: (context)=>SubscriptionPlan()));
//      }
//      print('____Bew Api______${finalResult}_________');
//      setState(() {
//       checkPlanModel =  finalResult ;
//      });
//     }
//     else {
//     print(response.reasonPhrase);
//     }
//   }
//
//   setFilterDataId( String id) async{
//     SharedPreferences preferences = await SharedPreferences.getInstance();
//     preferences.setString('LocalId', id );
//   }
//   @override
//   Widget build(BuildContext context) {
//     return WillPopScope(
//       onWillPop: () async {
//         showDialog(
//             context: context,
//             barrierDismissible: false,
//             builder: (BuildContext context) {
//               return AlertDialog(
//                 title: Text("Confirm Exit"),
//                 content: Text("Are you sure you want to exit?"),
//                 actions: <Widget>[
//                   ElevatedButton(
//                     style: ElevatedButton.styleFrom(primary: colors.primary),
//                     child: Text("YES"),
//                     onPressed: () {
//                       SystemNavigator.pop();
//                     },
//                   ),
//                   ElevatedButton(
//                     style: ElevatedButton.styleFrom(primary: colors.primary),
//                     child: Text("NO"),
//                     onPressed: () {
//                       Navigator.of(context).pop();
//                     },
//                   )
//                 ],
//               );
//             });
//         return true;
//       },
//       child: RefreshIndicator(
//         key: _refreshIndicatorKey,
//         onRefresh: _refresh,
//         child: Scaffold(
//           backgroundColor: colors.whiteScaffold,
//           key: _key,
//           //appBar: customAppBar(context: context, text: "My Dashboard", isTrue: true, ),
//           body: SingleChildScrollView(
//             child: SafeArea(
//               child: Column(
//                 children: [
//                   SizedBox(height: 10),
//                   Stack(
//                     alignment: Alignment.bottomCenter,
//                     children: [
//                       SizedBox(
//                         //height: 200,
//                         width: double.maxFinite,
//                         child: _sliderModel == null
//                             ? const Center(
//                                 child: CircularProgressIndicator(
//                                 color: colors.primary,
//                               ))
//                             : _CarouselSlider1(),
//                       ),
//                       Positioned(
//                         bottom: 20,
//                         // left: 80,
//                         child: Row(
//                           mainAxisAlignment: MainAxisAlignment.center,
//                           children: _buildDots(),
//                         ),
//                       ),
//                     ],
//                   ),
//                   const SizedBox(
//                     height: 10,
//                   ),
//                   Text("Categories",style: TextStyle(fontSize: 15, fontWeight: FontWeight.w600, color: colors.primary),),
//                   SizedBox(height: 10,),
//                   customTabbar()
//                   // SizedBox(height: 100,),
//                 ],
//               ),
//             ),
//           ),
//         ),
//       ),
//     );
//   }
//
//   int _currentPost = 0;
//
//   List<Widget> _buildDots() {
//     List<Widget> dots = [];
//     if (_sliderModel == null) {
//     } else {
//       for (int i = 0; i < _sliderModel!.data!.length; i++) {
//         dots.add(
//           Container(
//             margin: EdgeInsets.all(1.5),
//             width: 6,
//             height: 6,
//             decoration: BoxDecoration(
//               shape: BoxShape.circle,
//               color: _currentPost == i ? colors.secondary : colors.primary,
//             ),
//           ),
//         );
//       }
//     }
//     return dots;
//   }
//
//   int _currentIndex = 1;
//
//   customTabbar(){
//     return
//       Container(
//         height: 800,
//         child: GridView.builder(
//           scrollDirection: Axis.vertical,
//           itemCount: getcategoryModel?.data?.length,
//           gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
//             childAspectRatio: 8/7.9,
//             crossAxisCount: 2,
//           ),
//           itemBuilder: (BuildContext context, int index) {
//             return InkWell(
//               onTap: () {
//                 Navigator.push(context, MaterialPageRoute(builder: (context) => TemplateScreen()));
//               },
//               child: Padding(
//                 padding: EdgeInsets.all(1),
//                 child: Card(
//                   color: Colors.white,
//                   elevation: 5,
//                   semanticContainer: true,
//                   shape: RoundedRectangleBorder(
//                     borderRadius: BorderRadius.circular(5.0),
//                     side: BorderSide(color: Colors.black, width: 2),
//                   ),
//                   // clipBehavior: Clip.antiAlias,
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     mainAxisAlignment: MainAxisAlignment.start,
//                     children: <Widget>[
//                       Stack(
//                         children: [
//                           Container(
//                               height: 120,
//                               width: MediaQuery.of(context).size.width/1.7,
//                               child: Image.network("${getcategoryModel?.data?[index].img}", height: 80, width: 50, fit: BoxFit.fill,)
//                           ),
//                           Padding(
//                             padding: const EdgeInsets.only(top: 100),
//                             child: Container(
//                               height: 20,
//                               decoration: BoxDecoration(borderRadius: BorderRadius.circular(2), color: Colors.black38),
//                               child: Row(
//                                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                                 children: [
//                                 ],
//                               ),
//                             ),
//                           ),
//                         ],
//                       ),
//                       // SizedBox(height: 5),
//                       Row(
//                         // mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                         children: [
//                           Padding(
//                             padding: const EdgeInsets.only(left: 50, top: 10),
//                             child: Center(
//                               child: Text("${getcategoryModel?.data?[index].cName}"
//                                   ,style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold,fontSize: 10, fontFamily: 'Afrah')
//                               ),
//                             ),
//                           ),
//                         ],
//                       ),
//                     ],
//                   ),
//                 ),
//               ),
//             );
//           },
//         ),
//       );
//   }
// }

import 'dart:convert';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:doctorapp/Helper/Color.dart';
import 'package:doctorapp/Screen/Histroy.dart';
import 'package:doctorapp/api/api_services.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import '../New_model/Check_plan_model.dart';
import '../New_model/GetCountingModel.dart';
import '../New_model/GetSelectCatModel.dart';
import '../New_model/GetSliderModel.dart';
import '../SubscriptionPlan/addPosterScreen.dart';
import '../SubscriptionPlan/subscription_plan.dart';
import '../widgets/widgets/commen_slider.dart';
import 'Events.dart';
import 'TemplateScreen.dart';
import 'WishlistScreen.dart';

class HomeScreen extends StatefulWidget {
  final bool? speciality;
  const HomeScreen({
    Key? key, this.speciality
  }) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final GlobalKey<ScaffoldState> _key = GlobalKey();
  SpeciplyData? localFilter;
  int currentindex = 0;

  // GetUserProfileModel? getprofile;
  // getuserProfile() async {
  //   SharedPreferences preferences = await SharedPreferences.getInstance();
  //   String? userId = preferences.getString('userId');
  //   print("getProfile--------------->${userId}");
  //   var headers = {
  //     'Cookie': 'ci_session=d9075fff59f39b7a82c03ca267be8899c1a9fbf8'
  //   };
  //   var request = http.MultipartRequest(
  //       'POST', Uri.parse('${ApiService.getUserProfile}'));
  //   request.fields.addAll({'user_id': '$userId'});
  //   print("getProfile--------------->${request.fields}");
  //   request.headers.addAll(headers);
  //
  //   http.StreamedResponse response = await request.send();
  //
  //   if (response.statusCode == 200) {
  //     var finalResult = await response.stream.bytesToString();
  //     final jsonResponse =
  //         GetUserProfileModel.fromJson(json.decode(finalResult));
  //     print("this is a ========>profile${jsonResponse}");
  //     print("emailllllll${getprofile?.user?.mobile}");
  //     setState(() {
  //       getprofile = jsonResponse;
  //     });
  //   } else {
  //     print(response.reasonPhrase);
  //   }
  // }

  // GetSelectCatModel? selectCatModel;
  // getCatApi() async {
  //   SharedPreferences preferences = await SharedPreferences.getInstance();
  //   String? Roll = preferences.getString('roll');
  //   String? userId = preferences.getString('userId');
  //   print("getRoll--------------->${Roll}");
  //
  //   var headers = {
  //     'Cookie': 'ci_session=742f7d5e34b7f410d122da02dbbe7e75f06cadc8'
  //   };
  //   var request = http.MultipartRequest(
  //       'POST', Uri.parse('${ApiService.selectCategory}'));
  //   request.fields.addAll({'roll': '1', 'cat_type': "2", 'user_id': '$userId'});
  //   print("this is a Response==========>${request.fields}");
  //   request.headers.addAll(headers);
  //   http.StreamedResponse response = await request.send();
  //   if (response.statusCode == 200) {
  //     //preferences.setString('id', "Id");
  //     final result = await response.stream.bytesToString();
  //     final finalResult = GetSelectCatModel.fromJson(jsonDecode(result));
  //     print('_____Surendra _____${finalResult}_________');
  //
  //     setState(() {
  //       selectCatModel = finalResult;
  //     });
  //   } else {
  //     print(response.reasonPhrase);
  //   }
  // }

  _CarouselSlider1() {
    return CarouselSlider(
      options: CarouselOptions(
          onPageChanged: (index, result) {
            setState(() {
              _currentPost = index;
            });
          },
          viewportFraction: 1.0,
          initialPage: 0,
          enableInfiniteScroll: true,
          reverse: false,
          autoPlay: true,
          autoPlayInterval: Duration(seconds: 5),
          autoPlayAnimationDuration: Duration(milliseconds: 500),
          enlargeCenterPage: false,
          scrollDirection: Axis.horizontal,
          height: 180.0),
         items: _sliderModel?.data?.map((item) {
        return Container(
            width: MediaQuery.of(context).size.width/1.1,
            decoration: BoxDecoration(
                borderRadius:
                BorderRadius.circular(20)),
            child: CommonSlider(file: item.image ?? '',));
      }).toList(),
    );
  }

  GetSliderModel? _sliderModel;
  getSliderApi() async {
    var headers = {
      'Cookie': 'ci_session=ccb37a117d31b04c006884a89fbff3d1a39bffd7'
    };
    var request = http.Request('GET', Uri.parse('${ApiService.getSlider}'));
    request.headers.addAll(headers);
    http.StreamedResponse response = await request.send();
    if (response.statusCode == 200) {
      var result = await response.stream.bytesToString();
      print("this is a response===========>${result}");
      final finalResult = GetSliderModel.fromJson(json.decode(result));
      print("this is a response===========>${finalResult}");
      setState(() {
        _sliderModel = finalResult;
      });
    } else {
      print(response.reasonPhrase);
    }

  }

  void initState() {
    super.initState();
    print("this is my speiality  ${widget.speciality}");
    Future.delayed(Duration(milliseconds: 300), () {
      return getSliderApi();
    });
    getSliderApi();
    if(widget.speciality == true){
      setState(() {

      });
    }
  }

  final GlobalKey<RefreshIndicatorState> _refreshIndicatorKey =
  new GlobalKey<RefreshIndicatorState>();
  Future<Null> _refresh() {
    return callApi();
  }
  Future<Null> callApi() async {
    // getuserProfile();
    getSliderApi();

  }
  CheckPlanModel? checkPlanModel;
  checkSubscriptionApi() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String? userId = preferences.getString('userId');
    String? role = preferences.getString('roll');
    print('__________${role}_________');
    var headers = {
      'Cookie': 'ci_session=64caa747045713fca2e42eb930c7387e303fd583'
    };
    var request = http.MultipartRequest('POST', Uri.parse('${ApiService.getCheckSubscriptionApi}'));
    request.fields.addAll({
      'user_id': "$userId",
      'type':role =="1" ?"doctor":'pharma'
    });
    print('___sadsfdsfsdfsdafgsdgdg_______${request.fields}_________');
    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      var  result = await response.stream.bytesToString();
      var finalResult = CheckPlanModel.fromJson(jsonDecode(result));
      if(finalResult.status == true){
        Navigator.push(context, MaterialPageRoute(builder: (context)=>AddPosterScreen()));
      }else{
        Navigator.push(context, MaterialPageRoute(builder: (context)=>SubscriptionPlan()));
      }
      print('____Bew Api______${finalResult}_________');
      setState(() {
        checkPlanModel =  finalResult ;
      });
    }
    else {
      print(response.reasonPhrase);
    }

  }
  setFilterDataId( String id) async{
    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.setString('LocalId', id );
  }
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        showDialog(
            context: context,
            barrierDismissible: false,
            builder: (BuildContext context) {
              return AlertDialog(
                title: Text("Confirm Exit"),
                content: Text("Are you sure you want to exit?"),
                actions: <Widget>[
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(primary: colors.primary),
                    child: Text("YES"),
                    onPressed: () {
                      SystemNavigator.pop();
                    },
                  ),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(primary: colors.primary),
                    child: Text("NO"),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  )
                ],
              );
            });
        return true;
      },
      child: RefreshIndicator(
        key: _refreshIndicatorKey,
        onRefresh: _refresh,
        child: Scaffold(
          backgroundColor: colors.whiteScaffold,
          key: _key,
          //appBar: customAppBar(context: context, text:"My Dashboard", isTrue: true, ),
          body: SafeArea(
            child: Column(
              children: [
                SizedBox(height: 20,),
                Stack(
                  alignment: Alignment.bottomCenter,
                  children: [
                    SizedBox(
                      //height: 200,
                      width: double.maxFinite,
                      child: _sliderModel == null
                          ? const Center(
                          child: CircularProgressIndicator(
                            color: colors.primary,
                          ))
                          : _CarouselSlider1(),
                    ),
                    Positioned(
                     top: 170,
                      // left: 80,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: _buildDots(),
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 15,
                ),
                customTabbar()
                // SizedBox(height: 100,),
              ],
            ),
          ),
        ),
      ),
    );
  }

  int _currentPost = 0;
  List<Widget> _buildDots() {
    List<Widget> dots = [];
    if (_sliderModel == null) {
    } else {
      for (int i = 0; i < _sliderModel!.data!.length; i++) {
        dots.add(
          Container(
            margin: EdgeInsets.all(1.5),
            width: 10,
            height: 10,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: _currentPost == i ? Colors.white : Colors.black,
            ),
          ),
        );
      }
    }
    return dots;
  }

  int _currentIndex = 1;

  customTabbar(){
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            height: 180,
            child: InkWell(
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => TemplateScreen()));
              },
              child: Padding(
                padding: EdgeInsets.all(1),
                child: Card(
                  color: Colors.white,
                  elevation: 5,
                  semanticContainer: true,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5.0),
                    // side: BorderSide(color: Colors.black, width: 2),
                  ),
                  // clipBehavior: Clip.antiAlias,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      Stack(
                        children: [
                          Container(
                              height: 130,
                              width: MediaQuery.of(context).size.width/2.3,
                              child: Image.asset("assets/images/invitation1.jpg", fit: BoxFit.fill,)
                              // Image.network("${getcategoryModel?.data?[index].img}", height: 80, width: 50, fit: BoxFit.fill,)
                          ),
                        ],
                      ),
                      // SizedBox(height: 5),
                      Row(
                        // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: const [
                          Padding(
                            padding: EdgeInsets.only(left: 55, top: 10),
                            child: Center(
                              child: Text("Card"
                                  ,style: TextStyle( color: Colors.black,fontWeight: FontWeight.bold,fontSize: 16, fontFamily: 'Afrah')
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          SizedBox(width: 1),
          Container(
            height: 180,
            child: InkWell(
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => EventScreen()));
              },
              child: Padding(
                padding: EdgeInsets.all(1),
                child: Card(
                  color: Colors.white,
                  elevation: 5,
                  semanticContainer: true,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5.0),
                    // side: BorderSide(color: Colors.black, width: 2),
                  ),
                  // clipBehavior: Clip.antiAlias,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      Stack(
                        children: [
                          Container(
                              height: 130,
                              width: MediaQuery.of(context).size.width/2.4,
                              child: Image.asset("assets/images/invitation1.png", fit: BoxFit.fill)
                            // Image.network("${getcategoryModel?.data?[index].img}", height: 80, width: 50, fit: BoxFit.fill,)
                          ),
                        ],
                      ),
                      // SizedBox(height: 5),
                      Row(
                        // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(left: 55, top: 10),
                            child: Center(
                              child: Text("Events", style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold,fontSize: 16, fontFamily: 'Afrah')
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

