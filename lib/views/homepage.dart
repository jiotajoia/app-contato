import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("App de Contatos"),
        backgroundColor: Colors.yellow,
        automaticallyImplyLeading: false,
      ),
      body: Center(
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.all(20),
              child: Image(
                  image: NetworkImage(
                      "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSxcRVjeg_4VBl6L9DIpY2KPglLPA7ITm5Axw&s")),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                InkWell(
                  child: Container(
                      margin: EdgeInsets.all(20),
                      width: 140,
                      height: 140,
                      color: Colors.yellow,
                      child: Center(
                        child: Text("contatos"),
                      )),
                  onTap: () {
                    Navigator.pushNamed(context, "/contatos");
                  },
                ),

                InkWell(
                  child: Container(
                      margin: EdgeInsets.all(20),
                      width: 140,
                      height: 140,
                      color: Colors.yellow,
                      child: Center(
                        child: Text("mapas"),
                      )),
                  onTap: () {
                    Navigator.pushNamed(context, "/mapas");
                  },
                )
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,

              children: [
                InkWell(
                  child: Container(
                      margin: EdgeInsets.all(20),
                      width: 140,
                      height: 140,
                      color: Colors.yellow,
                      child: Center(
                        child: Text("extra"),
                      )),
                  onTap: () {
                    Navigator.pushNamed(context, "/");
                  },
                ),
                InkWell(
                  child: Container(
                      margin: EdgeInsets.all(20),
                      width: 140,
                      height: 140,
                      color: Colors.yellow,
                      child: Center(
                        child: Text("extra"),
                      )),
                  onTap: () {
                    Navigator.pushNamed(context, "/");
                  },
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}