import 'dart:developer';
import 'package:stayfit/ui/user_details.dart';
import 'package:stayfit/utils/auth_methods.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';


class SignupPage extends StatefulWidget {
  const SignupPage({Key? key}) : super(key: key);

  @override
  State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  bool _isLoading = false;
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _nameController = TextEditingController();
  final _formKey = GlobalKey<FormState>();


  Future signUp() async {
      if (_formKey.currentState!.validate()) {
        setState(() {
          _isLoading=true;
        });
        ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Processing Data')),
          );
      }  
    String res = await AuthMethods().signupUser(
      email: _emailController.text.trim(),
      password: _passwordController.text.trim(),
    
      name: _nameController.text.trim());
    //   if (res == 'success') {
    //   Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (_) => LoginPage()));
    // } else {
    //   log('failed login');
    // }
    setState(() {
      _isLoading = false;
    });
      
  Navigator.of(context).pushReplacement(
      MaterialPageRoute(builder: (_) => UserDetails())); 
  }
  // void googleSignup(AuthMethods provider) async {
  //     final msg = await provider.googleSignUp();
  //     if (msg == '') return;
  //     ScaffoldMessenger.of(context).hideCurrentSnackBar();
  //     ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(msg)));
  // }
  @override 
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    //_confirmPassword.dispose();
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
              padding: EdgeInsets.only(top: 35.0, left: 20.0, right: 20.0),
              child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    TextFormField(
                      validator: (valuename) {
                            if (valuename!.isEmpty) {
                              return 'Invalid Name';
                            }
                            return null;
                          },
                      controller: _nameController,
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: Colors.white,
                        border: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.red),
                          borderRadius: BorderRadius.circular(10.0)),
                        labelText: 'Name',
                        labelStyle: GoogleFonts.poppins(
                            fontWeight: FontWeight.bold, color: Colors.grey),
                      ),
                    ),
                    
                    SizedBox(
                      height: 9,
                    ),
                    
                    TextFormField(
                      validator: (valuemail) {
                            if (valuemail!.length <= 5 ) {
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
                      keyboardType: TextInputType.emailAddress,
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: Colors.white,
                        border: OutlineInputBorder(borderRadius: BorderRadius.circular(10.0)),
                        labelText: 'Email',
                        labelStyle: GoogleFonts.poppins(
                            fontWeight: FontWeight.bold, color: Colors.grey),
                      ),
                    ),
                    SizedBox(
                      height: 9,
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
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.0)),
                        labelText: 'Password',
                        labelStyle: GoogleFonts.poppins(
                            fontWeight: FontWeight.bold, color: Colors.grey),
                      ),
                    ),
                    SizedBox(
                      height: 9,
                    ),
                    SizedBox(
                      height: 9,
                    ),
                    
                    SizedBox(
                      height: 9,
                    ),
                    SizedBox(
                      height: 60.0,
                      child: Material(
                        borderRadius: BorderRadius.circular(10.0),
                        color: Colors.indigo[700],
                        elevation: 0,
                        child: GestureDetector(
                          onTap: signUp,
                          child: Center(
                            child: _isLoading
                                      ? Center(
                                          child: CircularProgressIndicator(
                                            color: Colors.white,
                                          ),
                                        )
                                      : Text(
                                          'SIGN UP',
                                          style:  GoogleFonts.poppins(
                                            fontSize: 20,
                                            color: Colors.white,
                                            fontWeight: FontWeight.w600
                                            ),
                                        ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 9.0,
                    ),
                    Padding(padding: EdgeInsets.only(top: 20)),
                  /* Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const[
                      Text("________________________________________________________________",
                      style: TextStyle(color: Colors.black38,fontWeight: FontWeight.bold),),
                    ],
                  ),
                  Padding(padding: EdgeInsets.only(top: 15)),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(style:GoogleFonts.poppins(fontSize: 15),"Connect with google")
                    ],
                  ),
                  Padding(padding: EdgeInsets.only(top: 15)),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      GestureDetector(
                      onTap: () => googleSignup(AuthMethods()),
                  child: const Icon(FontAwesomeIcons.google,color: Colors.black,))
                  //const Image(width: 100, image: AssetImage('assets/google.png'))),
                    ],
                  ) */
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    ));
  }
}