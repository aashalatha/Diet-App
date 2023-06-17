import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:stayfit/models/recipe_model.dart';
import 'package:stayfit/ui/recipes.dart';


class DetailsPage extends StatefulWidget {
  final Recipe recipe;
  DetailsPage({super.key,required this.recipe} );
    
  @override
  State<DetailsPage> createState() => _DetailsPageState();
}

class _DetailsPageState extends State<DetailsPage> {
  
  late String finalUrl;

  @override
  void initState(){
    if(widget.recipe.url.toString().contains("http://")){
      finalUrl = widget.recipe.url.toString().replaceAll("http://", "https://");
    }
    else
    {
      finalUrl = widget.recipe.url.toString();
    }
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title:Text(widget.recipe.label,style: GoogleFonts.poppins(color: Colors.black,fontWeight: FontWeight.w600,fontSize: 20),),
            backgroundColor: Colors.white,
            iconTheme: IconThemeData(color: Colors.black),),
      body: Column(
        children: [
          Expanded(child: WebViewWidget(
            controller: WebViewController()
            ..setJavaScriptMode(JavaScriptMode.unrestricted)
            ..loadRequest(Uri.parse(finalUrl)),
            )
          )
        ],
      ),
    );
  }

  openPage(context){
    Navigator.push(context,MaterialPageRoute(builder: (context)=>  RecipeSearchScreen()));
  }
}