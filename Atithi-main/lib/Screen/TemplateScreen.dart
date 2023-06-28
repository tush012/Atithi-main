import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import '../Helper/Color.dart';
import '../New_model/GetcategoryModel.dart';
import '../New_model/TemplateForm.dart';
import '../New_model/TemplatesModel.dart';
import '../api/api_services.dart';

class TemplateScreen extends StatefulWidget {
  const TemplateScreen({Key? key}) : super(key: key);

  @override
  State<TemplateScreen> createState() => _TemplateScreenState();
}

class _TemplateScreenState extends State<TemplateScreen> {

  @override
  void initState() {
    super.initState();
    //
    getCategory();
  }

  // File? imageShow;

  TemplatesModel? templatesModel;
  getTemplate() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    print("Get Template Apiiii");
    var headers = {
      'Cookie': 'ci_session=a36a8335f024c7b97f4162931f63227153359896'
    };
    var request = http.MultipartRequest('POST', Uri.parse('${ApiService.getservices}'));
    request.headers.addAll(headers);
    http.StreamedResponse response = await request.send();
    if (response.statusCode == 200) {
      var  result = await response.stream.bytesToString();
      final jsonResponse = TemplatesModel.fromJson(json.decode(result));
      String? template_id = jsonResponse.data?.first.id ?? "";
      preferences.setString("template_id", template_id);
      print("Temaplteeee Idddd ${template_id}");
      if(jsonResponse.responseCode == "1"){
      }else{
        // Navigator.push(context, MaterialPageRoute(builder: (context)=>SubscriptionPlan()));
      }
      print('Templateee Apiii Responsee______${jsonResponse}');
      setState(() {
        templatesModel =  jsonResponse;
      });
    }
    else {
      print(response.reasonPhrase);
    }
  }

  String? cat_id;
  GetcategoryModel? getcategoryModel;
  getCategory() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    print("Get category APiiii");
    var headers = {
      'Cookie': 'ci_session=967018c55118c57e9b50bc9d10a91f021f6744e1'
    };
    var request = http.MultipartRequest('POST', Uri.parse('${ApiService.categories}'));

    request.headers.addAll(headers);
    http.StreamedResponse response = await request.send();
    if (response.statusCode == 200) {
      var  result = await response.stream.bytesToString();
      var finalResult = GetcategoryModel.fromJson(jsonDecode(result));
      if(finalResult.status == true){
        String? cat_id = finalResult.data![0].id.toString();
        preferences.setString("cat_id", cat_id);
        print("Categoryyy iddd iss ${cat_id}");
      }else{
        // Navigator.push(context, MaterialPageRoute(builder: (context)=>SubscriptionPlan()));
      }
      print('category Apiii Responsee______${finalResult}');
      setState(() {
        getcategoryModel =  finalResult;
      });
    }
    else {
      print(response.reasonPhrase);
    }
  }


  final GlobalKey<RefreshIndicatorState> _refreshIndicatorKey =
  new GlobalKey<RefreshIndicatorState>();
  Future<Null> _refresh() {
    return callApi();
  }
  Future<Null> callApi() async {
    getTemplate();
    getCategory();

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        // automaticallyImplyLeading: false,
        centerTitle: true,
        backgroundColor: colors.primary,
        elevation: 0,
        title: Text("Templates"),
      ),
      body: RefreshIndicator(
        key: _refreshIndicatorKey,
        onRefresh: _refresh,
        child: SafeArea(
          child: Column(
            children: [
              const SizedBox(
                height: 5,
              ),
              customTabbar(),
              SizedBox(height: 15),
              templateView(),
            ],
          ),
        ),
      ),
    );
  }

  templateView() {
    print("mmmmmmmmmmmmm ${templatesModel}");
    return Container(
      height: 500,
      child: templatesModel == null ? Center(child: Text("No template to show"))  : GridView.builder(
        scrollDirection: Axis.vertical,
        itemCount: templatesModel?.data?.length,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          childAspectRatio: 9/7.9,
          crossAxisCount: 2,
        ),
        itemBuilder: (BuildContext context, int index) {
          return InkWell(
            onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => Form_Screen(image: templatesModel?.data?[index].image)));
            },
            child: Padding(
              padding: EdgeInsets.all(1),
              child: Card(
                color: Colors.white,
                elevation: 5,
                semanticContainer: true,
                // clipBehavior: Clip.antiAlias,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    Stack(
                      children: [
                        Container(
                            height: 148,
                            width: MediaQuery.of(context).size.width/1.7,
                            child: Image.network("${templatesModel?.data?[index].preview}", height: 80, width: 50, fit: BoxFit.fill)
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }


  int _currentIndex = 0;
  customTabbar(){
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
      height: 60,
      child: GridView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: getcategoryModel?.data?.length,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          childAspectRatio:3 /7,
          crossAxisCount: 1,
        ),
        itemBuilder: (BuildContext context, int index) {
          return InkWell(
            onTap: () {
              getcategoryModel?.data?.forEach((element) {element.select=false;});
              getcategoryModel?.data?[index].select=true;
              setState(() {
              });
              getTemplate();
              // Navigator.push(context, MaterialPageRoute(builder: (context) => GroceryDetails(id: foodCategoryModel!.product![index].id)));
            },
            child: Padding(
              padding: EdgeInsets.all(5),
              child: Card(
                color: getcategoryModel?.data?[index].select ?? false ?  colors.primary : Colors.white,
                // color: _currentIndex == 1 ? colors.primary: colors.secondary,
                elevation: 3,
                semanticContainer: true,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5.0),
                  side: BorderSide(
                      color:  colors.primary, width: 2
                  ),
                ),
                clipBehavior: Clip.antiAlias,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    SizedBox(height: 5),
                    Column(
                      // crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 3, top: 8),
                          child: Center(
                            child: getcategoryModel == null ? Center(child: Text("--")): Text("${getcategoryModel?.data?[index].cName}"
                                ,style: TextStyle(
                                    color: getcategoryModel?.data?[index].select ?? false ?  Colors.white : Colors.black,
                                    fontWeight: FontWeight.bold,fontSize: 11, fontFamily: 'Afrah')
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
      ),
    );
  }
}
