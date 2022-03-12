import 'package:flutter/material.dart';
import 'package:fluttertest/src/controllers/posts_controller.dart';
import 'package:fluttertest/src/models/posts.dart';

class PostsScreen extends StatefulWidget {
  final int id;
  PostsScreen({Key? key, required this.id}) : super(key: key);

  @override
  State<PostsScreen> createState() => _PostsScreenState();
}

class _PostsScreenState extends State<PostsScreen> {
  final PostsController _postsController = PostsController();
  Posts? data = null;

  @override
  void initState() {
    super.initState();
    _getInfo();
  }

  _getInfo() async {
    data = await _postsController.postsById(widget.id);
    setState(() {
      print(data!.body);
    });
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Posts '),
        centerTitle: true,
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(
          vertical: size.height * 0.06,
          horizontal: size.width * 0.03,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            _text('Titulo:'),
            SizedBox(height: size.height * 0.005),
            _body(data != null ? data!.title : ""),
            SizedBox(height: size.height * 0.02),
            _text('Descripción:'),
            SizedBox(height: size.height * 0.005),
            _body(data != null ? data!.body : ""),
          ],
        ),
      ),
    );
  }

  Widget _body(String body) {
    return Container(
      width: double.infinity,
      child: Text(
        body,
        style: const TextStyle(fontSize: 16),
        textAlign: TextAlign.justify,
      ),
    );
  }

  Widget _text(String title) {
    return SizedBox(
      width: double.infinity,
      child: Text(
        title,
        style: const TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 22,
        ),
        textAlign: TextAlign.left,
      ),
    );
  }
}
