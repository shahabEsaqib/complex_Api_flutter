import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:http/http.dart' as http;


class UploadImage extends StatefulWidget {
  const UploadImage({ Key? key }) : super(key: key);

  @override
  _UploadImageState createState() => _UploadImageState();
}


class _UploadImageState extends State<UploadImage> {
File? image;
final _picker = ImagePicker();
bool showspinner = false;
Future getImage()async{
  final pickedfile = await _picker.pickImage(source: ImageSource.gallery,imageQuality: 80);
  if(pickedfile != null){
    image = File(pickedfile.path);
    setState(() {
      
    });
  }else{
    print("no image selected");
  }
}
Future<void> uplaodimage()async{
 setState(() {
   showspinner = true;
 });
  var stream = http.ByteStream(image!.openRead());
  var length = await image!.length();
  var uri = Uri.parse("https://fakestoreapi.com/products");

  var request = http.MultipartRequest('POST',uri);
  request.fields["title"] = "static title";

  var multipart = new http.MultipartFile('image', stream, length);
  request.files.add(multipart);
  
  var response = await request.send();
  if(response.statusCode == 200){
    setState(() {
      showspinner = false;
    });
    print("image uploaded");
  }else{

    print("failed");
    setState(() {
      showspinner = false;
    });
  }

}

  @override
  Widget build(BuildContext context) {
    return ModalProgressHUD(
      inAsyncCall: showspinner,
      child: Scaffold(
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            GestureDetector(
                 onTap: (){
                   getImage();
                 },
                 child:
            Container(
              child: image == null ? Center(child: Text("pick image")):
                Container(
                  child: Center(
                    child: Image.file(
                      File(image!.path).absolute,
                      height: 100,
                      width: 100,
                      fit: BoxFit.fill,
                      ))
                           ),
               )
            ),
            SizedBox(height: 140,),
            GestureDetector(
                 onTap: (){
                   uplaodimage();
                 },
                 child: Container(
                   height: 50,
                   decoration: BoxDecoration(
                     color: Colors.green,
                     borderRadius: BorderRadius.circular(10)
                   ),
                   child: Center(child: Text("Uplaod Image")),
                 ),
               )
          ],
        ),
      ),
    );
  }
}