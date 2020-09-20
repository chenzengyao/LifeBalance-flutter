import 'package:flutter/material.dart';
import 'package:lifebalance/screens/services/wrapper.dart';

class LandingPageNew extends StatefulWidget {
  @override
  _LandingPageStateNew createState() => _LandingPageStateNew();
}

class _LandingPageStateNew extends State<LandingPageNew> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        fontFamily: "Roboto"
      ),
      home: Scaffold(
        body: Stack (
          children: <Widget>[
            GestureDetector(
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => Wrapper()));
              }
            ),
            Container(
              margin: const EdgeInsets.only(left: 50.0, bottom: 80.0),
              child: GestureDetector(
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => Wrapper()));
                },
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Container(
                      child: Text(
                        "The", style: TextStyle(fontSize: 40)
                        ),
                    ),
                    Container(
                      child: Text(
                        "Friendly", style: TextStyle(fontSize: 40)
                        ),
                    ),
                    Container(
                      child: Text(
                        "Planner.", style: TextStyle(fontSize: 40)
                        ),
                    )
                  ]
                ) 
              )  
            )
          ],
        )
      ),
    );
  }
}
