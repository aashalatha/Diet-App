/* /*import 'package:flutter/material.dart';
import 'package:stayfit/models/recipe_model.dart';
//import 'package:stayfit/services/api_service.dart';
import 'package:stayfit/widgets/recipe_card.dart';

class Recipes extends StatefulWidget {
  const Recipes({super.key});

  @override
  State<Recipes> createState() => _RecipesState();
}
class _RecipesState extends State<Recipes> {
  
  final _searchController = TextEditingController();
  late List<Food>? _recipes = [];

   void _searchRecipes() async {
    final query = _searchController.text;
    final recipes = await RecipeApi.searchRecipes(query);
    setState(() {
      _recipes = recipes;
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue[50],
      body: ListView(
        children: [
          Padding(
                padding:
                    const EdgeInsets.fromLTRB(15, 15, 15, 15),
                child: Container(
                  width: double.infinity,
                  height: 55,
                  padding: EdgeInsets.only(left: 10),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: const[
                      BoxShadow(
                        color: Color.fromARGB(255, 185, 185, 185),
                        offset: Offset(1, 1),
                        blurRadius: 15,
                      ),
                    ],
                  ),
                  child: TextField(
                    controller: _searchController,
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: 'Search your recipe',
                      icon: Icon(Icons.search),
                    ),
                  ),
                ),
              ),
          RecipeCard(title: "Low Calorie Butter Chicken",time:"100 min",cal: "1000cal",image: "https://healthyfitnessmeals.com/wp-content/uploads/2020/01/Butter-chicken-6.jpg",),
          RecipeCard(title: "Bread Sandwich",time:"100 min",cal: "1000cal",image: "https://sparkpeo.hs.llnwd.net/e1/resize/630m620/e4/nw/5/0/l503650298.jpg",),
          RecipeCard(title: "Idly",time:"100 min",cal: "1000cal",image: "https://www.chefspencil.com/wp-content/uploads/Idli-1-960x800.jpg.webp",),
          RecipeCard(title: "Appam",time:"100 min",cal: "1000cal",image: "https://cdn.cdnparenting.com/articles/2020/04/08124906/Appam-Recipe.webp",),
          RecipeCard(title: "Aviyal",time:"100 min",cal: "1000cal",image: "https://static.toiimg.com/thumb/61604457.cms?width=1200&height=900",),
          RecipeCard(title: "Grilled Chicken",time:"100 min",cal: "1000cal",image: "https://www.onceuponachef.com/images/2020/05/best-grilled-chicken-scaled.jpg",),
        ],
      ),
      /* ListView(
        children : [
          RecipeContainer()
        ]
      ), */
      /*CustomScrollView(
        slivers: [
          SliverPadding(
            padding: EdgeInsets.only(left: 15,right:15,top: 35),
            sliver: SliverToBoxAdapter(
              child: Container(
                    width: double.infinity,
                    height: 55,
                    padding: EdgeInsets.only(left: 10),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20),
                      boxShadow: [
                        BoxShadow(
                          color: Color.fromARGB(255, 185, 185, 185),
                          offset: Offset(1, 1),
                          blurRadius: 15,
                        ),
                      ],
                    ),
                    child: TextField(
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: 'Search your recipe',
                        hintStyle: GoogleFonts.poppins(fontSize: 15,color: Colors.black87,fontWeight: FontWeight.normal),
                        icon: Icon(Icons.search),
                      ),
                    ),
                  ),
            ),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text("Popular Category",
              style: GoogleFonts.poppins(fontSize: 15,color: Colors.black54,fontWeight: FontWeight.w700),),
            ),
          ),
          SliverPadding(
            padding: EdgeInsets.symmetric(horizontal: 15),
            sliver: SliverToBoxAdapter(
              child: Column(
                children: [
                  Container(
                    height: 50,
                    child: ListView.builder(
                      itemCount: 4,
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (context,index){
                      return Padding(
                        padding: const EdgeInsets.only(right:10),
                        child: GestureDetector(
                          onTap: (){
                            setState(() {
                              indexx = index;
                            });
                          },
                          child: Container(
                            margin: EdgeInsets.only(
                              top: 5,
                              bottom: 5,
                              left: index == 0 ? 4:0,
                            ),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              color: indexx == index? Colors.blue[100]:Colors.white,
                            ),
                            child: Center(
                              child: Padding(
                                padding: const EdgeInsets.symmetric(horizontal:17),
                                child: Text(
                                  category[index],
                                style: GoogleFonts.poppins(
                                  fontSize: 15,
                                  color: indexx == index? Colors.black:Colors.black54,
                                  fontWeight: FontWeight.w700
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      );
                    }),
                  ),
                  SizedBox(height: 15,),
                  Row(
                    children: [
                      Text('Popular',style: GoogleFonts.poppins(fontSize: 15,color: Colors.black54,fontWeight: FontWeight.w700)),
                    ],
                  ),
                ],
              ),
            ),
          ),
          SliverPadding(
            padding: EdgeInsets.symmetric(horizontal:15,vertical: 20 ),
            sliver: SliverGrid(
              delegate: SliverChildBuilderDelegate(
                (context, index) { 
                  return GestureDetector(
                    onTap: () {
                      RecipeDetails();
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        boxShadow: const [BoxShadow(
                          color: Colors.black26,
                          offset: Offset(1, 1),
                          blurRadius: 15,
                        ),
                        ],
                        borderRadius: BorderRadius.circular(20)
                      ),
                      child: Column(
                        children: [
                          SizedBox(
                            height: 10,
                          ),
                          Padding(
                            padding: const EdgeInsets.only(right:14),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: const [
                                Icon(Icons.favorite_border)
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 20,vertical: 15),
                            child: Container(
                              height: 120,
                              width: 120,
                              decoration: BoxDecoration(
                                image: DecorationImage(image: AssetImage(
                                        'images/${categoryname[indexx]}${index}.jpg'),
                                fit: BoxFit.cover,
                                ),
                                borderRadius: BorderRadius.circular(20),
                              ),
                            ),
                          ),
                          SizedBox(height: 20,),
                          Text(food[indexx][index],style: GoogleFonts.poppins(fontSize: 18,color: Colors.black87,fontWeight: FontWeight.w500),),
                          SizedBox(height: 10,),
                          Row(mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                            Text('100 min',style: GoogleFonts.poppins(fontSize: 15,color: Colors.grey,fontWeight: FontWeight.w500),),
                            Row(
                              children: [
                                Icon(Icons.star_border,color: Colors.grey,size: 15,),
                                Text("4.2")
                              ],
                            )
                          ],
                          )
                        ],
                      ),
                    ),
                  );
                },
                childCount: 4,
                ), 
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                mainAxisExtent: 270,
                crossAxisSpacing: 10,
                mainAxisSpacing: 10
                )
            ),
          )
        ],
      )*/
    );
  }
}
*/

