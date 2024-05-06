
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:sign_in_button/sign_in_button.dart';
import 'package:todo/auth_service/auth.dart';
import 'package:todo/pages/SigninPage.dart';
import 'package:todo/pages/homePage.dart';


class LogInPage extends StatefulWidget{
  @override
  State<LogInPage> createState() => LogInPageState();
}

class LogInPageState extends State<LogInPage>{
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();


LogIn(String email, String password)async{
    showDialog(context: context, 
    builder: (context){
      return Center(
        child: CircularProgressIndicator()
      );
    });

    Navigator.pop(context);

     if(email == "" && password == ""){
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
            usercredential = await FirebaseAuth.instance.signInWithEmailAndPassword(
                               email: email,
                               password: password,
                          ).then((value) {
                            Navigator.push(context, MaterialPageRoute(builder: (context) => HomePage()),);
                          },);
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
  bool isobscure = true;

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

                       Text('Welcome back You have been missed!', style: TextStyle(color: Colors.black54, fontSize: 16, fontWeight: FontWeight.w800)),

              
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
                          obscureText: isobscure,
                          decoration: InputDecoration(
                             suffixIcon: IconButton(icon:  isobscure? Icon(Icons.visibility): Icon(Icons.visibility_off),
                             onPressed:(){
                              setState(() {
                                isobscure = !isobscure;
                              });
                             }
                              ) ,
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
                        padding: const EdgeInsets.only(right:14),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            InkWell(child: Text('Forgot Password?', style: TextStyle(color: Colors.indigo, fontSize: 14, fontWeight: FontWeight.w800)), onTap: (){},),
                          ],
                        ),
                      ),
              
                      SizedBox(height:20),
              
                      GestureDetector(
                        onTap: (){
                          LogIn(emailController.text.toString(), passwordController.text.toString());
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
                            child: Center(child: Text('Log In', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 16 ),))
                            
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
                              
                      SignInButton(Buttons.google, onPressed: ()async{
                          await signInWithGoogle();

                          showDialog(context: context, 
                                      builder: (context){
                                        return Center(
                                          child: CircularProgressIndicator()
                                    );
                              });

                          Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=> HomePage()));

                      },
                      padding: EdgeInsets.symmetric(horizontal: 2),
                      text: 'Log In with Google',
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(11)),
                      elevation: 5,),
                  
                      SizedBox(height: 15,),
              
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                        Text('Don\'t have an account?', style: TextStyle(color:Colors.black87),),
                        SizedBox(width:5,),
                        InkWell(onTap:(){
                          Navigator.push(context, MaterialPageRoute(builder: (context)=> SigninPage()));
                        },child: Text('Sign In', style: TextStyle(color:Colors.indigo, fontWeight: FontWeight.bold,)))
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

