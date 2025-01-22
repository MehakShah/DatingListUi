import 'package:flutter/material.dart';
import 'package:task/utils/appColors.dart';
import 'package:task/utils/appDimens.dart';

class UserDetailCard extends StatelessWidget {
  final String title;
  final String name;
  final String date;
  final String imgLink;

  final String location;
  final String distance;
  const UserDetailCard(
      {Key? key,
      required this.title,
      required this.imgLink,
      required this.name,
      required this.date,
      required this.location,
      required this.distance})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16.0),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Icon(Icons.calendar_month_rounded, color: AppColors().blue),
                  SizedBox(width: 8.0),
                  Text(title,
                      style: TextStyle(
                        fontSize: 16.0,
                        fontWeight: FontWeight.bold,
                      )),
                  Spacer(),
                  Icon(Icons.more_horiz),
                ],
              ),
              Divider(),
              Row(
                children: [
                  Stack(
                    children: [
                      CircleAvatar(
                        backgroundColor: AppColors().blue,
                        radius: 25,
                        child: CircleAvatar(
                          radius: 23,
                          backgroundImage: NetworkImage(imgLink),
                        ),
                      ),
                      Positioned(
                        bottom: 0,
                        right: 0,
                        child: Icon(
                          Icons.circle,
                          color: AppColors().green,
                          size: 16,
                        ),
                      )
                    ],
                  ),
                  SizedBox(width: 16.0),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(name,
                          style: TextStyle(
                            fontSize: 16.0,
                            fontWeight: FontWeight.bold,
                          )),
                      Text(distance),
                    ],
                  ),
                  Spacer(),
                  Icon(Icons.catching_pokemon_sharp, color: AppColors().blue),
                  Appdimens().sizebox20,
                  Icon(Icons.phone, color: AppColors().blue),
                ],
              ),
              Appdimens().sizebox15,
              IntrinsicHeight(
                child: Row(
                  children: [
                    Expanded(
                      child: Column(
                        children: [
                          Row(
                            children: [
                              Icon(Icons.date_range, color: AppColors().blue),
                              Appdimens().sizebox10,
                              Text('Date'),
                            ],
                          ),
                          Appdimens().sizebox10,
                          Align(
                              alignment: Alignment.centerLeft,
                              child: Text(date))
                        ],
                      ),
                    ),
                    VerticalDivider(),
                    Appdimens().sizebox20,
                    Expanded(
                      child: Column(
                        children: [
                          Row(
                            children: [
                              Icon(Icons.location_on_outlined,
                                  color: AppColors().blue),
                              Appdimens().sizebox10,
                              Text('Location'),
                            ],
                          ),
                          Appdimens().sizebox10,
                          Align(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                location,
                              ))
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
