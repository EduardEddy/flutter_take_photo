import 'package:flutter/material.dart';
import 'package:fluttertest/src/controllers/posts_controller.dart';
import 'package:fluttertest/src/screen/posts_screen.dart';

class ListPosts extends StatelessWidget {
  ListPosts({Key? key}) : super(key: key);
  final PostsController _postsController = PostsController();

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return FutureBuilder(
      future: _postsController.getPosts(context),
      builder: (_, AsyncSnapshot snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          return ListView.builder(
              itemCount: snapshot.data.length,
              itemBuilder: (BuildContext ctx, int index) {
                return _card(size, snapshot, index, context);
              });
        } else {
          return Padding(
            padding: EdgeInsets.symmetric(
                vertical: size.height * 0.45, horizontal: size.width * 0.42),
            child: const CircularProgressIndicator(),
          );
        }
      },
    );
  }

  Widget _card(Size size, AsyncSnapshot<dynamic> snapshot, int index,
      BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => PostsScreen(id: snapshot.data[index].id),
          ),
        );
      },
      child: Container(
        margin: EdgeInsets.symmetric(
          vertical: size.height * 0.015,
          horizontal: size.width * 0.06,
        ),
        padding: EdgeInsets.symmetric(
          vertical: size.height * 0.03,
          horizontal: size.width * 0.06,
        ),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(15),
          border: Border.all(width: 0.06),
          boxShadow: const [
            BoxShadow(
              color: Colors.grey,
              offset: Offset(0.0, 1.0), //(x,y)
              blurRadius: 6.0,
            ),
          ],
        ),
        child: Text('${snapshot.data[index].title.toUpperCase()}'),
      ),
    );
  }
}
