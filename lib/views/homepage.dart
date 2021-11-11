// ignore_for_file: deprecated_member_use, must_be_immutable

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutternews/views/webview.dart';
import 'package:flutternews/helper/categorydata.dart';
import 'package:flutternews/helper/newsdata.dart';
import 'package:flutternews/model/categorymodel.dart';
import 'package:flutternews/model/newsmodel.dart';
import 'package:flutternews/views/categorypage.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // get our categories list

  List<CategoryModel> categories = List<CategoryModel>();

  // get our newslist first

  List<ArticleModel> articles = List<ArticleModel>();
  bool _loading = true;

  getNews() async {
    News newsdata = News();
    await newsdata.getNews();
    articles = newsdata.datatobesavedin;
    setState(() {
      _loading = false;
    });
  }

  @override
  void initState() {
    super.initState();
    categories = getCategories();
    getNews();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0.0,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              "Flutter ",
              style: TextStyle(color: Colors.black),
            ),
            Text(
              "News",
              style: TextStyle(color: Colors.blueAccent),
            ),
          ],
        ),
      ),

      // category widgets
      body: _loading
          ? Center(
              child: CircularProgressIndicator(),
            )
          : SingleChildScrollView(
              child: Container(
                color: Colors.white,
                child: Column(
                  children: <Widget>[
                    Container(
                      height: 70.0,
                      padding: EdgeInsets.symmetric(horizontal: 5.0),
                      child: ListView.builder(
                        itemCount: categories.length,
                        shrinkWrap: true,
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (context, index) {
                          return CategoryTile(
                            imageUrl: categories[index].imageUrl,
                            categoryName: categories[index].categoryName,
                          );
                        },
                      ),
                    ),
                    Container(
                      child: ListView.builder(
                        itemCount: articles.length,
                        physics: ClampingScrollPhysics(),
                        shrinkWrap: true, // add this otherwise an error
                        itemBuilder: (context, index) {
                          return NewsTemplate(
                            urlToImage: articles[index].urlToImage,
                            title: articles[index].title,
                            description: articles[index].description,
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
    );
  }
}

class CategoryTile extends StatelessWidget {
  final String categoryName, imageUrl;
  CategoryTile({this.categoryName, this.imageUrl});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => CategoryFragment(
                category: categoryName.toLowerCase(),
              ),
            ));
      },
      child: Container(
        margin: EdgeInsets.only(right: 16),
        child: Stack(
          children: <Widget>[
            ClipRRect(
                borderRadius: BorderRadius.circular(6),
                child: CachedNetworkImage(
                  imageUrl: imageUrl,
                  width: 200,
                  height: 130,
                  fit: BoxFit.cover,
                )),
            Container(
              alignment: Alignment.center,
              width: 200,
              height: 130,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(6),
                color: Colors.black26,
              ),
              child: Text(
                categoryName,
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w500,
                  fontSize: 18,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// creating template for news

class NewsTemplate extends StatelessWidget {
  String title, description, url, urlToImage;
  NewsTemplate({this.title, this.description, this.urlToImage, this.url});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => WebViewScreen(
                url: url,
              ),
            ));
      },
      child: Container(
        margin: EdgeInsets.all(16),
        child: Column(
          children: <Widget>[
            ClipRRect(
                borderRadius: BorderRadius.circular(6),
                child: CachedNetworkImage(
                  imageUrl: urlToImage,
                  width: 380,
                  height: 200,
                  fit: BoxFit.cover,
                )),
            SizedBox(height: 8),
            Text(
              title,
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18.0,
                  color: Colors.black),
            ),
            SizedBox(height: 8),
            Text(
              description,
              style: TextStyle(fontSize: 15.0, color: Colors.grey[800]),
            ),
          ],
        ),
      ),
    );
  }
}
