import 'package:focustimekeeperapp/about.dart';


import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:async';
import 'package:google_fonts/google_fonts.dart';
import 'package:sleek_circular_slider/sleek_circular_slider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:provider/provider.dart';
import 'package:focustimekeeperapp/theme.dart';
import 'package:flutter/services.dart';
class SharedPrefs {
  static SharedPreferences _sharedPrefs;

  factory SharedPrefs() => SharedPrefs._internal();

  SharedPrefs._internal();

  Future<void> init() async {
    _sharedPrefs ??= await SharedPreferences.getInstance();
  }

  String get username => _sharedPrefs.getString(keyUsername) ?? "";

  set username(String value) {
    _sharedPrefs.setString(keyUsername, value);
  }
}
const String keyUsername = "key_username";
////////////////////////////////////////////////////////////////////////////////////////////////////////////////


Future<void> main()async {

  WidgetsFlutterBinding.ensureInitialized();
  await SharedPrefs().init();

  SharedPreferences.getInstance().then((prefs) {
    var isDarkTheme = prefs.getBool("darkTheme") ?? false;
    return runApp(
      ChangeNotifierProvider<ThemeProvider>(
        child: MyApp(),
        create: (BuildContext context) {
          return ThemeProvider(isDarkTheme);
        },
      ),
    );
  });
}
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
     // DeviceOrientation.portraitDown,
    ]);
    return Consumer<ThemeProvider>(
      builder: (context, value, child) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'FocusPro',
          theme: value.getTheme(),
          home: MyHomePage(),
        );
      },
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {




var plantImageSelector;

  var buttonText; //text to use in button
  var messageText; //message to display at top of plant image


  var plantCount = 0; //gives plant count at top right
  var plantLevel;//variable to iterate through plant image as time passes starring from initial 1 to total no of plant images
  var totalPlantLevels = 9;// as we have 9 plant images so we never want our counter to go above 9 otherwise there wil be error
  var plantImage;// changing plant image inside
  var plantGrew;

  var countdown;
  var timeStep =1;                     //////////////////// things to focus on //////////////////////
  var timeMultiplier;
  var focusTime;
  var timeRemaining;//time counter
  var timerStarted;//timer starting

  resetData(){
    plantLevel = 1;
    plantGrew = false;

    timeMultiplier = 5 * 60 ;// % minute steps
    focusTime = timeStep*timeMultiplier;
    timeRemaining = timeStep*timeMultiplier;
    timerStarted = false;


    messageText = 'Plant a tree now';
    buttonText = 'plant';

  }


  sliderChanged(int step){
    setState(() {
      timeStep = step;
      resetData();
    });
  }


  manageTime(){
    int timeElapsed = focusTime - timeRemaining;
    int timePeriod =((plantLevel / totalPlantLevels) * focusTime).floor();
    setState(() {
      if(timerStarted){
        timeRemaining--;
        if(timeElapsed > timePeriod && plantLevel < totalPlantLevels){
          plantLevel++;
        }
      } else{
        timeRemaining = 0;
      }

      if (timeRemaining == 0){
        countdown.cancel();
        plantCount++;
        plantGrew = true;
        buttonText = 'Start again';
        messageText = 'Good job';
      }

    });
  }



  showAlertDialog(BuildContext context) {

    AlertDialog alert = AlertDialog(

      backgroundColor:  Colors.white.withOpacity(0.7),
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15)),


     // title: Center(child:Text("Select"),),

      content: Container(
decoration: BoxDecoration(
    border: Border.all(color: Colors.blueAccent.withOpacity(0.8),width: 5),
  borderRadius: BorderRadius.all(
      Radius.circular(15.0) //                 <--- border radius here
  ),

),
        height: 420,
        child:
        Center(
          child:
Column(

  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
  children: [

////////////////////////////////////////////////ALERT DIALOGUE*********************************************************
////////////////////////////////////////////////ALERT DIALOGUE*********************************************************
    ////////////////////////////////////////////////ALERT DIALOGUE*********************************************************
    ////////////////////////////////////////////////ALERT DIALOGUE*********************************************************
    SizedBox(height: 15,),

Text("Select your plant",style: GoogleFonts.comicNeue(fontSize: 20,color: Colors.blueAccent,fontWeight: FontWeight.bold),),
    SizedBox(height: 15,),
    Container(
      decoration: BoxDecoration(                                                /////IIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIII
        color: Colors.transparent,                                /////IIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIII

      ),
      child:
      SingleChildScrollView(
        physics: BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
        scrollDirection: Axis.horizontal,
        child:
        Stack(

          children:<Widget> [

Container(
  child:
      Row(
          children:<Widget> [
            SizedBox(width: 15,),
            InkWell(

              child: Container(

                  decoration: BoxDecoration(

                    borderRadius: BorderRadius.all(
                      Radius.circular(19),
                    ),
                    border: Border.all(color: Colors.blueAccent.withOpacity(0.5), width: 2),

                    image: DecorationImage(image: AssetImage('assets/onecover.png'),

                      fit: BoxFit.cover,

                    ),

                  ),
                  height: 160.0,
                  width: 130.0,
                  child:
                      Center(child:
                        Column(

                          mainAxisAlignment: MainAxisAlignment.end,
                      children:[



                  Container(
                      alignment: Alignment.bottomCenter,
                    decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.7),
                      borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(20.0),
                        bottomRight: Radius.circular(20.0),
                      ),
                    ),
                        child:

                  Text("Majestic Tree",style: GoogleFonts.comicNeue(fontSize: 16,color: Colors.blueAccent,fontWeight: FontWeight.bold),)


                  )

                      ],

                        ),
                      ),
              ),
              onTap: () {
                setState(() {

                  SharedPrefs().username='one';

                  Navigator.of(context).pop();

                });
              },
            ),

            SizedBox(width: 15,),

            InkWell(

              child: Container(

                  decoration: BoxDecoration(

                    borderRadius: BorderRadius.all(
                      Radius.circular(19),
                    ),
                    border: Border.all(color: Colors.blueAccent.withOpacity(0.5), width: 2),

                    image: DecorationImage(image: AssetImage('assets/twocover.png'),

                      fit: BoxFit.cover,

                    ),

                  ),
                  height: 160.0,
                  width: 130.0,
                  child:
                  Center(child:
                  Column(

                    mainAxisAlignment: MainAxisAlignment.end,
                    children:[



                      Container(
                          alignment: Alignment.bottomCenter,
                          decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.7),
                            borderRadius: BorderRadius.only(
                              bottomLeft: Radius.circular(20.0),
                              bottomRight: Radius.circular(20.0),
                            ),
                          ),
                          child:

                          Text("Pretty Pot",style: GoogleFonts.comicNeue(fontSize: 16,color: Colors.blueAccent,fontWeight: FontWeight.bold),)


                      )

                    ],

                  ),
                  ),

              ),
              onTap: () {
                setState(() {

                  SharedPrefs().username='two';

                  Navigator.of(context).pop();

                });
              },
            ),









SizedBox(width: 15,),
            InkWell(
              splashColor: Colors.yellow,
              highlightColor: Colors.blue,
              child: Container(

                  decoration: BoxDecoration(

                    borderRadius: BorderRadius.all(
                      Radius.circular(15),
                    ),
                    border: Border.all(color: Colors.blueAccent.withOpacity(0.5), width: 3),

                    image: DecorationImage(image: AssetImage('assets/threecover.png'),

                      fit: BoxFit.cover,

                    ),

                  ),
                  height: 160.0,
                  width: 130.0,
                  child:
                  Center(child:
                  Column(

                    mainAxisAlignment: MainAxisAlignment.end,
                    children:[



                      Container(
                          alignment: Alignment.bottomCenter,
                          decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.7),
                            borderRadius: BorderRadius.only(
                              bottomLeft: Radius.circular(20.0),
                              bottomRight: Radius.circular(20.0),
                            ),
                          ),
                          child:

                          Text("Lush Magic",style: GoogleFonts.comicNeue(fontSize: 16,color: Colors.blueAccent,fontWeight: FontWeight.bold),)


                      )

                    ],

                  ),
                  ),

              ),
              onTap: () {
                setState(() {

                  SharedPrefs().username='three';
Navigator.of(context).pop();
                  // _count += 1;
                });
              },
            ),
            SizedBox(width: 15,),
            InkWell(
              splashColor: Colors.yellow,
              highlightColor: Colors.blue,
              child: Container(

                  decoration: BoxDecoration(

                    borderRadius: BorderRadius.all(
                      Radius.circular(19),
                    ),
                    border: Border.all(color: Colors.blueAccent.withOpacity(0.5), width: 3),

                    image: DecorationImage(image: AssetImage('assets/fourcover.png'),

                      fit: BoxFit.cover,

                    ),

                  ),
                  height: 160.0,
                  width: 130.0,
                  child:
                  Center(child:
                  Column(

                    mainAxisAlignment: MainAxisAlignment.end,
                    children:[



                      Container(
                          alignment: Alignment.bottomCenter,
                          decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.7),
                            borderRadius: BorderRadius.only(
                              bottomLeft: Radius.circular(20.0),
                              bottomRight: Radius.circular(20.0),
                            ),
                          ),
                          child:

                          Text("Divine Pot",style: GoogleFonts.comicNeue(fontSize: 16,color: Colors.blueAccent,fontWeight: FontWeight.bold),)


                      )

                    ],

                  ),
                  ),

              ),
              onTap: () {
                setState(() {

                  SharedPrefs().username='four';
                  Navigator.of(context).pop();
                  // _count += 1;
                });
              },
            ),

            SizedBox(width: 15,),




            InkWell(

              child: Container(

                  decoration: BoxDecoration(

                    borderRadius: BorderRadius.all(
                      Radius.circular(19),
                    ),
                    border: Border.all(color: Colors.blueAccent.withOpacity(0.5), width: 3),

                    image: DecorationImage(image: AssetImage('assets/fivecover.png'),

                      fit: BoxFit.cover,

                    ),

                  ),
                  height: 160.0,
                  width: 130.0,
                  child:
                  Center(child:
                  Column(

                    mainAxisAlignment: MainAxisAlignment.end,
                    children:[



                      Container(
                          alignment: Alignment.bottomCenter,
                          decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.7),
                            borderRadius: BorderRadius.only(
                              bottomLeft: Radius.circular(20.0),
                              bottomRight: Radius.circular(20.0),
                            ),
                          ),
                          child:

                          Text("Plain Conifer",style: GoogleFonts.comicNeue(fontSize: 16,color: Colors.blueAccent,fontWeight: FontWeight.bold),)


                      )

                    ],

                  ),
                  ),

              ),
              onTap: () {
                setState(() {

                  SharedPrefs().username='five';

                  Navigator.of(context).pop();

                });
              },
            ),

            SizedBox(width: 15,),




            InkWell(

              child: Container(

                  decoration: BoxDecoration(

                    borderRadius: BorderRadius.all(
                      Radius.circular(19),
                    ),
                    border: Border.all(color: Colors.blueAccent.withOpacity(0.5), width: 3),

                    image: DecorationImage(image: AssetImage('assets/sixcover.png'),

                      fit: BoxFit.cover,

                    ),

                  ),
                  height: 160.0,
                  width: 130.0,
                  child:
                  Center(child:
                  Column(

                    mainAxisAlignment: MainAxisAlignment.end,
                    children:[



                      Container(
                          alignment: Alignment.bottomCenter,
                          decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.7),
                            borderRadius: BorderRadius.only(
                              bottomLeft: Radius.circular(20.0),
                              bottomRight: Radius.circular(20.0),
                            ),
                          ),
                          child:

                          Text("Exotic Shrub",style: GoogleFonts.comicNeue(fontSize: 16,color: Colors.blueAccent,fontWeight: FontWeight.bold),)


                      )

                    ],

                  ),
                  ),

              ),
              onTap: () {
                setState(() {

                  SharedPrefs().username='six';

                  Navigator.of(context).pop();

                });
              },
            ),

            SizedBox(width: 15,),




            InkWell(

              child: Container(

                  decoration: BoxDecoration(

                    borderRadius: BorderRadius.all(
                      Radius.circular(15),
                    ),
                    border: Border.all(color: Colors.blueAccent.withOpacity(0.5), width: 3),

                    image: DecorationImage(image: AssetImage('assets/sevencover.png'),

                      fit: BoxFit.cover,

                    ),

                  ),
                  height: 160.0,
                  width: 130.0,
                  child:
                  Center(child:
                  Column(

                    mainAxisAlignment: MainAxisAlignment.end,
                    children:[



                      Container(
                          alignment: Alignment.bottomCenter,
                          decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.7),
                            borderRadius: BorderRadius.only(
                              bottomLeft: Radius.circular(20.0),
                              bottomRight: Radius.circular(20.0),
                            ),
                          ),
                          child:

                          Text("Aromatical",style: GoogleFonts.comicNeue(fontSize: 16,color: Colors.blueAccent,fontWeight: FontWeight.bold),)


                      )

                    ],

                  ),
                  ),

              ),
              onTap: () {
                setState(() {

                  SharedPrefs().username='seven';

                  Navigator.of(context).pop();

                });
              },
            ),
            SizedBox(width: 15,),
]

),

    ),











          ],

        ),




    ),



    ),
    SizedBox(height: 20,),



    RaisedButton(

      shape: RoundedRectangleBorder(

          borderRadius: BorderRadius.circular(18.0),
          side: BorderSide(color: Colors.blueAccent,width: 3)),/////////////////////////////////    //$$$$$$$$$$$$$$$$$$$$$$    //$$$$$$$$$$$$$$$$$$$$$$
      onPressed: ()  {
        Provider.of<ThemeProvider>(context, listen: false).swapTheme();
      },
      // _hasBeenPressed = !_hasBeenPressed;

      color: Colors.white.withOpacity(0.8),
      textColor: Colors.white,
      child: Text("Dark Mode",
        style: GoogleFonts.comicNeue(fontSize: 15,color: Colors.blueAccent,fontWeight: FontWeight.bold),),
    ),


    RaisedButton(

      shape: RoundedRectangleBorder(

          borderRadius: BorderRadius.circular(18.0),
          side: BorderSide(color: Colors.blueAccent,width: 3)),/////////////////////////////////    //$$$$$$$$$$$$$$$$$$$$$$    //$$$$$$$$$$$$$$$$$$$$$$
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) =>about()),
          );
        },
      // _hasBeenPressed = !_hasBeenPressed;

      color: Colors.white.withOpacity(0.8),
      textColor: Colors.white,
      child: Text("   About   ",
        style: GoogleFonts.comicNeue(fontSize: 15,color: Colors.blueAccent,fontWeight: FontWeight.bold),),
    ),

      IconButton(
        icon: Icon(
          Icons.cancel,
          size: 35,
          color: Colors.blueAccent,
        ),
onPressed: () {Navigator.pop(context);}
      ),


  ],

),


        ),

      ),

    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }



  ////////////////////////////////////////////////ALERT DIALOGUE*********************************************************







  buttonPressed() {
    setState(() {
      if(plantGrew){
        resetData();
      }else{
        if(!timerStarted){




          timerStarted = true;
          buttonText = 'Give Up';

          countdown = Timer.periodic(Duration(seconds: 1), (Timer t) => manageTime());            ////////////    MILLIseconds 10=1

        }


        //AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA



        else{
          showDialog(context: context,builder: (_)=>AlertDialog(
      backgroundColor:  Colors.transparent,
      shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(15)),

title:Text(
  "",

),

            content:
                Container(
                  child:
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children:[

          Center(child:
      Text(
              "Are you sure!",
              style: GoogleFonts.comicNeue(fontSize: 24,color: Colors.blueAccent,fontWeight: FontWeight.bold),
            ),
      ),

SizedBox(height: 20,),

          Center(child:

              Column(
                mainAxisAlignment: MainAxisAlignment.center,

              children:[


                RaisedButton(

                  shape: RoundedRectangleBorder(

                      borderRadius: BorderRadius.circular(18.0),
                      side: BorderSide(color: Colors.redAccent,width: 3)),/////////////////////////////////    //$$$$$$$$$$$$$$$$$$$$$$    //$$$$$$$$$$$$$$$$$$$$$$
                  onPressed: (){
                    Navigator.pop(context);
                    setState(() {
                      countdown.cancel();
                      resetData();
                    });
                  },
                  // _hasBeenPressed = !_hasBeenPressed;

                  color: Colors.white.withOpacity(0.8),
                  textColor: Colors.white,
                  child: Text(" Yes, let the plant die ",
                    style: GoogleFonts.comicNeue(fontSize: 18,color: Colors.red,fontWeight: FontWeight.bold),),
                ),


                SizedBox(height: 5,),


                RaisedButton(

                  shape: RoundedRectangleBorder(

                      borderRadius: BorderRadius.circular(18.0),
                      side: BorderSide(color: Colors.lightGreenAccent,width: 3)),/////////////////////////////////    //$$$$$$$$$$$$$$$$$$$$$$    //$$$$$$$$$$$$$$$$$$$$$$
                  onPressed: (){
                    Navigator.pop(context);
                  },
                  // _hasBeenPressed = !_hasBeenPressed;

                  color: Colors.white.withOpacity(0.8),
                  textColor: Colors.white,
                  child: Text("No, I'll let the plant live",
                    style: GoogleFonts.comicNeue(fontSize: 18,color: Colors.green,fontWeight: FontWeight.bold),),
                ),

],
              ),


          ),





          ],
                      ),
          )
          ),
          );
        }
      }

    });
  }

