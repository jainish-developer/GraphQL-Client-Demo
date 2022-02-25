import 'package:flutter/material.dart';
import 'package:graphql_demo/provider/api_provider.dart';
import 'package:graphql_demo/screen/details.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
    Provider.of<CharacterAPIProvider>(context, listen: false).fetchData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
        ),
        body: buildItem());
  }

  Widget buildItem() {
    return Padding(
      padding: const EdgeInsets.only(top: 8.0, left: 8.0, right: 8),
      child: Consumer<CharacterAPIProvider>(
        builder: (context, characterProvider, child) {
          print(
            characterProvider.characters?.toJson()["data"]["characters"]["results"].length,
          );
          return characterProvider.characters!.toJson().isEmpty
              ? const Center(child: CircularProgressIndicator())
              : GridView.builder(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 5,
                      mainAxisSpacing: 5),
                      itemCount: characterProvider.characters?.toJson()["data"]["characters"]["results"].length,
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>  DetailView(images: characterProvider.characters
                                            ?.toJson()["data"]["characters"]["results"][index]["image"],name: characterProvider.characters
                                            ?.toJson()["data"]["characters"]["results"][index]["name"],index: index,),
                            ));
                      },
                      child: Container(
                          decoration: BoxDecoration(
                            image: DecorationImage(image: NetworkImage("${characterProvider.characters
                                            ?.toJson()["data"]["characters"]["results"][index]["image"]}")),
                              color: Colors.blue,
                              borderRadius: BorderRadius.circular(10)),
                          child: Align(
                            alignment: Alignment.bottomCenter,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Container(
                                  width: double.infinity,
                                  decoration:  BoxDecoration(
                                    
                                      borderRadius: const BorderRadius.only(
                                          bottomLeft: Radius.circular(10),
                                          bottomRight: Radius.circular(10)),
                                      gradient: const LinearGradient(
                                          colors: [
                                            Colors.black,
                                            Colors.black38,
                                          ],
                                          begin: Alignment.bottomCenter,
                                          end: Alignment.topCenter)),
                                  child: Padding(
                                    padding: EdgeInsets.all(5.0),
                                    child: Center(
                                      child: Text(
                                        characterProvider.characters
                                            ?.toJson()["data"]["characters"]["results"][index]["name"],
                                        style: TextStyle(
                                            fontSize: 18,
                                            //  fontWeight: FontWeight.bold,
                                            color: Colors.white),
                                            textAlign: TextAlign.center,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          )),
                    );
                  });
        },
      ),
    );
  }
}
