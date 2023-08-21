import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:quizproject/tutorial_play.dart';

class Intro extends StatelessWidget {
  const Intro({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Scaffold(
          // backgroundColor: Color.fromARGB(255, 245, 217, 226),
          appBar: AppBar(
            title: appBar(context),
            backgroundColor: Colors.transparent,
            elevation: 0.0,
            centerTitle: true, // by this u set the appbar center
          ),
          body: Column(
            children: [
              Container(

                alignment: Alignment.topCenter,
                height: 300,
                padding: const EdgeInsets.all(15),
                decoration: const BoxDecoration(
                  image: DecorationImage(
                    image: NetworkImage(
                        'https://images.unsplash.com/photo-1573497491208-6b1acb260507?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8M3x8aW50ZXJ2aWV3fGVufDB8fDB8fHww&w=1000&q=80'),
                    fit: BoxFit.fitWidth,
                    alignment: Alignment.topCenter,
                  ),
                ),
                child: Column(
                  children: [
                    const Text(
                      'Welcome to AceRecruit',
                      style: TextStyle(
                        fontSize: 30,
                        color: Colors.purple,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 1,
              ),
              const Text(
                "With AceRecruit, you'll gain the confidence and skills needed to excel in job interviews. Create custom quizzes tailored to famous interview topics and enhance your preparation. Get ready to conquer the recruitment journey and secure your dream job!",
                style:
                TextStyle(fontSize: 16, color: Colors.black, fontStyle: FontStyle.italic),
                textAlign: TextAlign.center,
              ),
              SizedBox(
                height: 40,
              ),
              ElevatedButton.icon(
                onPressed: () {
                  final player=AudioCache();
                  player.play('start-play.mp3');
                  // Navigator.push(context,
                  //     MaterialPageRoute(builder: (context) => HomePage()));
                  Navigator.pushNamed(context, '/home');
                },
                icon: Icon(Icons.login),
                label: Text('Want to Login'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.deepPurple,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30.0),
                  ),
                  padding: EdgeInsets.symmetric(
                    vertical: 16.0,
                    horizontal: 24.0,
                  ), // Set button padding
                ),
              ),
              Spacer(),
              const Text(
                "DO YOU WANT TO TRY?",
                style: TextStyle(fontSize: 30,fontStyle: FontStyle.italic,color:Colors.black ),
              textAlign: TextAlign.center,
              ),
              SizedBox(height: 15,),
              const Text(
                "FREE TRIAL!!",
                style: TextStyle(fontSize: 30,fontStyle: FontStyle.italic,color:Colors.purple ),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 20,),
              ElevatedButton.icon(
                onPressed: () {
                  final player=AudioCache();
                  player.play('start-play.mp3');
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => TutorialPlay()));
                  // Navigator.pushNamed(context, '/tutorial_play');

                },
                icon: Icon(Icons.login),
                label: Text('Tutorial'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.deepPurple,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30.0),
                  ),
                  padding: EdgeInsets.symmetric(
                    vertical: 16.0,
                    horizontal: 24.0,
                  ), // Set button padding
                ),
              ),
              SizedBox(height: 20,),
              SizedBox(height: 15,)

            ],
          ),
        ));
  }
}

//appbar widget banaya
Widget appBar(BuildContext context) {
  return RichText(
    text: TextSpan(
      style: TextStyle(fontSize: 22),
      children: const <TextSpan>[
        TextSpan(
            text: 'Ace',
            style: TextStyle(
                fontWeight: FontWeight.w900, color: Colors.deepPurple)),
        TextSpan(
            text: 'Recruit',
            style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black)),
        ],
    ),
  );
}
