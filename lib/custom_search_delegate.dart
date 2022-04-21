import 'package:flutter/material.dart';
import 'package:search_delegate_app/api_services.dart';
import 'package:search_delegate_app/user_model.dart';

class CustomDelegate extends SearchDelegate<String> {

  FetchUser _userList = FetchUser();


  @override
  List<Widget>? buildActions(BuildContext context) {
    // TODO: implement buildActions
    //throw UnimplementedError();
    return [
      IconButton(
        icon: Icon(Icons.close),
        onPressed: () {
          //close(context, "result");
          query = "";
        },
      )
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    // TODO: implement buildLeading
    //throw UnimplementedError();
    return IconButton(
      icon: const Icon(Icons.arrow_back_ios_sharp),
      onPressed: () {
        Navigator.pop(context);
      },
    );
  }

  @override
  PreferredSizeWidget buildBottom(BuildContext context) {
    return PreferredSize(
        preferredSize: Size.fromHeight(25.0),
        child: Row(
          children: const [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 4.0),
              child: Chip(label: Text('Map')),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal:4.0),
              child: Chip(label: Text('Shop')),
            )
          ],
        ));
  }

  @override
  Widget buildResults(BuildContext context) {
    // TODO: implement buildResults
    return Container(
      child: Text(query),
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    // TODO: implement buildSuggestions
    //throw UnimplementedError();
    return Container(
        child: FutureBuilder<List<Userlist>>(
            future: _userList.getUserList(),
            builder: (context, snapshot) {

              if (!snapshot.hasData) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
              var data = snapshot.data!.where((element) => element.name!.toLowerCase().contains(query.toLowerCase()));
              return ListView(
                children: data.map((e){
                  return Card(
                    child: ListTile(
                      onTap: (){
                        query=e.name!;
                      },
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
                           SizedBox(
                            width: 10,
                          ),
                          Column(
                              crossAxisAlignment:
                              CrossAxisAlignment.start,
                              children: [
                                Text(
                                  e.name ??
                                      'Issue',
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold),
                                ),
                                Text(e.email ??
                                        'Issue',
                                    style: TextStyle(fontSize: 11))
                              ])
                        ],
                      ),
                    ),
                  );
                }).toList(),
              );
            })) ;//
  }
}
