import 'package:flutter/material.dart';
import 'package:forumapp/views/post_details.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:get/get.dart';

class PosttData extends StatelessWidget {
  const PosttData({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10),
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.grey[200],
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Precios Oladele', style: GoogleFonts.poppins()),
          Text('ahduahduah.com', style: GoogleFonts.poppins(fontSize: 10)),
          const SizedBox(height: 10),
          Text('I am a Black Hat'),
          Row(
            children: [
              IconButton(onPressed: () {}, icon: Icon(Icons.thumb_up)),
              IconButton(
                onPressed: () {
                  Get.to(() => PostDetails());
                },
                icon: Icon(Icons.message),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class PostData extends StatelessWidget {
  const PostData({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10),
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.grey[200],
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Farelia rajendrae', style: GoogleFonts.poppins()),
          Text('rajendrae99.com', style: GoogleFonts.poppins(fontSize: 10)),
          const SizedBox(height: 10),
          Text('I am a Black Hat'),
          Row(
            children: [
              IconButton(onPressed: () {}, icon: Icon(Icons.thumb_up)),
            ],
          ),
        ],
      ),
    );
  }
}
