import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:news_app/View/home_screen.dart';
import 'package:news_app/View_Model/news_view_model.dart';

class CategoriesScreen extends StatefulWidget {
  const CategoriesScreen({super.key});

  @override
  State<CategoriesScreen> createState() => _CategoriesScreenState();
}

class _CategoriesScreenState extends State<CategoriesScreen> {
  NewsViewModel newsViewModel = NewsViewModel();
  final format = DateFormat('MM DD ,YYYY');
  String categryName = 'General';


  List<String> CategoriesList = [
    'General',
    'Sports',
    'Entertainment',
    'Health',
    'Business',
    'Technology',
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: Column(
          children: [
            SizedBox(
              height: 45,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: CategoriesList.length,
                itemBuilder: (Context, index) {
                  return InkWell(
                    onTap: (){
                      categryName = CategoriesList[index];
                      setState(() {
                        
                      });
                    },



                    child: Padding(
                      padding: const EdgeInsets.only(right: 10.0),
                      child: Container(
                        decoration: BoxDecoration(
                          color:  categryName == CategoriesList[index] ?  Colors.blue  : Colors.grey,
                          borderRadius: BorderRadius.circular(10)
                        ),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10.0),
                          child: Center(child: Text(CategoriesList[index].toString(),style:GoogleFonts.poppins(color: Colors.white, fontSize: 12, fontWeight: FontWeight.w400),)),
                        ),
                      ),
                    ),
                  );
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
