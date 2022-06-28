/// /// /// /// /// /// /// /// /// /// /// /// /// /// /// /// /// /// /// ///
/// Home screen to be displayed after the user login into the app
/// /// /// /// /// /// /// /// /// /// /// /// /// /// /// /// /// /// /// ///


import 'package:flutter/material.dart';

import '../login/screen/login.dart';
import '../video_player/screen/video_player.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Future<bool> _onWillPop() async {
    return false;
  }

  signOut() async {
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => LoginPage()));
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        onWillPop: _onWillPop,
        child: Scaffold(
            appBar: AppBar(
              automaticallyImplyLeading: false,
              backgroundColor: Colors.transparent,
              flexibleSpace: const Image(
                image: AssetImage('assets/images/login_image.jpg'),
                fit: BoxFit.cover,
              ),
              title: const Text("Explore"),
              actions: [
                IconButton(
                  onPressed: () {
                    showSearch(
                        context: context, delegate: CustomSearchDelegate());
                  },
                  icon: const Icon(Icons.search),
                )
              ],
            ),
            floatingActionButton: FloatingActionButton(
              onPressed: () {
                showAlertDialog(context);
              },
              backgroundColor: Colors.grey,
              child: const Icon(Icons.logout_rounded),
            ),
            body: Column(mainAxisSize: MainAxisSize.min, children: <Widget>[
              VideoPlayerWidget(
                searchItemName: '',
              )
            ])));
  }

  showAlertDialog(BuildContext context) {
    Widget cancelButton = TextButton(
      child: const Text("Cancel"),
      onPressed: () {
        Navigator.pop(context);
      },
    );

    // set up the button
    Widget okButton = TextButton(
      child: const Text("Yes"),
      onPressed: () {
        signOut();
      },
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: const Text("Alert"),
      content: const Text("Are you sure you want to logout"),
      actions: [
        okButton,
      ],
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }
}

class CustomSearchDelegate extends SearchDelegate {
  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        icon: const Icon(Icons.clear),
        onPressed: () {
          query = '';
        },
      ),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.arrow_back),
      onPressed: () {
        close(context, null);
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    return Column(mainAxisSize: MainAxisSize.min, children: <Widget>[
      VideoPlayerWidget(
        searchItemName: query,
      )
    ]);
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return Column();
  }
}
