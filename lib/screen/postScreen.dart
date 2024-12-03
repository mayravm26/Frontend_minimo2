import 'package:flutter/material.dart';
import 'package:flutter_application_1/controllers/postsListController.dart';
import 'package:flutter_application_1/Widgets/postCard.dart';
import 'package:get/get.dart';

class PostsScreen extends StatefulWidget {
  @override
  _PostsScreenState createState() => _PostsScreenState();
}

class _PostsScreenState extends State<PostsScreen> {
  final PostsListController postListController = Get.put(PostsListController());

  @override
  void initState() {
    super.initState();
    postListController.fetchPosts();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Foro de Posts',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: const Color(0xFF89AFAF),
      ),
      body: Center(
        child: Container(
          width: MediaQuery.of(context).size.width * 0.6, // Ajusta el ancho al 60% de la pantalla
          padding: const EdgeInsets.all(16.0),
          child: Obx(() {
            if (postListController.isLoading.value) {
              return const Center(child: CircularProgressIndicator());
            } else if (postListController.postList.isEmpty) {
              return const Center(
                child: Text(
                  "No hay posts disponibles",
                  style: TextStyle(
                    fontSize: 16,
                    color: Color(0xFF89AFAF),
                  ),
                ),
              );
            } else {
              return ListView.builder(
                itemCount: postListController.postList.length,
                itemBuilder: (context, index) {
                  final post = postListController.postList[index];
                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    child: PostCard(
                      post: post,
                      //onDelete: () =>
                          //postListController.postToDelete(post.id),
                    ),
                  );
                },
              );
            }
          }),
        ),
      ),
    );
  }
}
