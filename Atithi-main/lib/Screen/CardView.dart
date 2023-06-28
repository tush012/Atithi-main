import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart'as http;
import 'dart:ui' as ui;
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';
import 'package:share_plus/share_plus.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../Helper/Color.dart';
import '../New_model/GetEnquiryModel.dart';
import '../New_model/SaveMyCardModel.dart';
import '../New_model/SavedCardModel.dart';
import '../api/api_services.dart';

class CardView extends StatefulWidget {
  final String? image;
  const CardView({Key? key, this.image}) : super(key: key);

  @override
  State<CardView> createState() => _CardViewState();
}

class _CardViewState extends State<CardView> {


  Razorpay? _razorpay;
  int? pricerazorpayy;

  Future<Null> refreshFunction()async{
    await  Future.delayed(Duration(milliseconds: 300),(){
      return saveCard();
    });
  }

  @override
  void initState() {
    super.initState();
    _razorpay = Razorpay();
    _razorpay?.on(Razorpay.EVENT_PAYMENT_SUCCESS, _handlePaymentSuccess);
    _razorpay?.on(Razorpay.EVENT_PAYMENT_ERROR, _handlePaymentError);
    _razorpay?.on(Razorpay.EVENT_EXTERNAL_WALLET, _handleExternalWallet);
    Future.delayed(Duration(milliseconds: 200),(){
      return saveCard();
    });
  }

  Future<void> _handlePaymentSuccess(PaymentSuccessResponse response) async {
    Fluttertoast.showToast(msg: "Subscription added successfully");
    purchaseCard();
    // Navigator.push(context, MaterialPageRoute(builder: (context)=>HomeScreen()));
  }

  void _handlePaymentError(PaymentFailureResponse response) {
    Fluttertoast.showToast(msg: "Payment cancelled by user");
  }

  void _handleExternalWallet(ExternalWalletResponse response) {
  }

  GlobalKey keyList = GlobalKey();
  String? card_id;

   SaveMyCardModel? saveMyCardModel;
   saveCard() async{
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String? userId = preferences.getString('userId');
    String? template_id = preferences.getString('template_id');
    var headers = {
      'Cookie': 'ci_session=79b222a1b7a3dc18c150b1366e8f9ceb03aaa932'
    };
    var request = http.MultipartRequest('POST', Uri.parse('${ApiService.savemycard}'));
    request.fields.addAll({
      'user_id': '$userId',
      'template_id': '$template_id'
    });
    request.files.add(await http.MultipartFile.fromPath('image', '${widget.image}'));
    print("save Cardddd parameterrrrr${request.fields}");
    request.headers.addAll(headers);
    http.StreamedResponse response = await request.send();
    if (response.statusCode == 200) {
      var finalResponse = await response.stream.bytesToString();
      final jsonResponse = SaveMyCardModel.fromJson(json.decode(finalResponse));
      String? card_id = jsonResponse.data?.first.id ??"";
      setState(() {
        saveMyCardModel =  jsonResponse;
      });
      preferences.setString("card_id", card_id);
     print("carddddd idddd isssss ${card_id}");
    }
    else {
      print(response.reasonPhrase);
    }
  }



  // save() async {
  //   var status =  await Permission.photos.request();
  //   if (/*storagePermission == PermissionStatus.granted*/ status.isGranted) {
  //     final directory = (await getApplicationDocumentsDirectory()).path;
  //     RenderRepaintBoundary bound = keyList.currentContext!.findRenderObject() as RenderRepaintBoundary;
  //     ui.Image image = await bound.toImage();
  //     ByteData? byteData = await image.toByteData(format: ui.ImageByteFormat.png);
  //     print('${byteData?.buffer.lengthInBytes}___________');
  //     // this will save image screenshot in gallery
  //     if(byteData != null){
  //       Uint8List pngBytes = byteData.buffer.asUint8List();
  //       String fileName = DateTime.now().microsecondsSinceEpoch.toString();
  //       final imagePath = await File('$directory/$fileName.png').create();
  //       await imagePath.writeAsBytes(pngBytes);
  //       // Share.shareFiles([imagePath.path]);
  //       saveCard(imagePath.path.toString());
  //     }
  //   } else if (await status.isDenied) {
  //     ScaffoldMessenger.of(context).showSnackBar(
  //         SnackBar(content: Text('This Permission is recommended')));
  //   } else if (await status.isPermanentlyDenied/*storagePermission == PermissionStatus.permanentlyDenied*/) {
  //     openAppSettings().then((value) {
  //     });
  //   }
  // }

  void openCheckout(amount) async {
    double res = double.parse(amount.toString());
    pricerazorpayy= int.parse(res.toStringAsFixed(0)) * 100;
    print("checking razorpay price ${pricerazorpayy.toString()}");
    print("checking razorpay price ${pricerazorpayy.toString()}");
    // Navigator.of(context).pop();
    var options = {
      'key': 'rzp_test_1DP5mmOlF5G5ag',
      'amount': "${pricerazorpayy}",
      'name': 'Invitation',
      'image':'assets/images/homeimage.png',
      'description': 'Invitation',
    };
    try {
      _razorpay?.open(options);
    } catch (e) {
      debugPrint('Error: e');
    }
  }


  Future<ui.Image?> captureImage() async {
    try {
      RenderRepaintBoundary boundary = keyList.currentContext!.findRenderObject() as RenderRepaintBoundary;
      ui.Image image = await boundary.toImage(pixelRatio: 3.0);
      return image;
    } catch (exception) {
      print(exception);
      return null;
    }
  }

