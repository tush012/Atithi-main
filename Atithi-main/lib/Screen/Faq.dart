import 'dart:convert';
import 'package:doctorapp/New_model/FaqModel.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../Helper/Color.dart';
import '../api/api_services.dart';

class FaqScreen extends StatefulWidget {
  const FaqScreen({Key? key}) : super(key: key);

  @override
  State<FaqScreen> createState() => _FaqScreenState();
}

class _FaqScreenState extends State<FaqScreen> {
  ScrollController controller = new ScrollController();
  bool flag = true;
  bool expand = true;
  int selectedIndex = -1;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    controller.addListener(_scrollListener);
  }

  _scrollListener() {
    if (controller.offset >= controller.position.maxScrollExtent &&
        !controller.position.outOfRange) {
      if (this.mounted) {
        if (mounted) setState(() {
          // isLoadingmore = true;
          getFaq();
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    // SizeConfig().init(context);
    return Scaffold(
      backgroundColor: Colors.white,
      appBar:AppBar(
        backgroundColor: colors.primary,
        elevation: 2,
        title: Text(
          "FAQ",
          style: TextStyle(
            fontSize: 20,
            color: Colors.white,
          ),
        ),
        centerTitle: true,
        leading:  Padding(
          padding: const EdgeInsets.all(12),
          child: RawMaterialButton(
            shape: CircleBorder(),
            padding: const EdgeInsets.all(0),
            fillColor: Colors.white,
            splashColor: Colors.grey[400],
            child: Icon(
              Icons.arrow_back,
              size: 20,
              color: Colors.black,
            ),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: FutureBuilder(
            future: getFaq(),
            builder: (BuildContext context, AsyncSnapshot snapshot) {
              FaqModel faqsList = snapshot.data;
              if (snapshot.hasData) {
                return ListView.builder(
                  controller: controller,
                  itemCount: faqsList.setting?.length,
                  shrinkWrap: true,
                  physics: BouncingScrollPhysics(),
                  itemBuilder: (context, index) {
                    return Card(
                        elevation: 1,
                        child: InkWell(
                          borderRadius: BorderRadius.circular(4),
                          onTap: () {
                            if (mounted) setState(() {
                              selectedIndex = index;
                              flag = !flag;
                            });
                          },
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Padding(
                                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                                      child: Text(
                                        faqsList.setting![index].title ?? "",
                                        style: TextStyle(
                                            color: Colors.black
                                        ),
                                      )),
                                  selectedIndex != index || flag
                                      ? Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    children: [
                                      Expanded(
                                          child: Padding(
                                              padding: const EdgeInsets.symmetric(
                                                  horizontal: 8.0),
                                              child: Text(
                                                faqsList.setting![index].description ?? "",
                                                style: TextStyle(
                                                    color: Colors.black
                                                ),
                                                maxLines: 1,
                                                overflow: TextOverflow.ellipsis,
                                              ))),
                                      // Icon(Icons.keyboard_arrow_down)
                                    ],
                                  )
                                      : Row(
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      children: [
                                        Expanded(
                                            child: Padding(
                                                padding: const EdgeInsets.symmetric(
                                                    horizontal: 8.0),
                                                child: Text(
                                                  faqsList.setting![index].description ?? "",
                                                  style: TextStyle(
                                                      color: Colors.black
                                                  ),
                                                ))),
                                        //Icon(Icons.keyboard_arrow_up)
                                      ]),
                                ]),
                          ),
                        ));
                  },
                );
              } else if (snapshot.hasError) {
                return Icon(Icons.error_outline);
              } else {
                return Center(child: CircularProgressIndicator());
              }
            }),
      ),
    );
  }


  Future getFaq() async {
    var request = http.Request('GET', Uri.parse('${ApiService.faq}'));

    http.StreamedResponse response = await request.send();
    print(request);
    print(response.statusCode);
    if (response.statusCode == 200) {
      final str = await response.stream.bytesToString();
      print(str);
      return FaqModel.fromJson(json.decode(str));
    }
    else {
      return null;
    }
  }
}
