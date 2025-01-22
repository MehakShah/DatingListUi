import 'dart:isolate';

import 'package:flutter/material.dart';
import 'package:task/screens/Controller/users.dart';
import 'package:task/utils/appColors.dart';
import 'package:task/utils/appDimens.dart';
import 'package:task/utils/userdetail_card.dart';
import 'package:task/screens/models/userData.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List<UserData> _users = [];
  int totalResults = 10;
  ScrollController scrollController = ScrollController();
  bool _isLoading = false;
  String _errorMessage = '';

  @override
  void initState() {
    super.initState();
    _fetchData();
    scrollController.addListener(onScroll);
  }

  void onScroll() {
    print(scrollController.position.extentAfter);
    if (scrollController.position.extentAfter <= 200) {
      totalResults += 10;
      print('eeeeeeeeeeeeeeeeeeeeeeeeeeee');
      if (!_isLoading) {
        _fetchData();
      }
    }
  }

  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }

  Future<void> _fetchData() async {
    try {
      setState(() {
        _isLoading = true;
      });
      List<UserData>? fetchedUsers =
          await UserProvider().fetchDatingList(totalResults);
      print(fetchedUsers!.length);
      print("lengthhhhhhhhhh");
      setState(() {
        _users = fetchedUsers;
        _isLoading = false;
      });
    } catch (error) {
      setState(() {
        _errorMessage = error.toString();
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Container(
            margin: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16),
              color: AppColors().blue,
            ),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Stack(
                children: [
                  Column(
                    children: [
                      Text(
                        "Dating List",
                        style: TextStyle(
                            color: AppColors().white,
                            fontSize: 22,
                            fontWeight: FontWeight.bold),
                      ),
                      Appdimens().sizebox15,
                      TextField(
                        decoration: InputDecoration(
                          fillColor: AppColors().white,
                          filled: true,
                          hintText: 'Search',
                          prefixIcon: const Icon(
                            Icons.search,
                            size: 28,
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30.0),
                          ),
                        ),
                      ),
                    ],
                  ),
                  Positioned(
                    top: 0,
                    left: 0,
                    child: Icon(
                      Icons.arrow_back,
                      color: AppColors().white,
                      size: 28,
                    ),
                  )
                ],
              ),
            ),
          ),
          Appdimens().sizebox10,
          if (_users.isNotEmpty && !_isLoading)
            Expanded(
              child: _errorMessage.isNotEmpty
                  ? Center(
                      child: Text(
                        _errorMessage,
                        style: TextStyle(color: Colors.red),
                      ),
                    )
                  : _users.isEmpty && !_isLoading
                      ? const Center(child: Text('No users found.'))
                      : ListView.builder(
                          controller: scrollController,
                          itemCount: _users!.length,
                          itemBuilder: (BuildContext context, int index) {
                            final user = _users![index];
                            return UserDetailCard(
                              imgLink: user.picture?.thumbnail ?? '',
                              title: '${user.name?.title}',
                              name:
                                  '${user.name?.first ?? ''} ${user.name?.last ?? ''}',
                              // date: 'Sun, Jul 17 2024, 08:00 PM',
                              date: "${user.location!.timezone?.offset ?? " "}",
                              location:
                                  '${user.location?.city ?? ''}, ${user.location?.country ?? ''}',
                              distance:
                                  '3 km away', // Replace with actual distance logic if needed
                            );
                          },
                        ),
            ),
          // if (_users.isEmpty && _isLoading)
          //   Expanded(child: Center(child: CircularProgressIndicator())),
          if (_isLoading) Center(child: CircularProgressIndicator()),
        ]),
      ),
    );
  }
}
