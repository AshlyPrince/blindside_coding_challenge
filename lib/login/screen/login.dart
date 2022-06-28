/// /// /// /// /// /// /// /// /// /// /// /// /// /// /// /// /// /// /// ///
///Login screen to be displayed for the user to perform login
/// /// /// /// /// /// /// /// /// /// /// /// /// /// /// /// /// /// /// ///

import 'package:flutter/material.dart';

import '../../home_screen/home_screen.dart';
import '../../registration/screen/registration.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  late bool _passwordVisible = false;

  final formKey = GlobalKey<FormState>();

  late TextEditingController userNameController, passwordController;

  @override
  void initState() {
    _passwordVisible = false;
    userNameController = TextEditingController();
    passwordController = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

    return WillPopScope(
        onWillPop: () async => false,
        child: Container(
          decoration: const BoxDecoration(
            image: DecorationImage(
                image: AssetImage('assets/images/login_image.jpg'),
                fit: BoxFit.cover),
          ),
          child: Scaffold(
            backgroundColor: Colors.transparent,
            body: Stack(children: [
              Container(
                padding: EdgeInsets.only(left: width * 0.1, top: height * 0.2),
                child: const Text(
                  "Welcome",
                  style: TextStyle(color: Colors.white70, fontSize: 33),
                ),
              ),
              Container(
                padding:
                    EdgeInsets.only(left: width * 0.1, top: height * 0.255),
                child: const Text(
                  "Join and play your favourite videos here",
                  style: TextStyle(color: Colors.white70, fontSize: 13),
                ),
              ),
              SingleChildScrollView(
                child: Form(
                  key: formKey,
                  child: Container(
                    padding: EdgeInsets.only(
                        right: width * 0.1,
                        left: width * 0.1,
                        top: height * 0.45),
                    child: Column(children: [
                      TextFormField(
                        controller: userNameController,
                        style: const TextStyle(color: Colors.black54),
                        validator: (value) {
                          if (value != null && value.isEmpty) {
                            return "Please enter the username";
                          } else {
                            return null;
                          }
                        },
                        decoration: InputDecoration(
                          fillColor: Colors.grey.shade100,
                          filled: true,
                          hintText: 'Username',
                          hintStyle: const TextStyle(
                              fontSize: 17.0, color: Colors.black54),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      TextFormField(
                        controller: passwordController,
                        obscureText: !_passwordVisible ? true : false,
                        style: const TextStyle(color: Colors.black54),
                        validator: (value) {
                          if (value != null && value.isEmpty) {
                            return "Please enter the password";
                          } else if (value != null && value.length < 6) {
                            return "Password should be atleast 6 characters";
                          } else if (value != null && value.length > 15) {
                            return "Password should not be greater than 15 characters";
                          } else
                            return null;
                        },
                        decoration: InputDecoration(
                          fillColor: Colors.grey.shade100,
                          filled: true,
                          hintText: 'Password',
                          hintStyle: const TextStyle(
                              fontSize: 17.0, color: Colors.black54),
                          suffixIcon: !_passwordVisible
                              ? IconButton(
                                  icon: const Icon(
                                    Icons.visibility,
                                    color: Colors.black54,
                                  ),
                                  onPressed: () {
                                    setState(() {
                                      _passwordVisible = true;
                                    });
                                  },
                                )
                              : IconButton(
                                  icon: const Icon(
                                    Icons.visibility_off,
                                    color: Colors.black54,
                                  ),
                                  onPressed: () {
                                    setState(() {
                                      _passwordVisible = false;
                                    });
                                  },
                                ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      InkWell(
                        onTap: () {
                          final form = formKey.currentState;
                          if (form != null && form.validate()) {
                            form.save();
                            if (userNameController.text == 'Blindside' &&
                                passwordController.text == 'User123') {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => const HomePage(
                                    title: '',
                                  ),
                                ),
                              );
                            } else {
                              showAlertDialog(context);
                            }
                          } else {
                            print("Not Validated");
                          }
                        },
                        child: Container(
                          width: MediaQuery.of(
                            context,
                          ).size.width,
                          padding: const EdgeInsets.symmetric(
                            vertical: 15,
                          ),
                          alignment: Alignment.center,
                          decoration: const BoxDecoration(
                            borderRadius: BorderRadius.all(
                              Radius.circular(
                                15,
                              ),
                            ),
                            gradient: LinearGradient(
                              begin: Alignment.centerLeft,
                              end: Alignment.centerRight,
                              colors: [
                                Colors.grey,
                                Colors.grey,
                              ],
                            ),
                          ),
                          child: const Text(
                            'Login',
                            style: TextStyle(
                              fontSize: 20,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            TextButton(
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        const RegistrationPage(),
                                  ),
                                );
                              },
                              child: const Text(
                                'Register',
                                style: TextStyle(
                                  decoration: TextDecoration.underline,
                                  fontSize: 16,
                                  color: Colors.white70,
                                ),
                              ),
                            ),
                          ]),
                    ]),
                  ),
                ),
              ),
            ]),
          ),
        ));
  }

  showAlertDialog(BuildContext context) {
    // set up the button
    Widget okButton = TextButton(
      child: const Text("OK"),
      onPressed: () {
        Navigator.pop(context);
      },
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: const Text("Alert"),
      content: const Text("User does not exist"),
      actions: [
        okButton,
      ],
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }
}
