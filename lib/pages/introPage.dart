import 'dart:async';
import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:todo/main.dart';
import 'package:todo/pages/SigninPage.dart';
import 'package:todo/pages/homePage.dart';
import 'package:todo/pages/loginPage.dart';

class IntroPage extends StatefulWidget{
  @override
  State<IntroPage> createState() => IntroPageState();

}

class IntroPageState extends State<IntroPage>{
  @override
  Widget build(BuildContext context){
    return Scaffold(
      body: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
        child: Stack(
            children: [
              Container(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height/1.6,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(topRight: Radius.circular(55)),
                  )
              ),
              Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height/1.6,
                decoration: BoxDecoration(
                  color: Colors.amber,
                  borderRadius: BorderRadius.only(bottomLeft: Radius.circular(60)),
                ),
                child: Image.asset('assets/images/calculatorimage.png'),
              ),
              Align(
                alignment: AlignmentDirectional.bottomCenter,
                child: Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height/2.67,
                  decoration: BoxDecoration(
                    color: Colors.amber
                  ),
                ),
              ),
              Align(
                alignment: AlignmentDirectional.bottomCenter,
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height/2.67,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(topRight: Radius.circular(60)),
                  ),
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 41.0),
                        child: Text('MY TO-DO APP', style: TextStyle(fontSize: 35, fontWeight: FontWeight.bold, fontFamily: 'FontFile'), ),
                      ),
                      Text('Make your Tasks easy!!', style: TextStyle(fontSize: 35, fontFamily: 'FontFile2')),
                      SizedBox(
                        height:14,
                      ),
                      Padding(
                        padding: const EdgeInsets.all(11.0),
                        child: ElevatedButton(onPressed: (){
                              Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => LogInPage()), );
                        }, child: Text('ENTER', style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold)),
                           style: ElevatedButton.styleFrom(backgroundColor: Colors.amber, shadowColor: Colors.amber, side: BorderSide(width: 3 ), elevation: 6.5, textStyle: TextStyle(fontSize: 20, fontFamily: 'FontFile')   )
                        ),
                      ),

                    ]
                  )
                ),
              ),
            ]
        ),
      )
    );
  }
}