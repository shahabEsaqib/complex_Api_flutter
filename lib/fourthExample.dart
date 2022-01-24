
import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class FourthExample extends StatefulWidget {
  //  FourthExample({ Key? key }) : super(key: key);
  @override
  State<FourthExample> createState() => _FourthExampleState();
}

class _FourthExampleState extends State<FourthExample> {
  var data;

  Future<void> getUserApi() async{
    final response = await http.get(Uri.parse("https://jsonplaceholder.typicode.com/users"));
    if (response.statusCode == 200){
      data = jsonDecode(response.body.toString());

    }else{

    }


  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:Text("Api ")
      ),
      body: Column(
        children: [
          Expanded(child: FutureBuilder(
            future: getUserApi(),
            builder: (context,snapshot){
              if(snapshot.connectionState==ConnectionState.waiting){
                return Center(child: CircularProgressIndicator());
              }
              else{ return ListView.builder(
                itemCount: data.length,
                itemBuilder: (context,index){
                return Card(
                  child: Column(
                    children: [
                      ReusableRow(title: "name", value: data[index]['name'].toString()),
                      ReusableRow(title: "username", value: data[index]['username'].toString()),
                      ReusableRow(title: "adress", value: data[index]['address']['street'].toString()),
                      ReusableRow(title: "Lat", value: data[index]['address']['geo']["lat"].toString()),
                      ReusableRow(title: "Lng", value: data[index]['address']['geo']['lng'].toString()),
                    ],
                  ),
                );
              });
              }
            }))
        ],
      ),
    );
  }
}
class ReusableRow extends StatelessWidget {
  final String title, value;
   ReusableRow({ Key? key, required this.title, required this.value }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(title),
            Text(value)
          ],
        ),
  );
  }
}