import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:uas_app/auth/firebase_auth.dart';
import 'package:uas_app/screens/home_screen.dart';
import 'package:uas_app/screens/signup_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}


class _LoginScreenState extends State<LoginScreen> {
  bool showPassword = false;
  bool isSigning = false;
  final FirebaseAuthService _auth = FirebaseAuthService();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

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
              "Login",
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
                "Experience, and Share Your",
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
                    keyboardType: TextInputType.emailAddress,
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
              onTap: () {_signIn();},
              child: Container(
                height: 54,
                decoration: BoxDecoration(
                  color: Color(0xFF140A80),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Center(
                  child: Text(
                    "Login",
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
                  "Don't have an account ?",
                  style: TextStyle(fontFamily: "Inter-light", fontSize: 14),
                ),
                SizedBox(
                  width: 5,
                ),
                InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => SignUpScreen()),
                    );
                  },
                  child: Text(
                    "Sign Up for free",
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
  void _signIn() async {
    setState(() {
      isSigning = true;
    });

    String email = _emailController.text;
    String password = _passwordController.text;

    User? user = await _auth.signInWithEmailAndPassword(email, password);

    setState(() {
      isSigning = false;
    });

    if (user != null) {
      _showSuccessDialog();
      print("User is successfully signed in");
    } else {
      _showErrorDialog();
      print("Email atau Password Salah!");
    }
  }

  void _showSuccessDialog() {
    List<String> emailParts = _emailController.text.split('@');
    String username = emailParts[0];
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Login Successful!'),
          content: Text('Welcome back, $username!'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context); // Close the success dialog
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => HomeScreen()),
                );
                _emailController.clear();
                _passwordController.clear();
              },
              child: Text('OK'),
            ),
          ],
        );
      },
    );
  }

  void _showErrorDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Login Failed'),
          content: Text('Invalid email or password. Please try again.'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text('OK'),
            ),
          ],
        );
      },
    );
  }
}
