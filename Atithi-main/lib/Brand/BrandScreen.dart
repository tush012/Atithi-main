import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../Helper/Appbar.dart';

class BrandScreen extends StatefulWidget {
  const BrandScreen({Key? key}) : super(key: key);

  @override
  State<BrandScreen> createState() => _BrandScreenState();
}

class _BrandScreenState extends State<BrandScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: customAppBar(context: context, text:"Brand", isTrue: true, ),
        body: Column(
          children: [
            Container(
              height: MediaQuery.of(context).size.height/1.2,
              child: ListView.builder(
                  itemCount: 5,
                  itemBuilder: (BuildContext context, int index) {
                    return Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10)
                      ),
                      elevation: 2,
                      child: ListTile(
                          leading: const Icon(Icons.list),
                          trailing: const Text(
                            "GFG",
                            style: TextStyle(color: Colors.green, fontSize: 15),
                          ),
                          title: Text("List item $index")),
                    );
                  }),
            ),
          ],
        ),
      ),
    );
  }
}
