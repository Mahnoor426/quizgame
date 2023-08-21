import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:quizproject/database.dart';
import 'package:quizproject/question_model.dart';
import 'package:quizproject/quiz_play_widgets.dart';
import 'package:quizproject/results.dart';
import 'package:quizproject/tutorial_result.dart';

// class TutorialPlay extends StatefulWidget {
//   const TutorialPlay({Key? key}) : super(key: key);
//
//   // final String quizId= "PkBSSEpZTFg7R0pP";
//   // TutorialPlay(this.quizId);
//   @override
//   State<TutorialPlay> createState() => _TutorialPlayState();
// }

class TutorialPlay extends StatefulWidget {
  final String quizId;

  // TutorialPlay(this.quizId, {Key? key}) : super(key: key);
  TutorialPlay({this.quizId = "PkBSSEpZTFg7R0pP", Key? key}) : super(key: key);
  @override
  State<TutorialPlay> createState() => _TutorialPlayState();
}

///Score global variables ///
int total = 0;
int _correct = 0;
int _incorrect = 0;
int _notAttempted = 0;
////////////////////////////
class _TutorialPlayState extends State<TutorialPlay> {

  DatabaseService databaseService = new DatabaseService();
  late QuerySnapshot questionsSnapshot;

  QuestionModel getQuestionModelFromDatasnapshot(
      DocumentSnapshot questionSnapshot) {
    QuestionModel questionModel =new QuestionModel(
      question: "",
      option1: "",
      option2: "",
      option3: "",
      option4: "",
      correctOption: "",
      answered: false,
    );

    questionModel.question = (questionSnapshot.data() as dynamic)["question"];

    List<String> options = [
      (questionSnapshot.data() as dynamic)["option1"],
      (questionSnapshot.data() as dynamic)["option2"],
      (questionSnapshot.data() as dynamic)["option3"],
      (questionSnapshot.data() as dynamic)["option4"],
    ];
    options.shuffle();
    questionModel.option1 = options[0];
    questionModel.option2 = options[1];
    questionModel.option3 = options[2];
    questionModel.option4 = options[3];
    questionModel.correctOption =
    (questionSnapshot.data() as dynamic)["option1"];
    questionModel.answered = false;
    return questionModel;
  }

  @override
  void initState() {
    print("${widget.quizId}");
    databaseService.getQuizzData(widget.quizId).then((value) {
      questionsSnapshot = value;
      _notAttempted = 0;
      _correct = 0;
      _incorrect = 0;
      total = questionsSnapshot.docs.length;
      setState(() {});
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: appBar(context),
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        iconTheme: IconThemeData(color: Colors.black54),
        centerTitle: true, // by this u set the appbar center
      ),
      body: Container(
          child: Column(children: [
            questionsSnapshot.docs == null ?
            Container(
              child: Center(
                child: CircularProgressIndicator(),
              ),
            )
                : Expanded(
              child: SingleChildScrollView(
                child: ListView.builder(
                    padding: EdgeInsets.symmetric(horizontal: 24),
                    itemCount: questionsSnapshot.docs.length,
                    shrinkWrap: true,
                    physics: ClampingScrollPhysics(),
                    // itemBuilder: (context, index),
                    itemBuilder: (context, index) {
                      return QuizPlayTile(
                        questionModel: getQuestionModelFromDatasnapshot(
                            questionsSnapshot.docs[index]),
                        index: index,
                      );
                    }),
              ),
            )
          ])),

      floatingActionButton: FloatingActionButton(
          child: Icon(Icons.check),
          onPressed:(){
            Navigator.push(
              context,
              PageRouteBuilder(pageBuilder: (context, animation, _) {
                return TutorialResult(correct: _correct, incorrect: _incorrect, total: total);
              },opaque: false),
            );
            final player=AudioCache();
            player.play('alert-notification.wav');
            // Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>Results(
            //   correct: _correct,
            //   incorrect: _incorrect,
            //   total: total,
            // )));
          } ),
    );
  }
}

