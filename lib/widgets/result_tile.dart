import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

Widget detailsTile(String title, String value) {

  return Container(
    width: double.infinity,
    padding: const EdgeInsets.all(15),

    decoration: BoxDecoration(
      color: Colors.grey.shade100,
      borderRadius: BorderRadius.circular(15),
    ),

    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,

      children: [

        Text(
          title,
          style: const TextStyle(
            color: Colors.grey,
            fontWeight: FontWeight.w500,
          ),
        ),

        const SizedBox(height: 8),

        Text(
          value.isEmpty ? "Not Found" : value,
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    ),
  );
}
