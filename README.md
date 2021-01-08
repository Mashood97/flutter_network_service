# 🎖 Installing

1) First goto your pubspec.yaml file and add dependency:
   ```
   flutternetworkservicehandler:
   ```
2) run flutter pub get to update the packages dependencies.

# ⚡️ Import
3) In your code, you can use it like this:
  first import the package:
  ```
 import 'package:flutternetworkservicehandler/HttpNetworkService.dart';
  ```
# 🎮 Code Usage
then use it like this in your code:
  ```

import 'package:flutter/material.dart';
import 'package:flutternetworkservicehandler/src/http_network_service.dart';
import 'package:flutternetworkservicehandler/src/http_exception.dart';

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
          FlatButton(
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
      final responseUsersList = await HttpNetworkService.getRequest(
          url: 'https://jsonplaceholder.typicode.com/userss',
          headers: {
            'Content-Type': 'application/x-www-form-urlencoded',
          },
            networkCheckDurationInSeconds: 30,
          );
      for (var items in responseUsersList) {
        print(items);
        _usersList.add({
          'id': items['id'],
          'username': items['username'],
          'website': items['website'],
        });
      }
    } on HttpException catch (error) {
      if (error.toString().contains('Redirection error')) {
        errorMessage = 'The resource requested has been temporarily moved.';
      } else if (error.toString().contains('Bad Request Format')) {
        errorMessage = 'Your client has issued a malformed or illegal request.';
      } else if (error.toString().contains('Internal Server Error')) {
        errorMessage =
            'The server encountered an error and could not complete your request.';
      } else if (error.toString().contains('No Internet Found')) {
        errorMessage =
            'There is no or poor internet connect. Please try again later';
      }
      _showErrorDialog(errorMessage);
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
# 🐛 Bugs/Requests 
If you encounter any problems feel free to open an issue. If you feel the library is
missing some feature, please raise a ticket on Github. Pull request are also welcome.

# 🚀 SUPPORT
You liked this package? then give it a star. If you want to help then:
Star this repository.
Send a Pull Request with new features, see Contribution Guidelines.
Share this package.
Create issues if you find a Bug or want to suggest something.

