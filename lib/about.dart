import 'package:flutter/material.dart';


import 'package:google_fonts/google_fonts.dart';

const String testDevice = 'MobileId';

class about extends StatelessWidget {







  @override

  Widget build(BuildContext context) {

    return Scaffold(

      extendBodyBehindAppBar: true,
      backgroundColor: Colors.grey,


      body:




      Container(


        decoration: new BoxDecoration(
          image: new DecorationImage(
            image: new AssetImage('assets/about.png'),
            fit: BoxFit.cover,
          ),
        ),



        padding: EdgeInsets.all(11.0),
        child: Column(


            children: [
              SizedBox(height: 15),


              SizedBox(height: 20),
            Text.rich(
                TextSpan(text: "This app helps you to focus and focus is important because it is the gateway to all thinking: perception, memory, learning, reasoning, problem-solving, and decision making. Without good focus, all aspects of your ability to think will suffer. With this app, you can concentrate on what is important by feeding the energy of your focus to the plant."),
              style: GoogleFonts.comicNeue(fontSize: 18,color: Colors.black,fontWeight: FontWeight.bold),
              ),


              SizedBox(height: 100),

             Text.rich(
                TextSpan(text: "by fouxa.com "),
                style: new TextStyle(
                  fontWeight: FontWeight.bold,


                  fontSize:12, color: Colors.blueAccent,
                ),
              ),





            ]



        ),


      ),










    );
  }
}

