import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;


class SelfModelExample extends StatelessWidget {
  // SelfModelExample({Key? key}) : super(key: key);


  List<Photos> photosList = [];
  Future<List<Photos>> photosApi()async{
    final response =await http.get(Uri.parse("https://jsonplaceholder.typicode.com/photos"));
    var data = jsonDecode(response.body.toString());

    if(response.statusCode == 200){
      for (Map i in data){
        Photos photos = Photos(title: i["title"], url: i["url"],id: i["id"]);
        photosList.add(photos);
      }
      return photosList;
    }else{

      return photosList;
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
              future: photosApi(),
              builder: (context,AsyncSnapshot<List<Photos>> snapshot){
              if (!snapshot.hasData){
                return const Text("Loading");
              }else{
                return ListView.builder(
                  itemCount: photosList.length,
                  itemBuilder: (context,index){
                    return ListTile(
                      leading: CircleAvatar(
                        backgroundImage: NetworkImage(
                        snapshot.data![index].url.toString()
                      ),),
                      subtitle: Text(snapshot.data![index].title.toString()),
                      title: Text(snapshot.data![index].id.toString()),
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

class Photos{
  final String url ,title;
  final int id;

  Photos( {required this.url, required this.title,required this.id});

}
