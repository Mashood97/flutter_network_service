/// This contains the basic understanding of how to send a single or multiple images to server, you need to pass the list of files
/// of images
/// You can integrate it easily with your flutter apps.
/// Api throws httpexception which is handled accordingly just use simple try and catch block and everything will be
/// handled by the package


import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_network_service_handler/src/http_network_service.dart';



void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List _usersList = [];

  var errorMessage = '';

  void _showErrorDialog(String message) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text('Error Occured'),
        content: Text(message),
        actions: <Widget>[
          ElevatedButton(
            onPressed: () {
              Navigator.of(ctx).pop();
            },
            child: Text('OK!'),
          )
        ],
      ),
    );
  }

  Future sendImageToServer() async {
    try {
      //Initialize HttpNetwork Service
      await HttpNetworkService.init(
        baseUrl: 'localhost',
      );
      //Then use it like this
      final response = await HttpNetworkService.sendImagesRequest(
        uri: '/blog-post',
        fileName: "BlogImg",
        images: [File("img1.png"), File("img2.png"), File("img3.png")],
        //options import from dio package.
        options: Options(headers: {
          "Content-Type": "application/json",
        }),
      );
      if (response != null) {
        debugPrint("Images send success");
      }
    } catch (error) {
      errorMessage = error.toString();
      _showErrorDialog(
        errorMessage,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
      child: Center(
        child: errorMessage.isEmpty
            ? ElevatedButton(
                onPressed: () async {
                  await sendImageToServer();
                },
                child: const Text(
                  "Send image to server",
                ),
              )
            : Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    const Text(
                      "Send image to server",
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    ElevatedButton(
                      onPressed: () async {
                        await sendImageToServer();
                      },
                      child: const Text(
                        "Send image to server Again",
                      ),
                    )
                  ],
                ),
              ),
      ),
    ));
  }
}
