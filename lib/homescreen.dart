import 'dart:convert';


import 'package:complex_api_flutter/models/posts_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;


class HomeScreen extends StatelessWidget {
  HomeScreen({Key? key}) : super(key: key);


  List<PostsModel> listModel = [];
  Future<List<PostsModel>> getpostApi()async{
    final response = await http.get(Uri.parse("https://jsonplaceholder.typicode.com/posts"));
    var data = jsonDecode(response.body.toString());
    if (response.statusCode == 200){
      for(Map i in data){
        // listModel.clear();
        listModel.add(PostsModel.fromJson(i));
      }
      return listModel;
    }
    else {
      return listModel;
    }
    
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Api"),
      ),
      body: Column(

        children: [
          Expanded(
            child: FutureBuilder(
              future: getpostApi(),
              builder: (context,snapshot){
              if (!snapshot.hasData){
                return const Text("Loading");
              }else{
                return ListView.builder(
                  itemCount: listModel.length,
                  itemBuilder: (context,index){
                    return Card(
                      child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("Title",style: Theme.of(context).textTheme.headline6,),
                          Text(listModel[index].title.toString()),
                          Text("Body",style: Theme.of(context).textTheme.headline6,),
                          Text(listModel[index].body.toString()),
                        ],
          
                      ),
                    );
                });
              }
            }),
          )
        ],
      ),
    );
  }
}
