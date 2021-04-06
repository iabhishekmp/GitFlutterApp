import 'package:flutter/material.dart';
import 'package:git_users/providers/users_provider.dart';
import 'package:git_users/widgets/list_item.dart';
import 'package:git_users/widgets/search_bar.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  static final routeName = 'homepage';

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();
    setState(() {
      Provider.of<UsersProvider>(context, listen: false).fetchUsers();
    });
  }

  bool isLoading = false;

  Future _loadMore() async {
    await Provider.of<UsersProvider>(context, listen: false)
        .fetchUsers()
        .then((_) => setState(() {
              isLoading = false;
            }));
  }

  @override
  Widget build(BuildContext context) {
    print('Build method of homepage.');
    final users = Provider.of<UsersProvider>(context);
    return Column(
      children: [
        Container(
          margin: EdgeInsets.symmetric(horizontal: 4, vertical: 10),
          padding: EdgeInsets.all(15),
          child: Column(
            children: [
              SizedBox(
                height: 30,
              ),
              SearchBar(),
            ],
          ),
        ),
        // // Divider(
        // //   height: 0,
        // //   thickness: 3,
        // // ),
        // SizedBox(
        //   height: 0,
        // ),
        Expanded(
          child: Column(
            children: [
              Expanded(
                child: NotificationListener<ScrollNotification>(
                  onNotification: (ScrollNotification scrollInfo) {
                    if (users.userName == "" &&
                        !isLoading &&
                        scrollInfo.metrics.pixels ==
                            scrollInfo.metrics.maxScrollExtent) {
                      _loadMore();
                      setState(() {
                        isLoading = true;
                      });
                    }
                  },
                  child: ListView.builder(
                    itemBuilder: (ctx, i) => ListItem(users.users[i]),
                    itemCount: users.users.length,
                  ),
                ),
              ),
              Container(
                height: isLoading ? 50.0 : 0.0,
                child: Center(
                  child: CircularProgressIndicator(),
                ),
              )
            ],
          ),
        ),
      ],
    );
  }
}
