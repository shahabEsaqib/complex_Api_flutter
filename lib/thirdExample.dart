import 'dart:convert';
import 'package:complex_api_flutter/models/user_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;

class UserApi extends StatefulWidget {
  // SelfModelExample({Key? key}) : super(key: key);


  @override
  State<UserApi> createState() => _UserApiState();
}

class _UserApiState extends State<UserApi> {
  List<UserModel> userList = [];

  Future<List<UserModel>> photosApi()async{
    final response =await http.get(Uri.parse("https://jsonplaceholder.typicode.com/users"));
    var data = jsonDecode(response.body.toString());

    if(response.statusCode == 200){
      for (Map i in data){
        userList.add(UserModel.fromJson(i));
      }
      return userList;
    }else{

      return userList;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Api"),
      ),
      body: Column(

        children: [
          Expanded(child: FutureBuilder(
            future: photosApi(),
            builder: (context,AsyncSnapshot<List<UserModel>> snapshot){
            
              
              if(!snapshot.hasData){
                return CircularProgressIndicator();
              }else{
               return ListView.builder(
              itemCount: userList.length,
              itemBuilder: (context , index){
                return Card(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      children: [
                       ReusableRow(title: "Name", value: snapshot.data![index].name.toString()),
                       ReusableRow(title: "UserName", value: snapshot.data![index].username.toString()),
                       ReusableRow(title: "Email", value: snapshot.data![index].email.toString()),
                       ReusableRow(title: "Zipcode", value: snapshot.data![index].address!.zipcode.toString()),
                       ReusableRow(title: "City Adress", value: snapshot.data![index].address!.city.toString()),
                       ReusableRow(title: "Street", value: snapshot.data![index].address!.street.toString()),
                       ReusableRow(title: "Lat", value: snapshot.data![index].address!.geo!.lat.toString()),
                       ReusableRow(title: "Lng", value: snapshot.data![index].address!.geo!.lng.toString()),
                       ReusableRow(title: "Company address", value: snapshot.data![index].company!.name!.toString()),
                       ReusableRow(title: "Phone No", value: snapshot.data![index].phone.toString()),
                      ],
                    ),
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