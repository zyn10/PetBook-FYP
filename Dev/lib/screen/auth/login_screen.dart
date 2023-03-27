import 'package:flutter/material.dart';
import 'package:petbook/resources/auth_methods.dart';
import 'package:petbook/screen/auth/signup_screen.dart';
import 'package:petbook/utils/utils.dart';
import '../../responsive/mobile_screen_layout.dart';
import '../../responsive/responsive_layout.dart';
import '../../responsive/web_screen_layout.dart';

class OurLogin extends StatefulWidget {
  const OurLogin({super.key});

  @override
  State<OurLogin> createState() => _OurLoginState();
}

class _OurLoginState extends State<OurLogin> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _isLoading = false;
  @override
  void dispose() {
    super.dispose();
    _emailController.dispose();
    _passwordController.dispose();
  }

  void loginUserFun() async {
    setState(() {
      _isLoading = true;
    });
    String res = await AuthMethods().loginUser(
        email: _emailController.text, password: _passwordController.text);
    if (res == "success") {
      setState(() {
        _isLoading = false;
      });
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (context) => const ResponsiveLayout(
              webScreenLayout: WebScreenLayout(),
              mobileScreenLayout: MobileScreenLayout()),
        ),
      );
    } else {
      setState(() {
        _isLoading = false;
      });
      // ignore: use_build_context_synchronously
      showSnackBar(context, res);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 32),
          width: double.infinity,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.all(30.0),
                child: Image.asset("assets/main.png"),
              ),

              const SizedBox(
                height: 15,
              ),

              //!EMAIL
              TextFormField(
                controller: _emailController,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter email';
                  } else if (!value.contains('@')) {
                    return 'Please enter a valid email';
                  }
                  return null;
                },
                decoration: const InputDecoration(
                  prefixIcon: Icon(Icons.alternate_email),
                  hintText: "Email",
                  errorStyle: TextStyle(color: Colors.redAccent, fontSize: 15),
                ),
              ),

              const SizedBox(
                height: 20.0,
              ),

              //!Password Validation

              TextFormField(
                controller: _passwordController,
                decoration: const InputDecoration(
                  prefixIcon: Icon(Icons.password),
                  hintText: "Password",
                  errorStyle: TextStyle(color: Colors.redAccent, fontSize: 15),
                ),
                obscureText: true,
              ),
              const SizedBox(
                height: 5.0,
              ),

              // Row(
              //   mainAxisAlignment: MainAxisAlignment.end,
              //   children: [
              //     TextButton(
              //       onPressed: () {
              //         // Navigator.of(context).push(
              //         //   MaterialPageRoute(
              //         //     builder: (BuildContext context) {
              //         //       return const OurForgetPassword();
              //         //     },
              //         //   ),
              //         // );
              //       },
              //       child: const Text(
              //         'Forgot Password ?',
              //         textAlign: TextAlign.left,
              //         style: TextStyle(
              //           color: Color.fromARGB(255, 133, 133, 133),
              //           fontSize: 14,
              //         ),
              //       ),
              //     ),
              //   ],
              // ),

              Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 20, top: 10),
                    child: ElevatedButton(
                      // onPressed: () {
                      //   // if (_formKey.currentState!.validate()) {
                      //   //   setState(() {
                      //   //     email = _emailController.text;
                      //   //     password = _passwordController.text;
                      //   //   });
                      //   //   userLogin();
                      //   // }
                      // },
                      onPressed: loginUserFun,
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.orange,
                          foregroundColor: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          minimumSize: const Size(300, 50)),
                      child: _isLoading
                          ? const Center(
                              child: CircularProgressIndicator(
                                color: Colors.white,
                              ),
                            )
                          : const Text('Log In'),
                    ),
                  ),
                ],
              ),

              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text("Don't have an account? "),
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).pushReplacement(
                        MaterialPageRoute(
                          builder: (BuildContext context) {
                            return const OurSignUp();
                          },
                        ),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                        minimumSize: const Size(100, 40)),
                    child: const Text(
                      "Sign up here",
                      style: TextStyle(
                        color: Color.fromARGB(255, 133, 133, 133),
                        fontSize: 14,
                      ),
                    ),
                  ),
                ],
              ),
//Transition to signup
            ],
          ),
        ),
      ),
    );
  }
}
