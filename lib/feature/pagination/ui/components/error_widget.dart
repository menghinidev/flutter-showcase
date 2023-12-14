import 'package:flutter/material.dart';

class PaginationListErrorWidget extends StatelessWidget {
  const PaginationListErrorWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Column(
        children: [
          Icon(Icons.info),
          SizedBox(height: 20),
          Text(
            "Something Went Wrong!",
            style: TextStyle(color: Colors.black),
          ),
        ],
      ),
    );
  }
}
