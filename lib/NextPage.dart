import 'dart:math';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:social_app/Post.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final baseUrl = "https://b517-103-17-77-3.ngrok-free.app/api";
  Future<List<Post>> getPost() async {
    Dio dio = Dio();
    Response response = await dio.get("${baseUrl}/post",
        options: Options(headers: {
          "Authorization": "Bearer 363|qpQOGJK47enYNl0FEaoLI2qkQhQbezaSpWSfye8i"
        }));

    List<Post> listPosts =
        (response.data['data'] as List).map((e) => Post.fromJson(e)).toList();

    return listPosts;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('List App'),
        ),
        body: ListView(
          children: [
            FutureBuilder(
                future: getPost(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  }
                  if (snapshot.hasError) {
                    return Text("error");
                  } else {
                    return SingleChildScrollView(
                      child: ListView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        // itemCount: 3,
                        itemCount: snapshot.data?.length,
                        itemBuilder: (context, index) {
                          return Container(
                            color: Colors.white,
                            child: Column(children: [
                              Row(
                                children: [
                                  CircleAvatar(
                                    radius: 18, // Image radius
                                    backgroundImage: NetworkImage(
                                        "${snapshot.data?[index].picture}"),
                                  ),
                                  const SizedBox(
                                    width: 10,
                                    height: 50,
                                  ),
                                  Text("${snapshot.data?[index].user.name}"),
                                ],
                              ),
                              Image.network(
                                "https://aldf.org/wp-content/uploads/2018/05/lamb-iStock-665494268-16x9-e1559777676675-1200x675.jpg",
                                width: MediaQuery.of(context).size.width,
                              ),
                              Container(
                                  padding: EdgeInsets.symmetric(horizontal: 12),
                                  child: RichText(
                                      textAlign: TextAlign.justify,
                                      text: TextSpan(children: [
                                        TextSpan(
                                            text:
                                                "${snapshot.data?[index].title}",
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                color: Colors.black)),
                                        TextSpan(
                                            text:
                                                "${snapshot.data?[index].content}",
                                            style:
                                                TextStyle(color: Colors.black))
                                      ]))),
                              // CircleAvatar(
                              //   radius: 18, // Image radius
                              //   backgroundImage: NetworkImage(
                              //       "${snapshot.data?[index].picture}"),
                              // ),
                            ]),
                          );
                        },
                      ),
                    );
                  }
                }),
          ],
        )

        // children: ListTile.divideTiles(
        //     color: Colors.deepPurple,
        //     tiles: listpost.map((item) => ListTile(
        //           leading: CircleAvatar(
        //             backgroundColor: Colors.amber,
        //             child: Text(item['id'].toString()),
        //           ),
        //           title: Text(item['title']),
        //           subtitle: Text(item['subtitle']),
        //           // trailing: IconButton(
        //           //   icon: const Icon(Icons.delete),
        //           //   onPressed: () {},
        //           // ),
        //         ))).toList()
        );
  }
}
