import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:straightup_chat/Widgets/widget.dart';
import 'package:straightup_chat/helper/theme.dart';
import 'package:straightup_chat/services/auth.dart';
import 'package:straightup_chat/services/database.dart';
import 'package:straightup_chat/views/signin.dart';

import 'chatroomscreen.dart';

class SignUp extends StatefulWidget {

  final Function toggle;
  SignUp(this.toggle);

  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  final formKey = GlobalKey<FormState>();
  bool isLoading = false;
  AuthService authService = new AuthService();
  DatabaseMethod databaseMethod = new DatabaseMethod();
  TextEditingController emailEditingController = new TextEditingController();

  TextEditingController passwordEditingController = new TextEditingController();

  TextEditingController usernameEditingController = new TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBarMain(context),
      body: isLoading
          ? Container(child: Center(child: CircularProgressIndicator(),),)
          : Container(
        padding: EdgeInsets.symmetric(horizontal: 24),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Form(
              key: formKey,
              child: Column(
                children: [
                  TextFormField(
                    style: simpleTextStyle(),
                    decoration: textFieldInputDecoration("user name"),
                    controller: usernameEditingController,
                    validator: (val){
                      return val.isEmpty || val.length < 3 ? "Enter Username 3+characters" : null;
                    },
                  ),
                  TextFormField(
                    style: simpleTextStyle(),
                    decoration: textFieldInputDecoration("email"),
                    controller: emailEditingController,
                    validator: (val){
                      return RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+").hasMatch(val) ? null : "Enter correct email";
                    },
                  ),
                  TextFormField(
                    obscureText: true,
                    validator:  (val){
                      return val.length < 6 ? "Enter Password 6+ characters" : null;
                    },
                    style: simpleTextStyle(),
                    decoration: textFieldInputDecoration("password"),
                    controller: passwordEditingController,

                  ),
                ],
              ),
            ),
            SizedBox(
              height: 16,
            ),
            SizedBox(
              height: 16,
            ),
            GestureDetector(
              onTap: () {
                singUp();
              },
              child: Container(
                padding: EdgeInsets.symmetric(vertical: 16),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(30),
                    gradient: LinearGradient(
                      colors: [
                        const Color(0xff007EF4),
                        const Color(0xff2A75BC)
                      ],
                    )),
                width: MediaQuery.of(context).size.width,
                child: Text(
                  "Sign Up",
                  style: biggerTextStyle(),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
            SizedBox(
              height: 16,
            ),

            SizedBox(
              height: 16,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Already have an account? ",
                  style: simpleTextStyle(),
                ),
                GestureDetector(
                  onTap: () {
                    widget.toggle();

                    // Navigator.push(
                    //     context,
                    //     PageTransition(
                    //       type: PageTransitionType.rotate,
                    //       child: SignIn(),
                    //     )
                    // );
                  },
                  child: Text(
                    "Login",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        decoration: TextDecoration.underline),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 50,
            )
          ],
        ),
      ),
    );
  }
  singUp() async {

    if(formKey.currentState.validate()){

      Map<String, String> userInfoMap ={
        "name": usernameEditingController.text,
        "email": emailEditingController.text
      };

      setState(() {
        isLoading = true;
      });

      await authService.signUpWithEmailAndPassword(emailEditingController.text,
          passwordEditingController.text).then((val){
            // print("${val.uid}");
          databaseMethod.uploadUsersInfo(userInfoMap);
          Navigator.pushReplacement(context, MaterialPageRoute(
              builder: (context) => ChatRoom()
          ));

      });
    }
    else{
      return CircularProgressIndicator();
    }
  }
}