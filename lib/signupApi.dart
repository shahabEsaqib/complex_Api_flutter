import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;


class SignUpApi extends StatefulWidget {


  @override
  State<SignUpApi> createState() => _SignUpApiState();
}

class _SignUpApiState extends State<SignUpApi> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
login(String email ,password)async{
  try{
    http.Response response = await http.post(Uri.parse("https://reqres.in/api/register"),body: {
      'email': email,
      'password': password,


    });
    if(response.statusCode == 200){
      var data = jsonDecode(response.body.toString());
      print(data['token']);
      print("sign up succesfully");
    }else{
      print("unsuccesful");
    }
   
  }catch(e){
    print(e.toString());
  }

}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Sign up api"),
        
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
             TextFormField(
               controller: emailController,
               decoration: InputDecoration(
                 hintText: "email"
               ),
             ),
             SizedBox(height: 20,),
              TextFormField(
               controller: passwordController,
               decoration: InputDecoration(
                 hintText: "password"
               ),
             ),
             SizedBox(height: 40,),
             GestureDetector(
               onTap: (){
                 login(emailController.text.toString(),passwordController.text.toString());
               },
               child: Container(
                 height: 50,
                 decoration: BoxDecoration(
                   color: Colors.green,
                   borderRadius: BorderRadius.circular(10)
                 ),
                 child: Center(child: Text("Sign Up")),
               ),
             )
          ],
        ),
      ),
);

  }
}
