import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../Helper/Appbar.dart';
import '../Helper/Color.dart';

class ServiceScreen extends StatefulWidget {
  const ServiceScreen({Key? key}) : super(key: key);

  @override
  State<ServiceScreen> createState() => _ServiceScreenState();
}

class _ServiceScreenState extends State<ServiceScreen> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController emailController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController phonelController = TextEditingController();
  TextEditingController mobileController = TextEditingController();
  String dropdownvalue = 'Model 1';

  // List of items in our dropdown menu
  var items = [
    'Model 1',
    'Model 2',
    'Model 3',
    'Model 4',
    'Model 5',
  ];

  List<String> timeList = [
    '11:00 - 11:30',
    '11:30 - 12:00',
    "12:00 - 12:30",
    "12:30 - 1:00",
  ];

  String selectedTime = '';
  @override
  Widget build(BuildContext context) {

    return  SafeArea(
      child: Scaffold(
        appBar: customAppBar(context: context, text:"Service", isTrue: true, ),
        body: Form(
          key: _formKey,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                Padding(
                    padding: EdgeInsets.all(5.0),
                    child:Row(
                      children: [
                        Text(
                          "Name",
                          style: TextStyle(
                              color: colors.black54, fontWeight: FontWeight.bold),
                        ),
                        Text(
                          "*",
                          style: TextStyle(
                              color: colors.red, fontWeight: FontWeight.bold,fontSize: 10),
                        ),
                      ],
                    )


                ),
                TextFormField(
                  style: TextStyle(color: colors.black54),
                  controller: nameController,
                  keyboardType: TextInputType.text,
                  decoration: InputDecoration(
                      prefixText: "",
                      hintText: 'Enter Name',
                      hintStyle: const TextStyle(
                          fontSize: 15.0, color: colors.primary,fontWeight: FontWeight.normal),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10)),
                      contentPadding: EdgeInsets.only(left: 10, top: 10)),
                  validator: (v) {
                    if (v!.isEmpty) {
                      return "name is required";
                    }
                  },
                ),
                SizedBox(height: 10,),
                Padding(
                    padding: const EdgeInsets.all(5.0),
                    child:Row(
                      children: [
                        const Text(
                          "Mobile No",
                          style: TextStyle(
                              color: colors.black54, fontWeight: FontWeight.bold),
                        ),
                        const Text(
                          "*",
                          style: TextStyle(
                              color: colors.red, fontWeight: FontWeight.bold,fontSize: 10),
                        ),
                      ],
                    )
                ),
                TextFormField(
                  style: TextStyle(color: colors.black54),
                  controller: mobileController,
                  keyboardType: TextInputType.number,
                  maxLength: 10,
                  decoration: InputDecoration(
                      counterText: "",
                      hintText: 'Enter Mobile',
                      hintStyle:
                      TextStyle(fontSize: 15.0, color: colors.secondary),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10)),
                      contentPadding: EdgeInsets.only(left: 10, top: 10)),
                  validator: (v) {
                    if (v!.length != 10) {
                      return "mobile number is required";
                    }
                  },
                ),
                SizedBox(
                  height: 10,
                ),
                Padding(
                    padding: EdgeInsets.all(5.0),
                    child:Row(
                      children: [
                        Text(
                          "Address",
                          style: TextStyle(
                              color: colors.black54, fontWeight: FontWeight.bold),
                        ),
                        Text(
                          "*",
                          style: TextStyle(
                              color: colors.red, fontWeight: FontWeight.bold,fontSize: 10),
                        ),
                      ],
                    )


                ),
                TextFormField(
                  style: TextStyle(color: colors.black54),
                  controller: nameController,
                  keyboardType: TextInputType.text,
                  decoration: InputDecoration(
                      prefixText: "",
                      hintText: 'Enter Address',
                      hintStyle: const TextStyle(
                          fontSize: 15.0, color: colors.primary,fontWeight: FontWeight.normal),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10)),
                      contentPadding: EdgeInsets.only(left: 10, top: 10)),
                  validator: (v) {
                    if (v!.isEmpty) {
                      return "address is required";
                    }
                  },
                ),
                SizedBox(height: 10,),
                Padding(
                    padding: EdgeInsets.all(5.0),
                    child:Row(
                      children: [
                        Text(
                          "Model",
                          style: TextStyle(
                              color: colors.black54, fontWeight: FontWeight.bold),
                        ),
                        Text(
                          "*",
                          style: TextStyle(
                              color: colors.red, fontWeight: FontWeight.bold,fontSize: 10),
                        ),
                      ],
                    )


                ),
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(color: colors.black54,)
                  ),
                  child: DropdownButtonHideUnderline(
                    child: DropdownButton2(
                      isExpanded: true,
                      value: dropdownvalue,
                      icon: Padding(
                        padding: EdgeInsets.only(right: 10),
                          child: const Icon(Icons.keyboard_arrow_down,color: colors.primary)),
                      items: items.map((String items) {
                        return DropdownMenuItem(
                          value: items,
                          child: Text(items,style: TextStyle(color: colors.primary),),
                        );
                      }).toList(),
                      onChanged: (String? newValue) {
                        setState(() {
                          dropdownvalue = newValue!;
                        });
                      },
                    ),
                  ),
                ),
                SizedBox(height: 10,),
                Padding(
                    padding: EdgeInsets.all(5.0),
                    child:Row(
                      children: [
                        Text(
                          "Time",
                          style: TextStyle(
                              color: colors.black54, fontWeight: FontWeight.bold),
                        ),
                        Text(
                          "*",
                          style: TextStyle(
                              color: colors.red, fontWeight: FontWeight.bold,fontSize: 10),
                        ),
                      ],
                    )


                ),
                Container(
                  height: 50,
                  width: MediaQuery.of(context).size.width,
                  child: ListView.builder(
                      shrinkWrap: true,
                      itemCount: timeList.length,
                      physics: ScrollPhysics(),
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (c,i){
                    return InkWell(
                      onTap: (){
                        setState(() {
                          selectedTime = timeList[i];
                        });
                        print("selected time here  ${selectedTime}");
                      },
                      child: Container(
                      alignment: Alignment.center,
                        padding: EdgeInsets.symmetric(horizontal: 5),
                        margin: EdgeInsets.only(right: 10),
                        decoration: BoxDecoration(
                          border: Border.all(color: selectedTime == timeList[i] ? colors.primary : Colors.black,
                          width: selectedTime == timeList[i] ? 2 :1
                          ),
                          borderRadius: BorderRadius.circular(9),
                        ),
                        child: Text("${timeList[i]}",),
                      ),
                    );
                  }),
                ),
                SizedBox(height: 50,),
                InkWell(
                  onTap: (){
                    if(_formKey.currentState!.validate()){
                      
                    }
                    else{
                      Fluttertoast.showToast(msg: "All Field are required");
                    }
                  },
                  child: Container(
                    
                    height: 45,
                    decoration: BoxDecoration(
                      color: colors.primary,
                        borderRadius: BorderRadius.circular(10)),
                    child: Center(
                      child:Text("Submit",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,color: colors.whiteTemp,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
