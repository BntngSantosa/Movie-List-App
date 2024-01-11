import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:uas_app/screens/login_screen.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  bool showPassword = false;
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: ListView(
          children: [
            // image
            Container(
              child: SizedBox(
                width: 366,
                child: Image.asset("assets/images/img_login.jpg"),
              ),
            ),
            SizedBox(
              height: 13,
            ),

            // text login
            Text(
              "Sign Up",
              style: TextStyle(
                fontFamily: "Poppins-SemiBold",
                fontSize: 42,
              ),
            ),
            SizedBox(
              height: 5,
            ),

            // text
            SizedBox(
              child: Text(
                "Sign Up for see",
                style: TextStyle(
                  fontFamily: "Inter-Regular",
                  fontSize: 16,
                ),
              ),
            ),
            Text(
              "Favorite Movie Collection",
              style: TextStyle(
                fontFamily: "Inter-Regular",
                fontSize: 16,
              ),
            ),
            SizedBox(
              height: 30,
            ),

            // text field
            Container(
              height: 54,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.25), // shadow color
                    spreadRadius: 0, // spread radius
                    blurRadius: 6, // blur radius
                    offset: Offset(0, 0), // changes position of shadow
                  ),
                ],
                color: Colors.white, // set your desired background color
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Center(
                  child: TextField(
                    controller: _emailController,
                    decoration: InputDecoration(
                      hintText: "Email",
                      border: UnderlineInputBorder(borderSide: BorderSide.none),
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 30,
            ),

            // text field
            Container(
              height: 54,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.25),
                    spreadRadius: 0,
                    blurRadius: 6,
                    offset: Offset(0, 0),
                  ),
                ],
                color: Colors.white,
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Center(
                  child: TextField(
                    controller: _passwordController,
                    obscureText: !showPassword,
                    decoration: InputDecoration(
                      hintText: "Password",
                      border: UnderlineInputBorder(borderSide: BorderSide.none),
                      suffixIcon: GestureDetector(
                        onTap: () {
                          setState(() {
                            showPassword = !showPassword;
                          });
                        },
                        child: Icon(
                          showPassword
                              ? CupertinoIcons.eye
                              : CupertinoIcons.eye_slash,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 30,
            ),

            // button login
            InkWell(
              onTap: () {
                // signUp(_emailController.text, _passwordController.text);
              },
              child: Container(
                height: 54,
                decoration: BoxDecoration(
                  color: Color(0xFF140A80),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Center(
                  child: Text(
                    "Sign Up",
                    style: TextStyle(
                      fontFamily: "Poppins-Bold",
                      fontSize: 20,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 30,
            ),

            // text signup
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "do you already have an account ?",
                  style: TextStyle(fontFamily: "Inter-light", fontSize: 14),
                ),
                SizedBox(
                  width: 5,
                ),
                InkWell(
                  onTap: () {
                    Navigator.pop(
                      context,
                      MaterialPageRoute(builder: (context) => LoginScreen()),
                    );
                  },
                  child: Text(
                    "Login",
                    style: TextStyle(
                        fontFamily: "Inter-SemiBold",
                        fontSize: 14,
                        color: Color(0xFF32449F)),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
