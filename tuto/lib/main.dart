import 'dart:convert';
import 'package:tuto/item.dart';
import 'package:tuto/user.dart';
import 'package:tuto/itemDetail.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Good Food',
      theme: ThemeData.light(),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var screenHeight = MediaQuery.of(context).size.height;
    var screenWidth = MediaQuery.of(context).size.width;
    List<ItemMenu> list = [];
    return Scaffold(
      body: Container(
        height: screenHeight,
        width: screenWidth,
        child: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.fromLTRB(10, 8, 10, 2),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      IconButton(icon: Icon(Icons.menu), onPressed: () {}),
                      Text(
                        "Good Food",
                        style: TextStyle(fontSize: 22),
                      ),
                    ],
                  ),
                ),
                Center(
                  child: Text("Bienvenue Chez Good Food"),
                ),
                Center(
                  child: Text(
                      "Passer vos commandes de plats en un seul click c'est menu sont disponibles tout les jours"),
                ),
                Center(
                  child: Text("Liste des menu"),
                ),
                Container(
                  height: screenHeight / 1.2,
                  child: FutureBuilder(
                    future: DefaultAssetBundle.of(context)
                        .loadString('assets/data.json'),
                    builder: (context, snapshot) {
                      var dataN = jsonDecode(snapshot.data.toString());
                      if (snapshot.hasData) {
                        return ListView.builder(
                          shrinkWrap: true,
                          itemBuilder: (context, index) {
                            String finalString = "";
                            List<dynamic> datalist = dataN[index]["placeItems"];
                            datalist.forEach((item) {
                              finalString = finalString + item + " | ";
                            });
                            ItemMenu itemMenu = new ItemMenu(
                                dataN[index]["placeImage"],
                                dataN[index]["placeName"],
                                finalString,
                                dataN[index]["prix"]);
                            list.add(itemMenu);
                            return ElevatedButton(
                              onPressed: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            ItemDetail(item: list[index])));
                              },
                              style: ElevatedButton.styleFrom(
                                minimumSize: Size.zero, // Set this
                                padding: EdgeInsets.all(0), // and this
                              ),
                              child: Card(
                                child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: <Widget>[
                                      Padding(
                                        padding: EdgeInsets.all(8.0),
                                        child: Container(
                                          decoration: BoxDecoration(
                                            color: Colors.white38,
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(15)),
                                            boxShadow: [
                                              BoxShadow(
                                                color: Colors.black,
                                                spreadRadius: 1.0,
                                                blurRadius: 3.0,
                                              )
                                            ],
                                          ),
                                          child: Row(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            mainAxisSize: MainAxisSize.max,
                                            children: [
                                              ClipRRect(
                                                borderRadius: BorderRadius.all(
                                                    Radius.circular(15)),
                                                child: new Image.asset(
                                                  dataN[index]['placeImage'],
                                                  width: 70,
                                                  height: 70,
                                                  fit: BoxFit.cover,
                                                ),
                                              ),
                                              SizedBox(
                                                width: 210,
                                                child: Padding(
                                                  padding: EdgeInsets.fromLTRB(
                                                      2, 3, 0, 0),
                                                  child: Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      Padding(
                                                        padding:
                                                            EdgeInsets.fromLTRB(
                                                                0, 0, 0, 10),
                                                        child: Text(
                                                          dataN[index]
                                                              ['placeName'],
                                                          style: TextStyle(
                                                              fontSize: 18),
                                                        ),
                                                      ),
                                                      Text(
                                                        "Prix min: ${dataN[index]['prix']}",
                                                        style: TextStyle(
                                                            fontSize: 12,
                                                            color:
                                                                Colors.white),
                                                        maxLines: 1,
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ]),
                              ),
                            );
                          },
                          itemCount: dataN == null ? 0 : dataN.length,
                        );
                      } else {
                        return CircularProgressIndicator(
                          color: Colors.black,
                        );
                      }
                    },
                  ),
                )
              ],
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.black,
        hoverColor: Colors.white,
        onPressed: () {},
        child: Icon(
          Icons.shopping_basket,
        ),
      ),
    );
  }
}
