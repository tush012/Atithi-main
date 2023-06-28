import 'package:doctorapp/Helper/Color.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:place_picker/place_picker.dart';
import '../Helper/Constant.dart';
import '../Screen/CardScreen.dart';


class Form_Screen extends StatefulWidget {
  Form_Screen({Key? key, this.image}) : super(key: key);

  String? image;
  @override
  State<Form_Screen> createState() => _Form_ScreenState();
}

class _Form_ScreenState extends State<Form_Screen> {
  TextEditingController namectr = TextEditingController();
  TextEditingController addressCtr = TextEditingController();
  TextEditingController dateinput = TextEditingController();
  TextEditingController timecon = TextEditingController();

  @override
  final _formKey= GlobalKey<FormState>();
  String? selectedDate;
  var selectedTime=TimeOfDay.now();

  var selecttimee;
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        resizeToAvoidBottomInset : false,
        appBar: AppBar(
          elevation: 0,
          backgroundColor: colors.primary,
          centerTitle: true,
          title: Text("Birthday Form"),
        ),
        body:SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                height: 40,
              ),
              Card(
                margin: EdgeInsets.symmetric(vertical: 20,horizontal: 20),
                elevation: 5.0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                borderOnForeground: true,
                child: Container(
                  height: MediaQuery.of(context).size.height/1.8,
                  width: MediaQuery.of(context).size.width/1,
                  decoration: BoxDecoration(
                  ),
                  child: Center(
                    child: Form(
                        key: _formKey,
                        child: Padding(
                          padding: EdgeInsets.only(top: 50,left: 15,right: 15),
                          child: Column(
                            children: [
                              TextFormField(
                                controller: namectr,
                                decoration: InputDecoration(
                                    hintText: "Name",
                                    prefixIcon: Icon(Icons.person),
                                    border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(10))
                                ),
                                validator: (value){
                                  if(value==null||value.isEmpty)
                                    return "Please Enter name";
                                  return null;
                                },
                              ),
                              SizedBox(
                                height: 15,
                              ),
                              TextFormField(
                                controller: addressCtr,
                                decoration: InputDecoration(
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10)),
                                  hintText: "Address",
                                  prefixIcon: Icon(Icons.location_on),
                                ),
                                validator: (value){
                                  if(value==null||value.isEmpty)
                                    return "Please Enter Addess";
                                  return null;
                                },
                              ),
                              SizedBox(height: 15),
                              TextFormField(
                                controller: dateinput,
                                decoration: InputDecoration(
                                    prefixIcon: IconButton(
                                        onPressed: () async {
                                          DateTime? pickedDate = await showDatePicker(
                                              context: context,
                                              initialDate: DateTime.now(),
                                              firstDate: DateTime(1950),
                                              lastDate: DateTime(2100),
                                              builder: (context, child) {
                                                return Theme(
                                                    data: Theme.of(context).copyWith(
                                                        colorScheme: ColorScheme.light(
                                                          primary: colors.primary,
                                                        )),
                                                    child: child!);
                                              });

                                          if (pickedDate != null) {
                                            //pickedDate output format => 2021-03-10 00:00:00.000
                                            String formattedDate =
                                            DateFormat('yyyy-MM-dd').format(pickedDate);
                                            //formatted date output using intl package =>  2021-03-16
                                            setState(() {
                                              dateinput.text = formattedDate; //set output date to TextField value.
                                            });
                                          }
                                        },
                                        icon: Icon(Icons.calendar_today_outlined)
                                    ),
                                    hintText: 'dd-mm-yyyy',
                                    border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(10))),
                                onTap: () async {
                                  DateTime? pickedDate = await showDatePicker(
                                      context: context,
                                      initialDate: DateTime.now(),
                                      firstDate: DateTime(1950),
                                      lastDate: DateTime(2100),
                                      
                                      builder: (context, child) {
                                        return Theme(
                                            data: Theme.of(context).copyWith(
                                                colorScheme: ColorScheme.light(
                                                  primary: colors.primary,
                                                )),
                                            child: child!);
                                      });
                                  if (pickedDate != null) {
                                    //pickedDate output format => 2021-03-10 00:00:00.000
                                    String formattedDate =
                                    DateFormat('yyyy-MM-dd').format(pickedDate);
                                    //formatted date output using intl package =>  2021-03-16
                                    setState(() {
                                      dateinput.text = formattedDate; //set output date to TextField value.
                                    });
                                  }
                                },
                                validator: (value){
                                  if(value==null||value.isEmpty)
                                    return "Please Enter Date and time";
                                  return null;
                                },
                              ),
                              SizedBox(height: 15,),
                              TextFormField(
                                controller: timecon,
                                decoration: InputDecoration(
                                    hintText: "Time",
                                    prefixIcon: IconButton(
                                        onPressed: () async {
                                          showTimePicker(context: context, initialTime: selectedTime,).then((value) {
                                            setState(() {
                                              selecttimee=value!;
                                              timecon.text=selecttimee.format(context).toString();

                                            });
                                          });
                                        },
                                        icon: Icon(Icons.watch_later_rounded)       ),
                                    border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(10))
                                ),
                                onTap:() {
                                  showTimePicker(context: context, initialTime: selectedTime,).then((value) {
                                    setState(() {
                                      selecttimee=value!;
                                      timecon.text=selecttimee.format(context).toString();
                                    });
                                  });
                                },
                                validator: (value){
                                  if(value==null||value.isEmpty)
                                    return "Please Select Time";
                                  return null;
                                },
                              ),
                              SizedBox(
                                height: 30,
                              ),
                              ElevatedButton(
                                  style: ElevatedButton.styleFrom(backgroundColor: colors.primary),
                                  onPressed:(){
                                    final name = namectr.text;
                                    final address = addressCtr.text;
                                    if(_formKey.currentState!.validate())
                                      Navigator.push(context, MaterialPageRoute(builder: (context) => CardScreen(
                                          name: name, address: address, image: widget.image, datee: dateinput.text.toString(), timee: timecon.text
                                      ),
                                      ),
                                      );
                                      setState(() {});
                                  },
                                  child: Text("Submit")
                              ),
                            ],
                          ),
                        ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        )
    );
  }
}

