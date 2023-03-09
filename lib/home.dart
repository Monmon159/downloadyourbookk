import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:http/http.dart' as http;
import 'package:url_launcher/url_launcher.dart';
import 'package:url_launcher/url_launcher_string.dart';
class homepage extends StatefulWidget {
   homepage({super.key});

  @override
  State<homepage> createState() => _homepageState();
}
class _homepageState extends State<homepage> {
//   var authorname=[];
// var title=[];
// var publishdate=[];
var bookname;
var count=0;
var authorname;
String? imagename;
String? describtion;
var availablityepub;
var availablitypdf;

var downloadepub;
var downloadpdf;

TextEditingController tcontroller=TextEditingController();
  @override
 void initState() {
    //getdata();
    // TODO: implement initState
    super.initState();
    
    //print(quotesss[1]);
  }
  final _formKey = GlobalKey<FormState>();
  
  @override
  Widget build(BuildContext context) {
    MediaQueryData query=MediaQuery.of(context);
    return SafeArea(

      child: Center (
        child: Form(
          key: _formKey,
          child: Scaffold(
           body:count==0?
           Stack(
             children: [
               Image.asset('assets/booka.jpg')
              ,Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15,vertical: 5),
                child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('Search for your Book!',style: TextStyle(
                  fontSize: 50
                ),),
                  TextFormField(
                    controller:tcontroller ,
                    validator: (value) {
                      if (value?.isEmpty==true||value==null){
                        return 'enter valid book';
                      }else{
                        return null;
                      }
                    },
                    decoration: InputDecoration(
                      prefixIcon:Icon( Icons.search),
                          
                          border: OutlineInputBorder(borderRadius: BorderRadius.circular(40)),
                          labelText:'Book name'
                        ),
                  ),
                  SizedBox(height: 20,width: 20,),
                  SizedBox(
                    height: 50,
                  width: 150,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                      backgroundColor:  Colors.redAccent, // Background color
                      )
                      ,onPressed: (){
                      if(_formKey.currentState!.validate()){
                          setState(() {
                            bookname=tcontroller.text;
                            count=1;
                            getdata();
                          });
                          
                        
                      }
                    }, child: Text('search'),),
                  )
                ],
             ),
              ),]
           ):authorname==null?Center(child: CircularProgressIndicator()):
           
              Center(
               child:  SizedBox(
                width: query.size.width,
              height: query.size.height,
                //height: d,
                 child: 
                   Card(
                      //height: double.infinity,
                      //width: double.infinity,
                      color: Color(0xffFCE4EC),
                       child: Padding(
                         padding: const EdgeInsets.all(7),
                         child: Column(
                          
                         // mainAxisAlignment: MainAxisAlignment.center,
                          // crossAxisAlignment: CrossAxisAlignment.baseline,
                          children: [
                             Image.network('$imagename'),
                            SizedBox(height: 10,),
                            Row(children: [Text('Author_name:  ',style: TextStyle(fontSize: 15,fontWeight: FontWeight.bold,
                            color: Colors.redAccent),),Text('$authorname',style: TextStyle(fontSize: 15),)],),
                            SizedBox(height: 10,),
                            Row(children: [Text('Description:  ',style: TextStyle(fontSize: 15,fontWeight: FontWeight.bold,
                            color: Colors.redAccent),),Flexible(child: Text('$describtion',style: TextStyle(fontSize: 15),))],),
                            SizedBox(height: 10,),
                            Row(children: [Text('Is available for download epub:  ',style: TextStyle(fontSize: 15,fontWeight: FontWeight.bold,
                            color: Colors.redAccent),),Text('$availablityepub',style: TextStyle(fontSize: 15),)],),
                            SizedBox(height: 10,),
                            Row(children: [
                              Text('Download url :  ',style: TextStyle(fontSize: 15,fontWeight: FontWeight.bold,
                            color: Colors.redAccent),),
                              Flexible(
                                child: TextButton(onPressed: ()async{
                                  if('$downloadepub'!=null){
                                 launchUrlString('$downloadepub');
                                  }
                                                         
                                }, child: Text('$downloadepub',style: TextStyle(fontSize: 15),)),
                              )
                          ],),SizedBox(height: 10,),
                            Row(children: [Text('Is available for download pdf:  ',style: TextStyle(fontSize: 15,fontWeight: FontWeight.bold,
                            color: Colors.redAccent),),Text('$availablitypdf',style: TextStyle(fontSize: 15),)],),
                            SizedBox(height: 10,),
                            Row(children: [
                              Text('Download url :  ',style: TextStyle(fontSize: 15,fontWeight: FontWeight.bold,
                            color: Colors.redAccent),),
                            Icon(Icons.picture_as_pdf),
                              Flexible(
                                child: TextButton(onPressed: ()async{
                                  if('$downloadpdf'!=null){
                                 launchUrlString('$downloadpdf');
                                  }                           }
                                  
                                  
                                 
                                , child: Text('$downloadpdf',style: TextStyle(fontSize: 15),)),
                              )]
                         ),
                       ]),
                     ),
                                ),
                 ),
               ),
             ),
           )
           ),
        
      );
           
            
          
         
      
    
  }
  getdata()async{
    
  var response=await http.get(Uri.parse('https://www.googleapis.com/books/v1/volumes?q=$bookname+inauthor:keyes&key=%20AIzaSyAeLYAY-B4skZIxJNj1N1XBucKAtQgIBiI'));
  
var datalist=jsonDecode(response.body);
    setState(() {
authorname=datalist['items'][0]['volumeInfo']['authors'];
describtion=datalist['items'][0]['volumeInfo']['description'];
imagename=datalist['items'][0]['volumeInfo']['imageLinks']['thumbnail'];
availablityepub=datalist['items'][0]['accessInfo']['epub']['isAvailable'];
availablitypdf=datalist['items'][0]['accessInfo']['pdf']['isAvailable'];
downloadepub=datalist['items'][0]['accessInfo']['epub']['acsTokenLink'];
downloadpdf=datalist['items'][0]['accessInfo']['pdf']['acsTokenLink'];
print(authorname);
    });
   
// setState(() {
//   diff=datalist['results'][0]['definition'];
//   print(diff);
// });

//print(data);


} 
}
