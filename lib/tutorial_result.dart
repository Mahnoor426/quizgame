import 'package:flutter/material.dart';
import 'package:quizproject/signin.dart';

class TutorialResult extends StatefulWidget {
  // const TutorialResult({Key? key}) : super(key: key);
  final int correct, incorrect, total;
  const TutorialResult(
      {required this.correct, required this.incorrect, required this.total});

  @override
  State<TutorialResult> createState() => _TutorialResultState();
}

class _TutorialResultState extends State<TutorialResult> {
  @override
  Widget build(BuildContext context) {
    return Container(
      //by this we added animation
      child: TweenAnimationBuilder(
        tween: Tween(begin: 0.0, end: 1.0),
        duration: Duration(milliseconds: 1500),
        builder: (context, value, child) {
          return ShaderMask(
            blendMode: BlendMode.modulate,
            shaderCallback: (rect) {
              return RadialGradient(
                radius: value * 5,
                colors: [
                  Colors.white,
                  Colors.white,
                  Colors.transparent,
                  Colors.transparent
                ],
                stops: [0.0, 0.55, 0.6, 1.0],
                center: FractionalOffset(0.95, 0.90),
              ).createShader(rect);
            },
            child: child,
          );
        },
        //till here animation ended
        child: MaterialApp(
          home: Scaffold(
              appBar: AppBar(
                title: appBar(context),
                backgroundColor: Colors.transparent,
                elevation: 0.0,
                centerTitle: true, // by this u set the appbar center
              ),
              body: Center(
                child: Column(
                  children: [
                    Image(
                      image: AssetImage("assets/result.jpg"),
                      height: 380,
                    ),
                    // SizedBox(height: 1),
                    Text(
                      "${widget.correct}/${widget.total}",
                      style: TextStyle(
                        fontSize: 25,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(
                      height: 8,
                    ),
                    Text(
                      "You answered ${widget.correct} answers correctly and ${widget.incorrect} answers incorrectly",
                      style: TextStyle(color: Colors.grey, fontSize: 20),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    Text(
                      "Your skills are excellent!! leading to the login page to explore more quizes",
                      style: TextStyle(color: Colors.grey, fontSize: 20),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    Container(
                      width: 200,
                      height: 50,
                      decoration: BoxDecoration(
                        color: Colors.deepPurple,
                        borderRadius: BorderRadius.circular(30.0),
                      ),
                      child: TextButton(
                        style: ButtonStyle(
                          foregroundColor:
                              MaterialStateProperty.all<Color>(Colors.white),
                        ),
                        onPressed: () {
                          // Navigator.pop(context);
                          Navigator.push(
                            context,
                            PageRouteBuilder(
                                pageBuilder: (context, animation, _) {
                                  return LoginScreen();
                                },
                                opaque: false),
                          );
                        },
                        child: Text('Want To Explore Quizes!!'),
                      ),
                    )
                  ],
                ),
              )),
        ),
      ),
    );
  }
}

Widget appBar(BuildContext context) {
  return RichText(
    text: TextSpan(
      style: TextStyle(fontSize: 22),
      children: const <TextSpan>[
        TextSpan(
            text: 'Ace',
            style:
                TextStyle(fontWeight: FontWeight.w500, color: Colors.purple)),
        TextSpan(
            text: 'Recruit',
            style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black)),
        // TextSpan(
        //     text: 'Application',
        //     style:
        //         TextStyle(fontWeight: FontWeight.w500, color: Colors.purple)),
      ],
    ),
  );
}
