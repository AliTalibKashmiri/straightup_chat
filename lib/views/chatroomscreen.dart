import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:straightup_chat/helper/authentication.dart';

import 'search.dart';
import 'signin.dart';
 class ChatRoom extends StatefulWidget {
   @override
   _ChatRoomState createState() => _ChatRoomState();
 }

 class _ChatRoomState extends State<ChatRoom> {

  // AuthMethods authMethods= new AuthMethods();
final auth = FirebaseAuth.instance;

   @override
   Widget build(BuildContext context) {
     return Scaffold(
      appBar: AppBar(
        title: Image.asset("assets/images/logo.png", height: 50,),
        actions: [
          GestureDetector(
            onTap: ()
            {
              auth.signOut();
              Navigator.pushReplacement(context, MaterialPageRoute(
                builder: (context) => Authentication()
              ));
              // Auth
            },
            child: Container(
                padding: EdgeInsets.symmetric(horizontal: 16),
                child: Icon(Icons.exit_to_app)),
          )
        ],

      ),
       floatingActionButton: FloatingActionButton(
         child: Icon(Icons.search),
         onPressed: (){
           Navigator.push(context, MaterialPageRoute(
             builder: (context) => SearchScreen()
           ));
         },
       ),
     );
   }
 }


