import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:news_app/Models/categories_news_model.dart';
import 'package:news_app/Models/news_channels_headlines_model.dart';
import 'package:news_app/View/categories_screen.dart';
import 'package:news_app/View_Model/news_view_model.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

enum NewsFilterList {
  bbcNews,
  aryNews,
  alJazeer,
  googleNews,
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
              if (NewsFilterList.googleNews.name == item.name) {
                name = 'google-news';
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
                value: NewsFilterList.googleNews,
                child: Text('Google News'),
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
          onPressed: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => CategoriesScreen()));
          },
          icon: Image.asset(
            'Assets/icon.png',
            height: 30,
            width: 30,
          ),
        ),
        title: Text(
          "News",
          style: GoogleFonts.poppins(
              fontSize: 24, fontWeight: FontWeight.bold, color: Colors.white),
        ),
        centerTitle: true, // Center the title in the AppBar
      ),
      body: ListView(
        children: [
          SizedBox(
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
                                              //THIS WILL SHOW THE TITLE IN MAXMIUM 2 LINES
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
          ),
          Padding(
            padding: const EdgeInsets.all(25.0),
            child: FutureBuilder<CategoriesNewsModel>(
                            future:
                                newsViewModel.fetchCategoriesNewsApi('General'),
                            builder: (BuildContext context, snapshot) {
                              if (snapshot.connectionState ==
                                  ConnectionState.waiting) {
                                return const Center(
                                  child: SpinKitDoubleBounce(
                                    color: Colors.blue,
                                    size: 40,
                                  ),
                                );
                              }
                              if (snapshot.hasData &&
                                  snapshot.data?.articles != null) {
                                return ListView.builder(
                                  shrinkWrap: true,
                                    itemCount: snapshot.data!.articles!.length,
                                    //it will change the scroll direction from vertical to horizontal
                                    scrollDirection: Axis.vertical,
                                    itemBuilder: (context, index) {
                                      DateTime dateTime = DateTime.parse(snapshot
                                          .data!.articles![index].publishedAt
                                          .toString());
                                      return Padding(
                                        padding:
                                            const EdgeInsets.only(bottom: 15.0),
                                        child: Row(
                                          children: [
                                            ClipRRect(
                                              borderRadius:
                                                  BorderRadius.circular(15),
                                              child: CachedNetworkImage(
                                                imageUrl: snapshot.data!
                                                    .articles![index].urlToImage
                                                    .toString(),
                                                fit: BoxFit.cover,
                                                height: height * 0.18,
                                                width: width * 0.3,
                                                placeholder: (context, url) =>
                                                    Container(
                                                  child: Center(
                                                    child: SpinKitDoubleBounce(
                                                      color: Colors.blue,
                                                      size: 40,
                                                    ),
                                                  ),
                                                ),
                                                errorWidget:
                                                    (context, url, error) => Icon(
                                                  Icons.error_outline,
                                                  color: Colors.transparent,
                                                ),
                                              ),
                                            ),
                                            Expanded(
                                                child: Container(
                                              height: height * 0.18,
                                              padding: EdgeInsets.only(left: 15),
                                              child: Column(
                                                children: [
                                                  Text(
                                                    snapshot.data!
                                                        .articles![index].title
                                                        .toString(),
                                                    maxLines: 3,
                                                    style: GoogleFonts.poppins(
                                                        fontSize: 15,
                                                        color: Colors.black54,
                                                        fontWeight:
                                                            FontWeight.w700),
                                                  ),
                                                  Spacer(),
                                                  Row(
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
                                                        style:
                                                            GoogleFonts.poppins(
                                                                fontSize: 13,
                                                                color: Colors
                                                                    .black54,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w700),
                                                      ),
                                                      Text(
                                                        format.format(dateTime),
                                                        style:
                                                            GoogleFonts.poppins(
                                                                fontSize: 15,
                                                                color: Colors
                                                                    .black54,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w700),
                                                      ),
                                                    ],
                                                  )
                                                ],
                                              ),
                                            ))
                                          ],
                                        ),
                                      );
                                    });
                              } else {
                                return Center(child: Text("No data available."));
                              }
                            },
                          ),
          ),
        ],
      ),
    );
  }
}

const spinkit2 = SpinKitFadingCircle(
  color: Colors.black,
  size: 50,
);
