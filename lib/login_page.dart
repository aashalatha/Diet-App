import 'package:stayfit/ui/homepage.dart';
import 'package:stayfit/signup_page.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:stayfit/utils/auth_methods.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _isLoading = false;
  final _formKey = GlobalKey<FormState>();

  void login() async {
    if (_formKey.currentState!.validate()) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Processing Data')),
      );
    }
    setState(() {
      _isLoading = true;
    });

    String res = await AuthMethods().loginUser(
        email: _emailController.text, password: _passwordController.text);
    if (res == 'success') {
      Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (_) => HomePage()));
    } else {
      print('failed login');
    }
    setState(() {
      _isLoading = false;
    });
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: Colors.blue[50],
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10.0),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Stack(
                  children: [
                    Container(
                      padding: const EdgeInsets.fromLTRB(15.0, 180.0, 0.0, 0.0),
                      child: Text(
                        'Stay',
                        style: GoogleFonts.poppins(
                          fontSize: 60.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    /* Container(
                      padding: const EdgeInsets.fromLTRB(15.0, 160.0, 0.0, 0.0),
                      child:  Text(
                        'Fit',
                        style: GoogleFonts.poppins(
                          fontSize: 50.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ), */
                    Container(
                      padding:
                          const EdgeInsets.fromLTRB(145.0, 180.0, 0.0, 0.0),
                      child:  Text(
                        'Fit',
                        style: GoogleFonts.poppins(
                            fontSize: 60.0,
                            fontWeight: FontWeight.bold,
                            color: Colors.indigo[700]),
                      ),
                    ),
                  ],
                ),
                Container(
                  padding:
                      const EdgeInsets.only(top: 35.0, left: 20.0, right: 20.0),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      // ignore: prefer_const_literals_to_create_immutables
                      children: [
                        TextFormField(
                          validator: (valuemail) {
                            if (valuemail!.length<5) {
                              return 'Invalid Email';
                            }
                            if(!RegExp(
                                    r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+.[a-zA-Z]+")
                                .hasMatch(valuemail)){
                                  return 'Invalid Email';
                                }
                            return null;
                            
                          },
                          controller: _emailController,
                          textInputAction: TextInputAction.done,
                          keyboardType: TextInputType.emailAddress,
                          decoration:  InputDecoration(
                            filled: true,
                            fillColor: Colors.white,
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10.0)
                            ),
                            labelText: 'Email',
                            labelStyle: GoogleFonts.poppins(
                                fontWeight: FontWeight.bold,
                                color: Colors.grey),
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        TextFormField(
                          validator:(valuepassword) {
                            if (valuepassword!.length < 6) {
                              return 'Invalid Password';
                            }
                            return null;
                          }, 
                          obscureText: true,
                          controller: _passwordController,
                          decoration: InputDecoration(
                            filled: true,
                            fillColor: Colors.white,
                            border: OutlineInputBorder(borderSide: BorderSide(color: Colors.black12),
                              borderRadius: BorderRadius.circular(10.0)),
                            labelText: 'Password',
                            labelStyle: GoogleFonts.poppins(
                                fontWeight: FontWeight.bold,
                                color: Colors.grey),
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        GestureDetector(
                          onTap: () {
                            // Navigator.push(
                            //   context,
                            //   MaterialPageRoute(
                            //     builder: (context) {
                            //       return ResetPassword();
                            //     },
                            //   ),
                            // );
                          },
                          child: Container(
                            alignment: const Alignment(1.0, 0.0),
                            padding:
                                const EdgeInsets.only(top: 15.0, left: 20.0),
                            child:  InkWell(
                              child: Text(
                                'Forgot password??',
                                style: GoogleFonts.poppins(
                                    color: Colors.black54,
                                    fontSize: 20,
                                    fontWeight: FontWeight.w500,
                                    decoration: TextDecoration.underline),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 60,
                        ),
                        SizedBox(
                          height: 60.0,
                          child: Material(
                            borderRadius: BorderRadius.circular(10.0),
                            color: Colors.indigo[700],
                            elevation: 0,
                            child: GestureDetector(
                              onTap: login,
                              child: Center(
                                child: _isLoading
                                    ? Center(
                                        child: CircularProgressIndicator(
                                          color: Colors.white,
                                        ),
                                      )
                                    : Text(
                                        'LOGIN',
                                        style: GoogleFonts.poppins(
                                          fontSize: 20,
                                          color: Colors.white,
                                          fontWeight: FontWeight.w600
                                          ),
                                      ),
                              ),
                            ),
                          ),
                        ),
                        
                      ],
                    ),
                  ),
                ),
                const SizedBox(
                  height: 10.0,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'New here?',
                      style: GoogleFonts.poppins(
                          color: Colors.black,
                          fontSize: 18
                        ),
                    ),
                    const SizedBox(
                      width: 5.0,
                    ),
                    InkWell(
                      onTap: () => Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (_) => SignupPage(),
                        ),
                      ),
                      child: Text(
                        'Join us',
                        style: GoogleFonts.poppins(
                          color: Colors.blue,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          decoration: TextDecoration.underline,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ));
  }
}
