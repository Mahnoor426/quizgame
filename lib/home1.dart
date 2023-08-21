import 'package:flutter/material.dart';
import 'package:quizproject/create_quiz.dart';
import 'package:quizproject/database.dart';
import 'package:quizproject/play_quiz.dart';

class HomePageOne extends StatefulWidget {
  const HomePageOne({Key? key}) : super(key: key);

  @override
  State<HomePageOne> createState() => _HomePageOneState();
}

class _HomePageOneState extends State<HomePageOne> {
  Stream? quizStream;
  //help to interact with databse to easily read write or update record.
  DatabaseService databaseService = new DatabaseService();
//fetch data from database and return the fetch containers or items
  Widget quizList() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 20),
      child: StreamBuilder(
        stream: quizStream,
        builder: (context, snapshot) {
          //  if data inside snapshot is not equal to null matl data ha tabhi container show karna
          return snapshot.data == null
              ? Container()
              : ListView.builder(
              itemCount: snapshot.data.docs.length,
              itemBuilder: (context, index) {
                var document = snapshot.data.docs[index];
                return QuizTile(
                    imgUrl: document.data()["quizImageUrl"],
                    desc: document.data()["quizDesc"],
                    title: document.data()["quizTitle"],
                    quizid:document.data()["quizId"]
                );
              });
        },
      ),
    );
  }

  @override
  //the first function that loads when screen is displayed is initstate func.
  void initState() {
    databaseService.getQuizData().then((val) {
      setState(() {
        quizStream = val;
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      //by this we added animation like gradient effect
      child: TweenAnimationBuilder(
        tween: Tween(begin: 0.0,end: 1.0),
        duration: Duration(milliseconds: 1500),
        builder: (context,value,child){
          return ShaderMask(
            blendMode: BlendMode.modulate,
            shaderCallback: (rect){
              return RadialGradient(
                radius: value * 5,
                colors: [Colors.white,Colors.white,Colors.transparent,Colors.transparent],
                stops: [0.0,0.55,0.6,1.0],
                center: FractionalOffset(0.95,0.90),
              ).createShader(rect);

            },child: child,);
        },
        //till here animation ended

      child: MaterialApp(
        // debugShowCheckedModeBanner: false,
        home: Scaffold(
          appBar: AppBar(
            title: appBar(context),
            backgroundColor: Colors.transparent,
            elevation: 0.0,
            centerTitle: true, // by this u set the appbar center
          ),
          body: quizList(),
          floatingActionButton: FloatingActionButton(
            child: Icon(Icons.add),
            onPressed: () {
              Navigator.push(
                  // context, MaterialPageRoute(builder: (context) => CreateQuiz()));
                  context,
                PageRouteBuilder(pageBuilder: (context, animation, _) {
                  return CreateQuiz();
                },opaque: false),
              );
            },
          ),
        ),
      ),),
    );
  }
}

class QuizTile extends StatelessWidget {
  final String imgUrl;
  final String title;
  final String desc;
  final String quizid;

  QuizTile({required this.imgUrl, required this.title, required this.desc, required this.quizid});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        // final player=AudioCache();
        // player.play('during-play.mp3');
        Navigator.push(context, MaterialPageRoute(
            builder: (context) => PlayQuiz(quizid)
        ));
      },
      child: Container(
        margin: EdgeInsets.only(bottom: 8),
        height: 150,
        child: Stack(
          children: [
            ClipRRect(//IS USED TO DISPLAY AN ROUNDED RECTANGULAR IMAGE
                borderRadius: BorderRadius.circular(8),
                child: Image.network(imgUrl, width: MediaQuery.of(context).size.width-48, fit: BoxFit.cover,)),
            Container(
              // color: Colors.white,
              // alignment: Alignment.center,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Center(child: Text(title, style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.w800),)),
                  SizedBox(height: 6,),
                  Center(child: Text(desc, style: TextStyle(color: Colors.white, fontSize: 13, fontWeight: FontWeight.w600),))
                ],
              ),
            )
          ],
        ),
      ),
    );
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
