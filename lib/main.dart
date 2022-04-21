import 'package:flutter/material.dart';
import 'package:search_delegate_app/api_services.dart';
import 'package:search_delegate_app/custom_search_delegate.dart';
import 'package:search_delegate_app/user_model.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  FetchUser _userList = FetchUser();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          appBar: AppBar(
            actions: [
              IconButton(
                icon: Icon(Icons.search),
                onPressed: () {
                  showSearch(context: context, delegate: CustomDelegate());
                },
              )
            ],
            // Here we take the value from the MyHomePage object that was created by
            // the App.build method, and use it to set our appbar title.
            title: Text('Search Delegates Application'),
          ),
          body: Container(
              child: FutureBuilder<List<Userlist>>(
                  future: _userList.getUserList(),
                  builder: (context, snapshot) {
                    var data = snapshot.data;
                    if (!snapshot.hasData) {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    }
                    return ListView.builder(
                      itemCount: 10,
                      itemBuilder: (ctx, index) {
                        return Card(
                          child: ListTile(
                            title: Row(
                              children: [
                                Container(
                                  height: 60,
                                  width: 60,
                                  decoration: BoxDecoration(
                                      color: Colors.purple,
                                      borderRadius: BorderRadius.circular(10)),
                                  child: Center(
                                      child: Text( "ID", style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold),
                                  )),
                                ),
                                const SizedBox(
                                  width: 10,
                                ),
                                Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        snapshot.data!.elementAt(index).name ??
                                            'Issue',
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold),
                                      ),
                                      Text(
                                          snapshot.data!
                                                  .elementAt(index)
                                                  .email ??
                                              'Issue',
                                          style: TextStyle(fontSize: 11))
                                    ])
                              ],
                            ),
                          ),
                        );
                      },
                    );
                  })) // This trailing comma makes auto-formatting nicer for build methods.
          ),
    );
  }
}
