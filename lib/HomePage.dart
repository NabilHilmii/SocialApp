import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:social_app/Post.dart';

class SimpleFeedPage extends StatelessWidget {
  SimpleFeedPage({super.key});

  Future<List<Post>> getData() async {
    var dio = Dio();
    var response = await dio.get("https://booking.kai.id/api/stations2");
    List<dynamic> listDinamis = response.data as List;
    List<Post> listPosts = listDinamis.map((e) => Post.fromJson(e)).toList();

    return listPosts;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Instameter",
          style: TextStyle(color: Colors.black),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(
              height: 20,
              child: Text("Tempat Story"),
            ),
            // posts
            FutureBuilder(
                future: getData(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(child: const CircularProgressIndicator());
                  }

                  if (snapshot.hasError) {
                    return Text("ini tampilan ketika error");
                  } else {
                    return SizedBox(
                      width: MediaQuery.of(context).size.width,
                      child: ListView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        // itemCount: 3,
                        itemCount: snapshot.data?.length,
                        itemBuilder: (ctx, index) {
                          print(index);
                          return Container(
                              color: Colors.white,
                              child: Column(children: [
                                Container(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 10,
                                    vertical: 10,
                                  ),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Row(
                                        children: [
                                          // CircleAvatar(
                                          //   radius: 18, // Image radius
                                          //   backgroundImage: NetworkImage(
                                          //       "${snapshot.data?[index].userImage}"),
                                          // ),
                                          const SizedBox(
                                            width: 10,
                                          ),
                                          Text("${snapshot.data?[index].user}"),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                                // Image.network(
                                //   "${snapshot.data?[index].postImage}",
                                //   width: MediaQuery.of(context).size.width,
                                // ),
                                Container(
                                  margin: EdgeInsets.symmetric(horizontal: 15),
                                  child: Row(
                                    children: [
                                      Icon(Icons.favorite_border),
                                    ],
                                  ),
                                ),
                                Row(
                                  children: [
                                    Container(
                                        margin: EdgeInsets.symmetric(
                                            horizontal: 15),
                                        child: Text(
                                            "${snapshot.data?[index].title}")),
                                  ],
                                ),
                              ]));
                        },
                      ),
                    );
                  }
                }),
          ],
        ),
      ),
    );
  }
}
