import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:stayfit/login_page.dart';
class Profile extends StatefulWidget {
  const Profile ({super.key});

  @override
  State<Profile> createState() => _ProfileState();
}
class _ProfileState extends State<Profile> {
  final user = FirebaseAuth.instance.currentUser!;
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<DocumentSnapshot>(
      future: FirebaseFirestore.instance.collection('users').doc(user.uid).get(),
      builder: (context, snapshot) {
      if(snapshot.connectionState ==ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator(),);
          } 
      if(snapshot.connectionState== ConnectionState.done)
      {
        Map<String, dynamic>? data = snapshot.data?.data() as Map<String, dynamic>?;
      return Scaffold(
            backgroundColor: Colors.blue[50],
            body: Column(
              children: [
                const SizedBox(
                  height: 40,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    CircleAvatar(
                      maxRadius: 65,
                      backgroundImage: NetworkImage("https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSGswH5ZgM0L8dIZkvv2OhQoH_teFoTWKFxWw&usqp=CAU"),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 15,
                ),
                
                const SizedBox(
                  height: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "${data? ['name']}",
                      style:
                          GoogleFonts.poppins(fontWeight: FontWeight.w500, fontSize: 26,color: Colors.black87),
                    )
                  ],
                ),
                const SizedBox(
                  height: 15,
                ),
                const SizedBox(
                  height: 15,
                ),
                Container(
                  child: Expanded(
                      child: ListView(
                    children: [
                      Card(
                        margin:
                            const EdgeInsets.only(left: 35, right: 35, bottom: 10),
                        color: Colors.white,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30),),
                        shadowColor: Colors.black,elevation:3,
                        child: ListTile(
                          leading: Icon(
                            Icons.assignment,
                            color: Colors.indigo[700],
                          ),
                          title: Text(
                            'Health Log',
                            style: GoogleFonts.poppins(
                                fontSize: 18, fontWeight: FontWeight.w600,color:Colors.indigo[700]),
                          ),
                          trailing: Icon(
                            Icons.arrow_forward_ios_outlined,
                            color: Colors.indigo[700],
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Card(
                        color: Colors.white,
                        margin:
                            const EdgeInsets.only(left: 35, right: 35, bottom: 10),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30)),
                        shadowColor: Colors.black,elevation:3,
                        child: ListTile(
                          leading: Icon(
                            Icons.bar_chart_rounded,
                            color: Colors.indigo[700],
                          ),
                          title: Text(
                            'Progress Report',
                            style: GoogleFonts.poppins(
                                fontSize: 18, fontWeight: FontWeight.w600,color:Colors.indigo[700]),
                          ),
                          trailing: Icon(
                            Icons.arrow_forward_ios_outlined,
                            color: Colors.indigo[700],
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Card(
                        color: Colors.white,
                        margin:
                            const EdgeInsets.only(left: 35, right: 35, bottom: 10),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30)),
                        shadowColor: Colors.black,elevation:3,
                        child:  ListTile(
                          leading:
                              Icon(Icons.help_outline, color: Colors.indigo[700]),
                          title: Text(
                            'Help & Support',
                            style: GoogleFonts.poppins(
                                fontSize: 18, fontWeight: FontWeight.w600,color:Colors.indigo[700]),
                          ),
                          trailing: Icon(
                            Icons.arrow_forward_ios_outlined,
                            color: Colors.indigo[700],
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Card(
                        color: Colors.white,
                        margin:
                            const EdgeInsets.only(left: 35, right: 35, bottom: 10),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30)),
                        shadowColor: Colors.black,elevation:3,
                        child: ListTile(
                          leading: Icon(
                            Icons.settings,
                            color: Colors.indigo[700],
                          ),
                          title: Text(
                            'Settings',
                            style: GoogleFonts.poppins(
                                fontSize: 18, fontWeight: FontWeight.w600,color:Colors.indigo[700]),
                          ),
                          trailing: Icon(Icons.arrow_forward_ios_outlined,color: Colors.indigo[700],),
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Card(
                        color: Colors.white,
                        margin:
                            const EdgeInsets.only(left: 35, right: 35, bottom: 10),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30)),
                        shadowColor: Colors.black,elevation:3,
                        child: GestureDetector(
                          onTap: (){
                            FirebaseAuth.instance.signOut();
                            Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (builder)=>LoginPage()));
                          },
                          child: ListTile(
                            leading: Icon(
                              Icons.logout,
                              color: Colors.indigo[700],
                            ),
                            title: Text(
                              'Logout',
                              style: GoogleFonts.poppins(
                                  fontSize: 18, fontWeight: FontWeight.w600,color:Colors.indigo[700]),
                            ),
                            trailing: Icon(Icons.arrow_forward_ios_outlined,
                              color: Colors.indigo[700],),
                          ),
                        ),
                      )
                    ],
                  )),
                )
              ],
            ),
          );
       }
       
          return Container(); 
      }
    );
  }
}