

import 'package:flutter/material.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  TextEditingController emailControler = TextEditingController();
  TextEditingController senhaControler = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child:  Center(
        child: Column(
          children: [
            Container(
              margin: EdgeInsets.all(80),
              child: Image(
                  image: NetworkImage(
                      "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSxcRVjeg_4VBl6L9DIpY2KPglLPA7ITm5Axw&s")),
            ),
            Container(
              margin: EdgeInsets.all(20),
              child: Column(
                children: [
                  TextFormField(
                    controller: emailControler,
                    keyboardType: TextInputType.emailAddress,
                    decoration: InputDecoration(
                      labelText: "Email",
                      border: OutlineInputBorder()
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  TextFormField(
                    obscureText: true,
                    controller: senhaControler,
                    keyboardType: TextInputType.visiblePassword,
                    decoration: InputDecoration(
                      labelText: "Senha",
                      border: OutlineInputBorder()
                    ),
                  ),
                ],
              ),
            ),

            InkWell(
              child: Container(
                color: Colors.yellow,
                height: 50,
                width: 300,
                child: Center(
                  child: Text("Entrar"),
                ),
              ),              
              onTap: () {
                  Navigator.pushNamed(context, "/homepage");
                },
            )
            

          ],
        ),
      ) ,
      )
    );
  }
}
