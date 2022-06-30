import 'package:flutter/material.dart';
import 'package:findeat/view/register_view.dart';
import 'package:findeat/view/home_view.dart';
import 'package:findeat/theme.dart';
import 'package:firebase_auth/firebase_auth.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({ Key? key }) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}
final _auth = FirebaseAuth.instance;
class _LoginPageState extends State<LoginPage> {
  late String email;
  late String password;
  bool passwordVisible = false;
  void togglePassword() {
    setState(() {
      passwordVisible = !passwordVisible;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.fromLTRB(24, 40, 24, 0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: 90,),
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Image.asset(
                    'assets/images/splash.png',
                  )
                ],
              ),
              SizedBox(height: 48,),
              Form(
                  child: Column(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                            color: textWhiteGrey,
                            borderRadius: BorderRadius.circular(14)
                        ),
                        child: TextFormField(
                          keyboardType: TextInputType.emailAddress,
                          onChanged: (value) {
                            email = value;
                            //Do something with the user input.
                          },
                          decoration: InputDecoration(
                              hintText: 'Email',
                              hintStyle: heading6.copyWith(color: textGrey),
                              border: OutlineInputBorder(borderSide: BorderSide.none)
                          ),
                        ),
                      ),
                      SizedBox(height: 32,),
                      Container(
                        decoration: BoxDecoration(
                            color: textWhiteGrey,
                            borderRadius: BorderRadius.circular(14)
                        ),
                        child: TextFormField(
                          onChanged: (value) {
                            password = value;
                            //Do something with the user input.
                          },
                          obscureText: !passwordVisible,
                          decoration: InputDecoration(
                              hintText: 'Password',
                              hintStyle: heading6.copyWith(color: textGrey),
                              suffixIcon: IconButton(
                                color: textGrey,
                                splashRadius: 1,
                                icon: Icon(passwordVisible ? Icons.visibility_outlined : Icons.visibility_off_outlined),
                                onPressed: togglePassword,
                              ),
                              border: OutlineInputBorder(
                                  borderSide: BorderSide.none
                              )
                          ),
                        ),
                      )
                    ],
                  )
              ),
              SizedBox(height: 32,),
              Container(
                child: RaisedButton(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(14),
                  ),
                  color: Colors.black54,
                  onPressed: () async{
                    try {
                      final user = await _auth.signInWithEmailAndPassword(
                          email: email, password: password);
                      if (user != null) {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => HomePage()
                            )
                        );
                      }
                    } catch (e) {
                      print(e);
                    }

                  },
                  child: Text(
                      'Login',
                      style: heading5.copyWith(color: Colors.white)
                  ),
                ),
              ),

              SizedBox(height: 50,),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Don’t have account? ',
                    style: regular16pt.copyWith(color: textGrey),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => RegisterPage()
                          )
                      );
                    },
                    child: Text(
                      'Register',
                      style: regular16pt.copyWith(color: Colors.black54),
                    ),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}