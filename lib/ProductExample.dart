
import 'dart:convert';

import 'package:complex_api_flutter/models/product_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class ProductExample extends StatefulWidget {
  //  FourthExample({ Key? key }) : super(key: key);
  @override
  State<ProductExample> createState() => _ProductExampleState();
}

class _ProductExampleState extends State<ProductExample> {
  

  Future<ProductModel> getProductApi() async{
    final response = await http.get(Uri.parse("https://webhook.site/19714260-a53f-4659-b23d-055f101bb439"));
    var data = jsonDecode(response.body.toString());
    if (response.statusCode == 200){
      
      return ProductModel.fromJson(data);
    }else{
      return ProductModel.fromJson(data);
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
          Expanded(
            child: FutureBuilder<ProductModel>(
            future: getProductApi(),
            builder: (context,snapshot){
              if(snapshot.hasData){
                return ListView.builder(
                  itemCount: snapshot.data!.data!.length,
                  itemBuilder: (context,index){
                  return Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [

                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: ListTile(
                                  title: Text(snapshot.data!.data![index].name.toString()),
                                  subtitle: Text(snapshot.data!.data![index].shopemail.toString()),
                                  leading: CircleAvatar(
                                    backgroundImage: NetworkImage(
                                      
                                      snapshot.data!.data![index].image.toString(),scale: 2),
                                  ),
                                ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          // color: Colors.black,
                          height: MediaQuery.of(context).size.height*.35,
                          width: 400,
                          
                          child: ListView.builder(
                            shrinkWrap: true,
                            scrollDirection: Axis.horizontal,
                            itemCount: snapshot.data!.data![index].products!.length,
                            itemBuilder: (context , position){
                            return Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Container(
                                color: Colors.yellow,
                                height: MediaQuery.of(context).size.height*.25,
                                width: 300,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text("Title:  "+snapshot.data!.data![index].products![position].title.toString()),
                                    Text("Sold:   "+snapshot.data!.data![index].products![position].sold.toString()),
                                    
                                    Text("Price:  "+snapshot.data!.data![index].products![position].price.toString()),
                                    Text("Color:  "+snapshot.data!.data![index].products![position].colors.toString()),
                                    Container(
                                      height: 180,
                                      child: ListView.builder(
                                        shrinkWrap: true,
                                        scrollDirection: Axis.horizontal,
                                        itemCount: snapshot.data!.data![index].products![position].images!.length,
                                        itemBuilder: (context,length){
                                        return Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Container(
                                            height: 100,
                                            width: 100,
                                            decoration: BoxDecoration(
                                  color: Colors.blue,
                                  image: DecorationImage(
                                      fit: BoxFit.contain,
                                      image: NetworkImage(
                                        
                                      snapshot.data!.data![index].products![position].images![length].url.toString(),scale: 2,
                                  ))
                                ),
                                          ),
                                        );
                                      }),
                                    ),
                                   Row(
                                     mainAxisAlignment: MainAxisAlignment.spaceAround,
                                     children: [
                                        Icon(snapshot.data!.data![index].products![position].inWishlist == true?Icons.favorite:Icons.favorite_border_outlined),
                                    Text("Size:  "+snapshot.data!.data![index].products![position].size.toString()),
                                     ],
                                   )
                                  ],
                                ),
                                
                              ),
                            );
                          }),
                        ),
                      )
                    ],
                  );
                });

              }
              else{
                return Center(child: Text("Loading"));
              }
           }
            ))
        ],
      ),
    );
  }
}