import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:stayfit/models/recipe_model.dart';
import 'package:stayfit/services/api_service.dart';
import 'package:stayfit/ui/detailed_recipe.dart';

class RecipeSearchScreen extends StatefulWidget {
  const RecipeSearchScreen({Key? key}) : super(key: key);

  @override
  _RecipeSearchScreenState createState() => _RecipeSearchScreenState();
}

class _RecipeSearchScreenState extends State<RecipeSearchScreen> {
  //final _apiService = RecipeApi();
  final _searchController = TextEditingController();
  bool _isLoading = false;
  List<Recipe> _recipes = [];

  void _searchRecipes(String query) async {
    setState(() => _isLoading = true);
    log("object");
    try {
      final recipes = await RecipeApi.searchRecipes(query);
      setState(() => _recipes = recipes);
      log("success");
      print(_recipes);
    } catch (e) {
      log(e.toString());
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Failed to load recipes'),
          duration: Duration(seconds: 3),
        ),
      );
    } finally {
      setState(() => _isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Recipe Search'),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: TextField(
              controller: _searchController,
              decoration: InputDecoration(
                hintText: 'Search for a recipe',
                suffixIcon: IconButton(
                  icon: Icon(Icons.search),
                  onPressed: () => _searchRecipes(_searchController.text),
                ),
              ),
              onSubmitted: (_) => _searchRecipes(_searchController.text),
            ),
          ),
          if (_isLoading)
            Expanded(
              child: Center(
                child: CircularProgressIndicator(),
              ),
            ),
          if (!_isLoading && _recipes.isEmpty)
            Expanded(
              child: Center(
                child: Text('No recipes found'),
              ),
            ),
          if (!_isLoading && _recipes.isNotEmpty)
            Expanded(
              child: ListView.builder(
                itemCount: _recipes.length,
                itemBuilder: (context, index) {
                  final recipe = _recipes[index];
                  return ListTile(
                    leading: CachedNetworkImage(
                      imageUrl: recipe.image,
                      placeholder: (context, url) =>
                          CircularProgressIndicator(),
                      errorWidget: (context, url, error) => Icon(Icons.error),
                    ),
                    title: Text(recipe.label),
                    //subtitle: Text(recipe.ingredients),
                    onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => RecipeDetails(),
                      ),
                    ),
                  );
                },
              ),
            ),
        ],
      ),
    );
  }
} */
/*
import 'dart:developer';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:stayfit/services/api_service.dart';

import '../ui/detailed_recipe.dart';

class Recipes extends StatefulWidget {


  Recipes({super.key});

  @override
  State<Recipes> createState() => _RecipesState();
}

class _RecipesState extends State<Recipes> {
  late Future<List<Recipe>> futureRecipes;


  @override
  void initState() {
    super.initState();
    futureRecipes = RecipeService().getRecipe();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Search Recipes",style: GoogleFonts.poppins(color: Colors.black,fontWeight: FontWeight.bold,fontSize: 20),),
      backgroundColor: Colors.white,),
      backgroundColor: Colors.blue[50],
      body: RefreshIndicator(
        onRefresh: () async {
          var recipes = await RecipeService().getRecipe();
          setState(() {
            futureRecipes = Future.value(recipes);
          });
        } ,
        child: Center(
          child: FutureBuilder<List<Recipe>>(
            future:futureRecipes,
            builder: ((context,AsyncSnapshot snapshot){
              if(snapshot.hasData){
                return ListView.separated(
                  itemCount: snapshot.data!.length,
                  itemBuilder: (context,index){
                    Recipe recipe = snapshot.data?[index];
                    return ListTile(
                      leading: CachedNetworkImage(
                              imageUrl: recipe.image,
                              placeholder: (context, url) =>
                                  CircularProgressIndicator(),
                              errorWidget: (context, url, error) => Icon(Icons.error),
                            ),
                          title: Text(recipe.label),
                          subtitle: Text(recipe.calories.toString()),
                          onTap: ()=>openPage(context,recipe),
                          trailing: const Icon(Icons.chevron_right_outlined),
                        );
                      }, separatorBuilder: (BuildContext context, int index) { 
                        return Divider(color: Colors.black26,thickness:1);
                      },
                  );
              }
              else if(snapshot.hasError){
                return Text('ERROR:${snapshot.error}');
              }
              return const CircularProgressIndicator();
            })),
        ),
      )
    );
  }

  openPage(context,Recipe recipe){
    Navigator.push(context,MaterialPageRoute(builder: (context)=> DetailsPage(recipe: recipe,)));
  }
} */


