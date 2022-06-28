/// /// /// /// /// /// /// /// /// /// /// /// /// /// /// /// /// /// /// ///
///Registration screen to be displayed for the user to register
/// /// /// /// /// /// /// /// /// /// /// /// /// /// /// /// /// /// /// ///

import 'package:flutter/material.dart';
import 'package:untitled/login/screen/login.dart';

class RegistrationPage extends StatefulWidget {
  const RegistrationPage({Key? key, this.title}) : super(key: key);

  final String? title;

  @override
  _RegistrationPageState createState() => _RegistrationPageState();
}

class _RegistrationPageState extends State<RegistrationPage> {
  late bool _passwordVisible, _confirmPasswordVisible;
  late TextEditingController nameController,
      emailController,
      passwordController,
      confirmPassController;

  Future<bool> _onWillPop() async {
    return false;
  }

  @override
  void initState() {
    _passwordVisible = false;
    _confirmPasswordVisible = false;
    nameController = TextEditingController();
    emailController = TextEditingController();
    passwordController = TextEditingController();
    confirmPassController = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    return WillPopScope(
        onWillPop: () async {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const LoginPage(),
            ),
          );
          return false;
        },
        child: Scaffold(
          appBar: AppBar(
            elevation: 2,
            backgroundColor: Colors.transparent,
            flexibleSpace: const Image(
              image: AssetImage('assets/images/login_image.jpg'),
              fit: BoxFit.cover,
            ),
            title: const Text("Register"),
            leading: GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const LoginPage(),
                  ),
                );
              },
              child: const Icon(
                Icons.arrow_back_ios, // add custom icons also
              ),
            ),
          ),
          body: SafeArea(
            child: Container(
              color: Colors.black54,
              height: height,
              child: Stack(
                children: <Widget>[
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          SizedBox(height: height * 0.06),
                          Column(
                            children: <Widget>[
                              Container(
                                margin: const EdgeInsets.symmetric(
                                  vertical: 10,
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    TextField(
                                      controller: nameController,
                                      style: const TextStyle(
                                          color: Colors.black54),
                                      textAlign: TextAlign.start,
                                      obscureText: false,
                                      decoration: InputDecoration(
                                        hintText: "Name",
                                        hintStyle: const TextStyle(
                                            fontSize: 17.0,
                                            color: Colors.black54),
                                        suffixIcon: const Icon(
                                          Icons.person,
                                          color: Colors.black54,
                                        ),
                                        border: OutlineInputBorder(
                                          borderRadius: BorderRadius.circular(
                                            15,
                                          ),
                                        ),
                                        fillColor: const Color(
                                          0xfff3f3f4,
                                        ),
                                        filled: true,
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 30,
                                    ),
                                    TextField(
                                      controller: emailController,
                                      style: const TextStyle(
                                          color: Colors.black54),
                                      textAlign: TextAlign.start,
                                      obscureText: false,
                                      decoration: InputDecoration(
                                        hintText: "Email",
                                        hintStyle: const TextStyle(
                                            fontSize: 17.0,
                                            color: Colors.black54),
                                        suffixIcon: const Icon(
                                          Icons.email,
                                          color: Colors.black54,
                                        ),
                                        border: OutlineInputBorder(
                                          borderRadius: BorderRadius.circular(
                                            15,
                                          ),
                                        ),
                                        fillColor: const Color(
                                          0xfff3f3f4,
                                        ),
                                        filled: true,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Container(
                                margin: const EdgeInsets.symmetric(
                                  vertical: 10,
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    TextField(
                                      controller: passwordController,
                                      style: const TextStyle(
                                          color: Colors.black54),
                                      textAlign: TextAlign.start,
                                      obscureText:
                                          !_passwordVisible ? true : false,
                                      decoration: InputDecoration(
                                        hintText: "Password",
                                        hintStyle: const TextStyle(
                                            fontSize: 17.0,
                                            color: Colors.black54),
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
                                          borderRadius: BorderRadius.circular(
                                            15,
                                          ),
                                        ),
                                        fillColor: const Color(
                                          0xfff3f3f4,
                                        ),
                                        filled: true,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Container(
                                margin: const EdgeInsets.symmetric(
                                  vertical: 10,
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    TextField(
                                      controller: confirmPassController,
                                      style: const TextStyle(
                                          color: Colors.black54),
                                      textAlign: TextAlign.start,
                                      obscureText: !_confirmPasswordVisible
                                          ? true
                                          : false,
                                      decoration: InputDecoration(
                                        hintText: "Confirm Password",
                                        hintStyle: const TextStyle(
                                            fontSize: 17.0,
                                            color: Colors.black54),
                                        suffixIcon: !_confirmPasswordVisible
                                            ? IconButton(
                                                icon: const Icon(
                                                  Icons.visibility,
                                                  color: Colors.black54,
                                                ),
                                                onPressed: () {
                                                  setState(() {
                                                    _confirmPasswordVisible =
                                                        true;
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
                                                    _confirmPasswordVisible =
                                                        false;
                                                  });
                                                },
                                              ),
                                        border: OutlineInputBorder(
                                          borderRadius: BorderRadius.circular(
                                            15,
                                          ),
                                        ),
                                        fillColor: const Color(
                                          0xfff3f3f4,
                                        ),
                                        filled: true,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          Container(
                              width: MediaQuery.of(context).size.width,
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
                              child: InkWell(
                                onTap: () {},
                                child: const Text(
                                  'Register Now',
                                  style: TextStyle(
                                    fontSize: 20,
                                    color: Colors.white,
                                  ),
                                ),
                              )),
                          const SizedBox(
                            height: 30,
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ));
  }
}
