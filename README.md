# 🎖 Installing

1) First goto your pubspec.yaml file and add dependency:
   ```
   flutter_network_service:
   ```
2) run flutter pub get to update the packages dependencies.

# ⚡️ Import
3) In your code, you can use it like this:
  first import the package:
  ```
 import 'package:flutter_network_service/HttpNetworkService.dart';
  ```
# 🎮 Code Usage
then use it like this in your code:
  ```

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutternetworkservicehandler/src/http_network_service.dart';

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

  var errorMessage = 'Can\'t proceed request';

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

  Future getUsersData() async {
    try {
      //Initialize HttpNetwork Service
      await HttpNetworkService.init(
        baseUrl: 'https://jsonplaceholder.typicode.com',
      );
      //Then use it like this
      final responseUsersList = await HttpNetworkService.getRequest(
        uri: '/userss',
        //options import from dio package.
        options: Options(headers: {
          "Content-Type": "application/json",
        }),
      );
      for (var items in responseUsersList) {
        print(items);
        _usersList.add({
          'id': items['id'],
          'username': items['username'],
          'website': items['website'],
        });
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
      body: FutureBuilder(
        future: getUsersData(),
        builder: (ctx, snapshot) =>
            snapshot.connectionState == ConnectionState.waiting
                ? Center(
                    child: CircularProgressIndicator(),
                  )
                : snapshot.data == null
                    ? Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.error,
                              size: 75,
                              color: Colors.red,
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                errorMessage.toUpperCase(),
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontSize: 16.0,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                            ),
                          ],
                        ),
                      )
                    : ListView.builder(
                        itemCount: _usersList.length,
                        itemBuilder: (ctx, i) => ListTile(
                          title: Text(_usersList[i]['username']),
                          subtitle: Text(_usersList[i]['website']),
                          leading: CircleAvatar(
                            child: FittedBox(
                              child: Text(
                                _usersList[i]['id'].toString(),
                              ),
                            ),
                          ),
                          trailing: Icon(
                            Icons.arrow_forward_ios,
                          ),
                        ),
                      ),
      ),
    );
  }
}

```
# FOR MORE EXAMPLES REFER TO example/lib folder.

# 🐛 Bugs/Requests
If you encounter any problems feel free to open an issue. If you feel the library is
missing some feature, please raise a ticket on Github. Pull request are also welcome.

# 🚀 SUPPORT
You liked this package? then give it a star. If you want to help then:
Star this repository.
Send a Pull Request with new features, see Contribution Guidelines.
Share this package.
Create issues if you find a Bug or want to suggest something.

