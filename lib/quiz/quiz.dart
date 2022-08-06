import 'package:fireshipapp/quiz/quiz_state.dart';
import 'package:fireshipapp/services/firestore.dart';
import 'package:fireshipapp/shared/loading.dart';
import 'package:fireshipapp/shared/progress_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

import '../services/models.dart';

class QuizScreen extends StatelessWidget {
  const QuizScreen({Key? key, required this.quizId}) : super(key: key);
  final String quizId;

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => QuizState(),
      child: FutureBuilder<Quiz>(
        future: FirestoreService().getQuiz(quizId),
        builder: (context, snapshot) {
          var state = Provider.of<QuizState>(context);

          if (!snapshot.hasData || snapshot.hasError) {
            return Loader();
          } else {
            var quiz = snapshot.data;
            return Scaffold(
              appBar: AppBar(
                title: AnimatedProgressbar(
                  value: state.progress,
                ),
                leading: IconButton(
                  icon: Icon(FontAwesomeIcons.xmark),
                  onPressed: () => Navigator.pop(context),
                ),
              ),
              body: PageView.builder(
                physics: const NeverScrollableScrollPhysics(),
                scrollDirection: Axis.vertical,
                controller: state.controlller,
                onPageChanged: (int idx) =>
                    state.progress = (idx / (quiz!.questions.length + 1)),
                itemBuilder: (BuildContext context, int idx) {
                  if (idx == 0) {
                    return StartPage(quiz: quiz!);
                  } else if (idx == quiz!.questions.length + 1) {
                    return CongratsPage(quiz: quiz);
                  } else {
                    return QuestionPage(question: quiz.questions[idx - 1]);
                  }
                },
              ),
            );
          }
        },
      ),
    );
  }
}

class StartPage extends StatelessWidget {
  final Quiz quiz;
  const StartPage({Key? key, required this.quiz}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var state = Provider.of<QuizState>(context);

    return Container(
      padding: EdgeInsets.all(20),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(quiz.title, style: Theme.of(context).textTheme.headline4),
          Divider(),
          Expanded(child: Text(quiz.description)),
          ButtonBar(
            alignment: MainAxisAlignment.center,
            children: [
              ElevatedButton.icon(
                  onPressed: state.nextPage,
                  icon: Icon(Icons.poll),
                  label: Text('Start Quiz!'))
            ],
          )
        ],
      ),
    );
  }
}

class CongratsPage extends StatelessWidget {
  final Quiz quiz;
  const CongratsPage({Key? key, required this.quiz}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(8),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'Congrats! You Completed the ${quiz.title} quiz',
            textAlign: TextAlign.center,
          ),
          Divider(),
          Image.asset('assets/congrats.gif'),
          Divider(),
          ElevatedButton.icon(
              onPressed: () {
                FirestoreService().updateUserReport(quiz);
                Navigator.pushNamedAndRemoveUntil(
                    context, '/topics', (route) => false);
              },
              icon: Icon(FontAwesomeIcons.check),
              label: Text('Mark Completed'))
        ],
      ),
    );
  }
}

class QuestionPage extends StatelessWidget {
  final Question question;
  const QuestionPage({Key? key, required this.question}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var state = Provider.of<QuizState>(context);
    return Column(
      children: [
        Expanded(
          child: Container(
            padding: EdgeInsets.all(16),
            alignment: Alignment.center,
            child: Text(question.text),
          ),
        ),
        Container(
          padding: EdgeInsets.all(20),
          child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: question.options.map((opt) {
                return Container(
                  height: 90,
                  margin: EdgeInsets.only(bottom: 10),
                  color: Colors.black26,
                  child: InkWell(
                    onTap: () {
                      state.selected = opt;
                      _bottomSheet(context, opt, state);
                    },
                    child: Container(
                      padding: EdgeInsets.all(16),
                      child: Row(
                        children: [
                          Icon(
                            state.selected == opt
                                ? FontAwesomeIcons.circleCheck
                                : FontAwesomeIcons.circle,
                            size: 30,
                          ),
                          Expanded(
                            child: Container(
                              margin: EdgeInsets.only(left: 16),
                              child: Text(
                                opt.value,
                                style: Theme.of(context).textTheme.bodyText2,
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                );
              }).toList()),
        )
      ],
    );
  }
}

_bottomSheet(BuildContext context, Option opt, QuizState state) {
  bool correct = opt.correct;

  showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Container(
          height: 250,
          padding: EdgeInsets.all(16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Text(correct ? 'Good Job!' : 'Wrong'),
              Text(
                opt.detail,
                style: const TextStyle(fontSize: 18, color: Colors.white54),
              ),
              ElevatedButton(
                  onPressed: () {
                    if(correct){
                      state.nextPage();
                    }
                    Navigator.pop(context);
                  },
                  style: ElevatedButton.styleFrom(
                      primary: correct ? Colors.green : Colors.red),
                  child: Text(
                    correct ? 'Onward!' : 'Try Again',
                    style: const TextStyle(
                        color: Colors.white,
                        letterSpacing: 1.5,
                        fontWeight: FontWeight.bold),
                  ))
            ],
          ),
        );
      });
}
