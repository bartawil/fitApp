import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:post_repository/post_repository.dart';

class PostList extends StatelessWidget {
  final List<Post> posts;

  const PostList({Key? key, required this.posts}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: posts.length,
      itemBuilder: (context, int i) {
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            width: double.infinity,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Container(
                        width: 50,
                        height: 50,
                        decoration: BoxDecoration(
                            color: Colors.grey,
                            shape: BoxShape.circle,
                            image: DecorationImage(
                                image: NetworkImage(posts[i].myUser.picture!),
                                fit: BoxFit.cover)),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            posts[i].myUser.firstName,
                            style: const TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 18),
                          ),
                          const SizedBox(height: 5),
                          Text(DateFormat('yyyy-MM-dd').format(posts[i].createAt))
                        ],
                      )
                    ],
                  ),
                  const SizedBox(height: 10),
                  Container(
                    child: Text(
                      posts[i].post,
                    ),
                  )
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}