//////////////////////////////////////////////////////////////
  timeDisplay(int givenSeconds){
    int minutes = (givenSeconds/60).floor();
    int seconds = givenSeconds % 60;
    String secondsDisp = seconds.toString();
    //////////////////////////////////////////////0000000000change////////

if(focusTime==0){
  timeRemaining=1;

 // messageText = 'Oh common! do at least 5 mins';

 // focusTime=20;
}


    if(seconds<10){
      secondsDisp = "0" + secondsDisp;
    }

    return minutes.toString() + ':' + secondsDisp.toString();

  }

//////////////////////////////////////////////////////////////////QQQQQQQQQQQQQQQQQQQQQQQQQQQQQQQQQQQQQQQQQQQQQQQQQQQQQ

  @override
  void initState() {
    resetData();
    super.initState();

  }



  //////////////////////////////////////////////$$$$$$$$$$$$$$$$$$$$ shared preferences $$$$$$$$$$$$$$$$$$$$$$$$$$$$   $$$$$$$$$$$$$$$$$$$$$$$$$$$$
//$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$
//$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$
 // $$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$
//  $$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$
//$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$
////////////////////////////////////////////////////*****DESIGNING PART******////////////////////////////////////
  @override
  Widget build(BuildContext context) {

if (SharedPrefs().username=='one') {

  plantImage = 'lib/images3/plant$plantLevel.png';
}

else if(SharedPrefs().username=='two'){


  plantImage = 'lib/images/plant$plantLevel.png';
}

else if(SharedPrefs().username=='three'){
  plantImage = 'lib/images4/plant$plantLevel.png';
}
else if(SharedPrefs().username=='four'){
  plantImage = 'lib/images2/plant$plantLevel.png';
}else if(SharedPrefs().username=='five'){
  plantImage = 'lib/images5/plant$plantLevel.png';
}
else if(SharedPrefs().username=='six'){
  plantImage = 'lib/images6/plant$plantLevel.png';
}else if(SharedPrefs().username=='seven'){
  plantImage = 'lib/images7/plant$plantLevel.png';
}



else{
  plantImage = 'lib/images3/plant$plantLevel.png';
}

    return Scaffold(
    // backgroundColor:false ? Colors.black : Colors.white,



      body: Container(
        margin: EdgeInsets.symmetric(horizontal: 20),
        child: Center(
          child: Column
            (
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,

            children: [

///////////////////////////////////////////////////" APP BAR    "//////////////////  //$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$
//SizedBox(height: 10,),



           //   Text("Hi ${SharedPrefs().username}"),

              IconButton(
                icon: Icon(
                  Icons.multitrack_audio,
                  size: 30,
                  color: Colors.blue,
                ),


                onPressed: () {
                  showAlertDialog(context);

                },

                /* onPressed: () {
                            showAlertDialog(context);

                          },*/
              ),

           //   SizedBox(height: 40),
              Text(
                  plantLevel==1? "Stay focused":

                  plantLevel==2 ? "Do your work":

                  plantLevel==3 ? "You are doing good":

                  plantLevel==4 ? "Direct your energy":

              plantLevel==5 ? "Clear your mind":

                plantLevel==6 ? "Avoid distractions":

                plantLevel==7 ? "Be present above all else":

              plantLevel==8 ? "Focus":


                      "Stay focused"

                ,
                style: GoogleFonts.comicNeue(fontSize: 27,color: Colors.blueAccent,fontWeight: FontWeight.bold),
                    // fontStyle: FontStyle.italic,
              ),
           //   SizedBox(height: 25.0),
              Container(
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(
                      width: timerStarted ? 10 : 0, //border width dependent on timer starts border disappears due to this
                      color: timerStarted ? Colors.blueAccent : Colors.transparent,
                  ),
                ),
                child:
                timerStarted == true ?
                CircleAvatar(
                  radius: 100.0,
                  backgroundColor: Colors.grey,
                  backgroundImage: AssetImage(plantImage),
                )
                /////////////////////////////////////////////////*************  CIRCLE PART ****************//////////////



                :

                SleekCircularSlider(
initialValue: 2,
                  min:1,
                    max: 25,

                  innerWidget: (double focusTime) {
                    // use your custom widget inside the slider (gets a slider value from the callback)
                    return Column(
                      children: <Widget>[
                        SizedBox(height: 10,),

                      /*  Slider(
                            value: value,
                            min: 0,
                            max: 120,

                            onChanged: (double weight) {
                              setState(() {
                                String newValue = weight.ceil().toInt().toString();
                                print("$newValue");
                                otherMethod(newValue);
                              });
                            }),*/

                      ],
                    );
                  },



                    appearance: CircularSliderAppearance(
                        size:230,

                    startAngle: 270,
                        angleRange: 360,


                        customWidths: CustomSliderWidths(
                          trackWidth: 5,
                          progressBarWidth: 20,
                          handlerSize: 10,

                        ),

                      customColors: CustomSliderColors(
                        hideShadow: false,

                          //trackColors: 	[Colors.blue, Colors.red, Colors.green,Colors.pink,Colors.purple],
                          trackColors: 	[Colors.purple, Colors.indigo,Colors.blue, Colors.green,Colors.yellow,Colors.orange,Colors.red],

                          dotColor: Colors.blueAccent,
                          progressBarColors:[Colors.purple, Colors.indigo,Colors.blue, Colors.green,Colors.yellow,Colors.orange,Colors.red],


                      ),




                    ),
                    onChangeEnd: (double value) => sliderChanged(value.toInt()),




                    ),

              ),
            //  SizedBox(height: 25.0),
              Text(
                //timeRemaining==0? int.parse('joo'): timeRemaining
                timeDisplay(timeRemaining),
                style: GoogleFonts.comicNeue(fontSize: 50,color: Colors.blueAccent,fontWeight: FontWeight.bold),

              ),




           //   SizedBox(height: 25.0),
              OutlineButton(
                onPressed: () => buttonPressed(),
                padding: EdgeInsets.all(18.0),
                shape: new RoundedRectangleBorder(borderRadius: new BorderRadius.circular(30.0)),
                borderSide: BorderSide(
                  color: Colors.blueAccent,
                  width: 3,

                ),
                child: Text(
                  buttonText,
                  style: GoogleFonts.comicNeue(fontSize: 20,color: Colors.blueAccent,fontWeight: FontWeight.bold),
                ),
              ),


           //   SizedBox(height: 25.0),
              Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [

                    SizedBox(width: 5.0),
                    Text(
                      plantCount.toString(),
                      style: TextStyle(
                        fontSize: 32,
                        color: Colors.blueAccent,

                      ),
                    ),

                  ]),







            ],
          ),
        ),
      ),
    );
  }
}


