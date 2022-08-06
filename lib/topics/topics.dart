import 'package:fireshipapp/main.dart';
import 'package:fireshipapp/services/firestore.dart';
import 'package:fireshipapp/shared/bottom_nav.dart';
import 'package:fireshipapp/shared/loading.dart';
import 'package:fireshipapp/topics/topics_item.dart';
import 'package:flutter/material.dart';

import '../services/models.dart';
import 'drawer.dart';

class TopicsScreen extends StatelessWidget {
  const TopicsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Topic>>(
        future: FirestoreService().getTopics(),
        builder: (context,snapshot){
          if(snapshot.connectionState == ConnectionState.waiting){
            return const LoadingScreen();
          }
          else if (snapshot.hasError){
            return Center(
              child: Text(snapshot.error.toString()),
            );
          }
          else if (snapshot.hasData){
            var topics = snapshot.data!;

            return Scaffold(
              appBar: AppBar(

                backgroundColor: Colors.deepPurple,
                title: const Text("Topics"),
              ),

              drawer: TopicDrawer(topics : topics),
              body: GridView.count(
                crossAxisCount: 2,
                primary: false,
                crossAxisSpacing: 10.0,
                padding: const EdgeInsets.all(20.0),
                children: topics.map((topic) => TopicItem(topic: topic)).toList(),
              ),
              bottomNavigationBar: const BottomNavBar(),
            );
          }
          else{
            return const Center(child:Text("No topics found in firestore. Check Database"));
          }
    });
  }
}
