import 'dart:developer';
import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

Widget smallcard({String? image, String? titledoc, double? ratingnew}) {
  return Container(
    // margin: const EdgeInsets.only(top: 5, bottom: 5),
    child: Column(
      verticalDirection: VerticalDirection.up,
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Container(
          // padding: const EdgeInsets.only(left: 5, right: 5, bottom: 5, top: 5),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: Image.network(
              image!,
              fit: BoxFit.fill,
              width: 80,
              height: 65,
            ),
          ),
        ),
        SizedBox(
          child: Column(
            children: [
              Container(
                margin: const EdgeInsets.only(top: 5, bottom: 5),
                child: Text(
                  titledoc!,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    color: Colors.amber,
                    decorationStyle: TextDecorationStyle.wavy,
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              RatingBarIndicator(
                rating: ratingnew!,
                itemBuilder: (context, index) => const Icon(
                  Icons.star,
                  color: Colors.amber,
                ),
                itemCount: 5,
                itemSize: 16,
                direction: Axis.horizontal,
              ),
            ],
          ),
        )
      ],
    ),
  );
}