class QuizPlayTile extends StatefulWidget {
  final QuestionModel questionModel;
  final int index;
  QuizPlayTile({required this.questionModel, required this.index});

  @override
  State<QuizPlayTile> createState() => _QuizPlayTileState();
}

class _QuizPlayTileState extends State<QuizPlayTile> {
  String optionSelected = "";
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("Q${widget.index+1} ${widget.questionModel.question}",style: TextStyle(fontSize: 20,color: Colors.black87),),
          SizedBox(
            height: 12,
          ),
          GestureDetector(
            onTap: () {
              if (!widget.questionModel.answered) {
                ///correct
                if (widget.questionModel.option1 ==
                    widget.questionModel.correctOption) {
                  optionSelected = widget.questionModel.option1;
                  widget.questionModel.answered = true;
                  _correct = _correct + 1;
                  _notAttempted = _notAttempted + 1;
                  setState(() {});
                } else {
                  optionSelected = widget.questionModel.option1;
                  widget.questionModel.answered = true;
                  _incorrect = _incorrect + 1;
                  _notAttempted = _notAttempted - 1;
                  setState(() {});
                }
              }
            },
            child: OptionTile(
              correctAnswer: widget.questionModel.correctOption,
              description: widget.questionModel.option1,
              option: "A",
              optionSelected: optionSelected,
            ),
          ),
          SizedBox(
            height: 4,
          ),
          GestureDetector(
            onTap: () {
              if (!widget.questionModel.answered) {
                ///correct
                if (widget.questionModel.option2 ==
                    widget.questionModel.correctOption) {
                  optionSelected = widget.questionModel.option2;
                  widget.questionModel.answered = true;
                  _correct = _correct + 1;
                  _notAttempted = _notAttempted + 1;
                  setState(() {});
                } else {
                  optionSelected = widget.questionModel.option2;
                  widget.questionModel.answered = true;
                  _incorrect = _incorrect + 1;
                  _notAttempted = _notAttempted - 1;

                  setState(() {});
                }
              }
            },
            child: OptionTile(
              correctAnswer: widget.questionModel.correctOption,
              description: widget.questionModel.option2,
              option: "B",
              optionSelected: optionSelected,
            ),
          ),
          SizedBox(
            height: 4,
          ),
          GestureDetector(
            onTap: () {
              if (!widget.questionModel.answered) {
                ///correct
                if (widget.questionModel.option3 ==
                    widget.questionModel.correctOption) {
                  optionSelected = widget.questionModel.option3;
                  widget.questionModel.answered = true;
                  _correct = _correct + 1;
                  _notAttempted = _notAttempted + 1;
                  setState(() {});
                } else {
                  optionSelected = widget.questionModel.option3;
                  widget.questionModel.answered = true;
                  _incorrect = _incorrect + 1;
                  _notAttempted = _notAttempted - 1;
                  setState(() {});
                }
              }
            },
            child: OptionTile(
              correctAnswer: widget.questionModel.correctOption,
              description: widget.questionModel.option3,
              option: "C",
              optionSelected: optionSelected,
            ),
          ),
          SizedBox(
            height: 4,
          ),
          GestureDetector(
            onTap: () {
              if (!widget.questionModel.answered) {
                ///correct
                if (widget.questionModel.option4 ==
                    widget.questionModel.correctOption) {
                  optionSelected = widget.questionModel.option4;
                  widget.questionModel.answered = true;
                  _correct = _correct + 1;
                  _notAttempted = _notAttempted + 1;
                  setState(() {});
                } else {
                  optionSelected = widget.questionModel.option4;
                  widget.questionModel.answered = true;
                  _incorrect = _incorrect + 1;
                  _notAttempted = _notAttempted - 1;
                  setState(() {});
                }
              }
            },
            child: OptionTile(
              correctAnswer: widget.questionModel.correctOption,
              description: widget.questionModel.option4,
              option: "D",
              optionSelected: optionSelected,
            ),
          ),
          SizedBox(height:20,)
        ],
      ),
    );
  }
}

// APPBAR //
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


