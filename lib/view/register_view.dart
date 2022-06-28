import 'package:findeat/view/login_view.dart';
import 'package:flutter/material.dart';
import 'package:findeat/theme.dart';


class RegisterPage extends StatefulWidget {
  const RegisterPage({ Key? key }) : super(key: key);

  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  bool passwordVisible = false;
  bool passwordConfirmVisible = false;
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
                SizedBox(height: 32,),
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
                            decoration: InputDecoration(
                                hintText: 'Email',
                                hintStyle: heading6.copyWith(color: textGrey),
                                border: OutlineInputBorder(
                                    borderSide: BorderSide.none
                                )
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
                            obscureText: !passwordConfirmVisible,
                            decoration: InputDecoration(
                                hintText: 'Password Confirmation',
                                hintStyle: heading6.copyWith(color: textGrey),
                                suffixIcon: IconButton(
                                  color: textGrey,
                                  splashRadius: 1,
                                  icon: Icon(passwordConfirmVisible ? Icons.visibility_outlined : Icons.voice_over_off_outlined),
                                  onPressed: () {
                                    setState(() {
                                      passwordConfirmVisible = !passwordConfirmVisible;
                                    });
                                  },
                                ),
                                border: OutlineInputBorder(borderSide: BorderSide.none)
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
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => LoginPage(),
                        ),
                      );
                    },
                    child: Text(
                        'Register',
                        style: heading5.copyWith(color: Colors.white)
                    ),
                  ),
                ),
                SizedBox(height: 50,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Already have an account? ',
                      style: regular16pt.copyWith(color: textGrey),
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: Text(
                        'Login',
                        style: regular16pt.copyWith(color: Colors.black54),
                      ),
                    )
                  ],
                )
              ],
            ),
          )
      ),
    );
  }
}