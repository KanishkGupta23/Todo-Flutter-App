
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:sign_in_button/sign_in_button.dart';
import 'package:todo/auth_service/auth.dart';
import 'package:todo/pages/homePage.dart';
import 'package:todo/pages/loginPage.dart';

class SigninPage extends StatefulWidget{
   @override
  State<SigninPage> createState() => SigninPageState();

}

class SigninPageState extends State<SigninPage>{
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();


  SignIn(String email, String password, String confirmPassword)async{
    if(email == "" && password == "" && confirmPassword == ""){
      showDialog(context: context, 
      builder: (context) => AlertDialog(
        title: Text("Enter the Required Fields", style: TextStyle(color:Colors.white),),
        actions: [
          InkWell(child: Text('OK',style: TextStyle(color:Colors.white)), onTap:(){
            Navigator.pop(context);
          }),
        ],
        backgroundColor: Colors.deepPurple,
      )
      );
    }
    else{
      UserCredential? usercredential;
      try{
        if(passwordController.text.toString() == confirmPasswordController.text.toString()){
            usercredential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
                               email: email,
                               password: password,
                          ).then((value) {
                            Navigator.push(context, MaterialPageRoute(builder: (context) => HomePage()),);
                          },);
      }
      else{
        showDialog(context: context, 
      builder: (context) => AlertDialog(
        title: Text("Passwords do not match", style: TextStyle(color:Colors.white),),
        backgroundColor: Colors.deepPurple,
        actions: [
          InkWell(child: Text('OK', style: TextStyle(color:Colors.white)), onTap: (){Navigator.pop(context);},),
        ],
      )
      );

      }
      }
      on FirebaseAuthException catch(ex){
          return showDialog(context: context, 
      builder: (context) => AlertDialog(
        title: Text(ex.code.toString(), style: TextStyle(color:Colors.white),),
        backgroundColor: Colors.deepPurple,
      )
      );
      }

    }
  }
   @override

  Widget build(BuildContext context){
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [ 
                  Colors.amberAccent,
                  Colors.orangeAccent,
                  ])
              ),
              child: Center(
                child: Padding(
                  padding: EdgeInsets.all(10.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        height:100,
                        width:100,
                        child: Icon(Icons.lock, size: 90, color: Colors.black,)
                      ),
                              
                       SizedBox(height:15),

                       Text('Create your Account to LogIn!', style: TextStyle(color: Colors.black54, fontSize: 16, fontWeight: FontWeight.w800)),

              
                       SizedBox(height:20),
                              
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: TextField(
                          controller: emailController,
                          decoration: InputDecoration(
                            hintText: 'Enter Email',
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15),
                              borderSide: BorderSide(
                                color: Colors.black,
                                width: 2,
                              ),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15),
                              borderSide: BorderSide(
                                color: Colors.red,
                                width: 2,
                              )
                          ),
                          fillColor: Colors.white70,
                          filled: true,
                        ),
                      ),
                      ),
                              
                      SizedBox(height:5),
                              
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: TextField(
                          keyboardType: TextInputType.text,
                          controller: passwordController,
                          obscureText: true,
                          decoration: InputDecoration(
                             hintText: 'Enter Password',
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15),
                              borderSide: BorderSide(
                                color: Colors.black,
                                width: 2,
                              )
                            ),
                             focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15),
                              borderSide: BorderSide(
                                color: Colors.red,
                                width: 2,
                              )
                          ),
                          fillColor: Colors.white70,
                          filled: true,
                          ),
                        ),
                      ),

                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: TextField(
                          keyboardType: TextInputType.text,
                          controller: confirmPasswordController,
                          obscureText: true,
                          decoration: InputDecoration(
                             hintText: 'Confirm Password',
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15),
                              borderSide: BorderSide(
                                color: Colors.black,
                                width: 2,
                              )
                            ),
                             focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15),
                              borderSide: BorderSide(
                                color: Colors.red,
                                width: 2,
                              )
                          ),
                          fillColor: Colors.white70,
                          filled: true,
                          ),
                        ),
                      ),
                            
                      SizedBox(height:20),
                              
                      GestureDetector(
                        onTap: (){
                          SignIn(emailController.text.toString(),passwordController.text.toString(), confirmPasswordController.text.toString());
                        },
                        child: Center(
                          child: Container(
                            width:MediaQuery.sizeOf(context).width,
                            height:55,
                            padding: EdgeInsets.all(11),
                            margin: EdgeInsets.symmetric(horizontal: 40),
                            decoration: BoxDecoration(
                              color: Colors.black,
                              border: Border.all(),
                              borderRadius: BorderRadius.circular(5),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.white,
                                  spreadRadius: 2,
                                )
                              ]
                            ),
                            child: Center(child: Text('Sign In', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 16 ),))
                            
                          ),
                        ),
                      ),
                              
                      SizedBox(height:20),
                            
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                          Expanded(
                            child: Divider(
                              thickness: 2,
                              color: Colors.black38
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text('or Continue with', style: TextStyle(color: Colors.black45)),
                          ),
                          Expanded(
                            child: Divider(
                              thickness: 2,
                              color: Colors.black38,
                            ),
                          ),
                        ],),
                      ),
                  
                      SizedBox(height:20),
                              
                      SignInButton(Buttons.google,onPressed: ()async{
                          await signInWithGoogle();

                          showDialog(context: context, 
                                      builder: (context){
                                        return Center(
                                          child: CircularProgressIndicator()
                                    );
                              });

                          Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=> HomePage()));

                      },
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(11)),
                      elevation: 5,),
                  
                      SizedBox(height: 15,),
                  
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                        Text('Already have an account?', style: TextStyle(color:Colors.black87),),
                        SizedBox(width:5,),
                        InkWell(onTap:(){
                          Navigator.pushReplacement(context, MaterialPageRoute(builder:(context)=> LogInPage()));
                        },child: Text('Log In', style: TextStyle(color:Colors.indigo, fontWeight: FontWeight.bold,)))
                      ],)
                    ],
                  
                   
                              
                  ),
                ),),
            
            ),
          ],
        ),
      ),
    );
  }
}