import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:stayfit/services/api_service.dart';
import 'package:stayfit/ui/detailed_recipe.dart';
import 'package:stayfit/models/recipe_model.dart';

class RecipeSearchScreen extends StatefulWidget {
  const RecipeSearchScreen({Key? key}) : super(key: key);

  @override
  _RecipeSearchScreenState createState() => _RecipeSearchScreenState();
}

class _RecipeSearchScreenState extends State<RecipeSearchScreen> {
  //final _apiService = RecipeApi();
  final _searchController = TextEditingController();
  bool _isLoading = false;
  late Future<List<Recipe>> futureRecipes;
  List<Recipe> _recipes = [];
  

  void _searchRecipes(String query) async {
    setState(() => _isLoading = true);
    try {
      final recipes = await RecipeService.getRecipe(query);
      setState(() => _recipes = recipes);
      print(_recipes);
    } catch (e) {
      log(e.toString());
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Failed to load recipes'),
          duration: Duration(seconds: 3),
        ),
      );
    } finally {
      setState(() => _isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Search Recipes",style: GoogleFonts.poppins(color: Colors.black,fontWeight: FontWeight.bold,fontSize: 20),),
      backgroundColor: Colors.white,
      automaticallyImplyLeading: false,),
      backgroundColor: Colors.blue[50],
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: TextField(
              controller: _searchController,
              decoration: InputDecoration(
                hintText: 'Search for a recipe',
                suffixIcon: IconButton(
                  icon: Icon(Icons.search),
                  onPressed: () => _searchRecipes(_searchController.text),
                ),
              ),
              onSubmitted: (_) => _searchRecipes(_searchController.text),
            ),
          ),
          if (_isLoading)
            Expanded(
              child: Center(
                child: CircularProgressIndicator(),
              ),
            ),
          if (!_isLoading && _recipes.isEmpty)
            Expanded(
              child: Center(
                child: Text('No recipes found'),
              ),
            ),
          if (!_isLoading && _recipes.isNotEmpty)
            Expanded(
              child: ListView.separated(separatorBuilder: (context, index) {
                return Divider(color: Colors.black26,thickness:1);
              },
                itemCount: _recipes.length,
                itemBuilder: (context, index) {
                  final recipe = _recipes[index];
                  return ListTile(
                    //shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                    leading: CachedNetworkImage(
                      imageUrl: recipe.image,
                      placeholder: (context, url) =>
                          CircularProgressIndicator(),
                      errorWidget: (context, url, error) => Icon(Icons.error),
                    ),
                    title: Text(recipe.label,style: GoogleFonts.poppins(color: Colors.black,fontWeight: FontWeight.w600,fontSize: 15),),
                    subtitle: Text('🔥 ${recipe.calories.toStringAsPrecision(4)}',style: GoogleFonts.poppins(),),
                    onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => DetailsPage(recipe: recipe,),
                      ),
                    ),
                  );
                },
              ),
            ),
        ],
      ),
    );
  }
} 