  void saveImage() async {
    print("Download Functionnnnnn");
    ui.Image? image = await captureImage();
    if (image != null) {
      final directory = (await getApplicationDocumentsDirectory()).path;
      ByteData? byteData = await image.toByteData(format: ui.ImageByteFormat.png);
      Uint8List pngBytes = byteData!.buffer.asUint8List();
      String fileName = DateTime.now().microsecondsSinceEpoch.toString();
      final file = await File('$directory/$fileName.png').create();
      await file.writeAsBytes(pngBytes);
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Card Download Successfully')));
      print('Image saved in this destination: ${file.path}');
    }
  }

  _share() async {
    var status =  await Permission.photos.request();
    if (/*storagePermission == PermissionStatus.granted*/ status.isGranted) {
      final directory = (await getApplicationDocumentsDirectory()).path;
      RenderRepaintBoundary bound = keyList.currentContext!.findRenderObject() as RenderRepaintBoundary;
      ui.Image image = await bound.toImage();
      ByteData? byteData = await image.toByteData(format: ui.ImageByteFormat.png);
      print('${byteData?.buffer.lengthInBytes}_________');
      // this will save image screenshot in gallery
      if(byteData != null){
        Uint8List pngBytes = byteData.buffer.asUint8List();
        String fileName = DateTime.now().microsecondsSinceEpoch.toString();
        final imagePath = await File('$directory/$fileName.png').create();
        await imagePath.writeAsBytes(pngBytes);
        Share.shareFiles([imagePath.path]);
      }
    } else if (await status.isDenied) {
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('This Permission is recommended')));
    } else if (await status.isPermanentlyDenied/*storagePermission == PermissionStatus.permanentlyDenied*/) {
      openAppSettings().then((value) {
      });
    }
  }

  purchaseCard() async{
     SharedPreferences preferences = await SharedPreferences.getInstance();
     preferences.getString("card_id");
     print("Purchase Paymnet Apiiii ${card_id}");
    var headers = {
      'Cookie': 'ci_session=094101f2118b81b6d7797c1b01164b0b63d14708'
    };
    var request = http.MultipartRequest('POST', Uri.parse('${ApiService.purchasepayment}'));
    request.fields.addAll({
      'id': '${card_id.toString()}',
      'transaction_id': 'rzp_test_1DP5mmOlF5G5ag'
    });
     print("Purchase parameter ${request.fields}");
    request.headers.addAll(headers);
    http.StreamedResponse response = await request.send();
    if (response.statusCode == 200) {
      print(await response.stream.bytesToString());
      setState(() {
        areTextFieldsVisible = true;
      });
    }
    else {
      print(response.reasonPhrase);
    }
  }

  bool areTextFieldsVisible = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: colors.primary,
        centerTitle: true,
          title: Text("Card View")
      ),
        body: SingleChildScrollView(
          child: RefreshIndicator(
         onRefresh: refreshFunction,
         child: Column(
          children: [
            SizedBox(height:2),
            RepaintBoundary(
              key: keyList,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  height: MediaQuery.of(context).size.height/1.8,
                  width: MediaQuery.of(context).size.width/1.1,
                  child: Card(
                    elevation: 5,
                    child: Image.network("${saveMyCardModel?.data?[0].image}", fit: BoxFit.fill,),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("Card Price:", style: TextStyle(fontWeight: FontWeight.w500, fontSize: 15, color: Colors.black, decoration: TextDecoration.underline,)),
                  Text("₹ ${saveMyCardModel?.data?[0].price}", style: TextStyle(fontWeight: FontWeight.w500, fontSize: 15, color: Colors.black, decoration: TextDecoration.underline,))
                ],
              ),
            ),
            SizedBox(height: MediaQuery.of(context).size.height/11.9),
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                height: 40,
                width: MediaQuery.of(context).size.width/1.1,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(backgroundColor: colors.primary),
                  onPressed:(){
                    openCheckout(saveMyCardModel?.data?[0].price);
                    setState(() {
                     // areTextFieldsVisible = !areTextFieldsVisible;
                    });
                    // Fluttertoast.showToast(msg: "Enquiry submit successfully");
                    // Navigator.push(context, MaterialPageRoute(builder: (context) => EnquiryForm()));
                  },
                  child: const Text("Pay Now",style: TextStyle(fontSize: 15)
                  ),
                ),
              ),
            ),
            Visibility(
              visible: areTextFieldsVisible,
              child:
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
                child: Row(
                  // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text("Share", style: TextStyle(fontSize: 14, fontWeight: FontWeight.w800)),
                    const SizedBox(width: 5),
                    Container(
                      height: 45,
                      width: 45,
                      decoration: BoxDecoration(borderRadius: BorderRadius.circular(10), color: colors.primary),
                      child: IconButton(
                          onPressed: () {
                            // setState(() {
                            // });
                            _share();
                          },
                          icon: const Icon(Icons.share, color: Colors.white)),
                    ),
                    SizedBox(width: MediaQuery.of(context).size.width/3),
                    Text("Download", style: TextStyle(fontSize: 14, fontWeight: FontWeight.w800)),
                    SizedBox(width: 5),
                    Container(
                      height: 45,
                      width: 45,
                      decoration: BoxDecoration(borderRadius: BorderRadius.circular(10), color: colors.primary),
                      child: IconButton(
                          onPressed:() async {
                            saveImage();
                            // downloadFile();
                          },
                          icon: const Icon(Icons.download, color: Colors.white),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
      ))),
    );
  }
}
