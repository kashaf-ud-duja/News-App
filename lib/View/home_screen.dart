import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:news_app/Models/news_channels_headlines_model.dart';
import 'package:news_app/View/View_Model/news_view_model.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

enum NewsFilterList {
  bbcNews,
  aryNews,
  alJazeer,
  fortune,
  businessInsider,
  cnn,
}

class _HomeScreenState extends State<HomeScreen> {
  NewsViewModel newsViewModel = NewsViewModel();
  final format = DateFormat('MM DD ,YYYY');
  NewsFilterList? selectedMenu;
  String name = 'bbc-news';
  @override
  Widget build(BuildContext context) {
    //our screen size is 1
    final height = MediaQuery.sizeOf(context).height * 1;
    final width = MediaQuery.sizeOf(context).width * 1;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        actions: [
          PopupMenuButton<NewsFilterList>(
            icon: Icon(
              Icons.more_vert,
              color: Colors.black,
              size: 30,
            ),
            onSelected: (NewsFilterList item) {
              if (NewsFilterList.bbcNews.name == item.name) {
                name = 'bbc-news';
              }
              if (NewsFilterList.aryNews.name == item.name) {
                name = 'ary-news';
              }
              if (NewsFilterList.cnn.name == item.name) {
                name = 'cnn';
              }
              if (NewsFilterList.businessInsider.name == item.name) {
                name = 'business-insider';
              }
              if (NewsFilterList.alJazeer.name == item.name) {
                name = 'al-jazeera-english';
              }
              if (NewsFilterList.fortune.name == item.name) {
                name = 'fortune';
              }
              setState(() {
                selectedMenu = item;
              });
            },
            initialValue: selectedMenu,
            itemBuilder: (BuildContext context) =>
                <PopupMenuEntry<NewsFilterList>>[
              PopupMenuItem<NewsFilterList>(
                value: NewsFilterList.bbcNews,
                child: Text('BBC News'),
              ),
              PopupMenuItem<NewsFilterList>(
                value: NewsFilterList.aryNews,
                child: Text('ARY News'),
              ),
              PopupMenuItem<NewsFilterList>(
                value: NewsFilterList.alJazeer,
                child: Text('AL Jazeera'),
              ),
              PopupMenuItem<NewsFilterList>(
                value: NewsFilterList.fortune,
                child: Text('Fortune'),
              ),
              PopupMenuItem<NewsFilterList>(
                value: NewsFilterList.businessInsider,
                child: Text('Business Insider'),
              ),
              PopupMenuItem<NewsFilterList>(
                value: NewsFilterList.cnn,
                child: Text('CNN'),
              ),
            ],
          ),
        ],
        leading: IconButton(
          onPressed: () {},
          icon: Image.asset(
            'Assets/icon.png',
            height: 30,
            width: 30,
          ),
        ),
        title: Text(
          "News",
          style: GoogleFonts.poppins(fontSize: 24, fontWeight: FontWeight.bold),
        ),
        centerTitle: true, // Center the title in the AppBar
      ),
      body: ListView(
        children: [
          Container(
            height: height * 0.5,
            width: width,
            //color: Colors.red,
            child: FutureBuilder<NewsChannelsHeadlinesModel>(
              future: newsViewModel.fetchNewsChannelHeadlinesAPI(name),
              builder: (BuildContext context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(
                    child: SpinKitDoubleBounce(
                      color: Colors.blue,
                      size: 40,
                    ),
                  );
                }
                if (snapshot.hasData && snapshot.data?.articles != null) {
                  return ListView.builder(
                      itemCount: snapshot.data!.articles!.length,
                      //it will change the scroll direction from vertical to horizontal
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (context, index) {
                        // if (snapshot.data!.articles![index].publishedAt !=null) {
                        //   DateTime dateTime = DateTime.parse(snapshot
                        //       .data!.articles![index].publishedAt
                        //       .toString());
                        // } else {
                        //   DateTime dateTime =
                        //       DateTime.now(); // Fallback to current time
                        // }
                        DateTime dateTime = DateTime.parse(snapshot
                            .data!.articles![index].publishedAt
                            .toString());
                        return SizedBox(
                          child: Stack(
                            alignment: Alignment.center,
                            children: [
                              Container(
                                height: height * 0.6,
                                width: width * 1,
                                padding: EdgeInsets.symmetric(
                                  horizontal: height * 0.02,
                                  vertical: width * 0.04,
                                ),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(15),
                                  child: CachedNetworkImage(
                                    imageUrl: snapshot
                                        .data!.articles![index].urlToImage
                                        .toString(),
                                    fit: BoxFit.cover,
                                    placeholder: (context, url) => Container(
                                      child: spinkit2,
                                    ),
                                    errorWidget: (context, url, error) => Icon(
                                      Icons.error_outline,
                                      color: Colors.transparent,
                                    ),
                                  ),
                                ),
                              ),
                              Positioned(
                                bottom: 30,
                                child: Opacity(
                                  opacity: 0.8,
                                  child: Card(
                                    elevation: 20,
                                    color: Colors.white,
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(12)),
                                    child: Container(
                                      alignment: Alignment.bottomCenter,
                                      padding: EdgeInsets.all(15),
                                      height: height * 0.22,
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          Container(
                                            width: width * 0.7,
                                            child: Text(
                                              snapshot
                                                  .data!.articles![index].title
                                                  .toString(),
                                              //THIS WILL SHOW THE TITLE IN MAXIUM 2 LINES
                                              maxLines: 2,
                                              // this will handle the over flow of the titile
                                              overflow: TextOverflow.ellipsis,
                                              style: GoogleFonts.poppins(
                                                  fontSize: 17,
                                                  color: Colors.black,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                          ),
                                          Spacer(),
                                          Container(
                                            width: width * 0.7,
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Text(
                                                  snapshot
                                                      .data!
                                                      .articles![index]
                                                      .source!
                                                      .name
                                                      .toString(),
                                                  //THIS WILL SHOW THE TITLE IN MAXIUM 2 LINES
                                                  maxLines: 2,
                                                  // this will handle the over flow of the titile
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  style: GoogleFonts.poppins(
                                                      fontSize: 13,
                                                      color: Colors.black,
                                                      fontWeight:
                                                          FontWeight.w600),
                                                ),
                                                Text(
                                                  format.format(dateTime),
                                                  //THIS WILL SHOW THE TITLE IN MAXIUM 2 LINES
                                                  maxLines: 2,
                                                  // this will handle the over flow of the titile
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  style: GoogleFonts.poppins(
                                                      fontSize: 12,
                                                      color: Colors.black,
                                                      fontWeight:
                                                          FontWeight.w500),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              )
                            ],
                          ),
                        );
                      });
                } else {
                  return Center(child: Text("No data available."));
                }
              },
            ),
          )
        ],
      ),
    );
  }
}

const spinkit2 = SpinKitFadingCircle(
  color: Colors.black,
  size: 50,
);
