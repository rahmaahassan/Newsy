import 'package:flutter/material.dart';
import 'package:flutternews/helper/widgets.dart';
import 'package:flutternews/helper/news.dart';


class CategoryNews extends StatefulWidget {

  final String newsCategory;

  CategoryNews({this.newsCategory});

  @override
  _CategoryNewsState createState() => _CategoryNewsState();
}

class _CategoryNewsState extends State<CategoryNews> {


  var newsList;
  bool _loading = true;

  @override
  void initState() {
    getNews();
    super.initState();
  }

  void getNews() async {
    NewsForCategories news = NewsForCategories();
    await news.getNewsForCategory(widget.newsCategory);
    newsList = news.news;
    setState(() {
      _loading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.newsCategory,
            style: TextStyle(color: Colors.black87, fontWeight: FontWeight.w600)),
        actions: <Widget>[
          Opacity(
            opacity: 0,
            child: Container(
                padding: EdgeInsets.symmetric(horizontal: 16),
                child: Icon(Icons.share,)),
          )
        ],
        backgroundColor: Colors.transparent,
        elevation: 0.0,
      ),
      body: _loading ? Center(
        child: CircularProgressIndicator(),
      ) : SingleChildScrollView(
        child: Container(
          child: Container(
            margin: EdgeInsets.only(top: 16),
            child: ListView.builder(
                itemCount: newsList.length,
                shrinkWrap: true,
                physics: ClampingScrollPhysics(),
                itemBuilder: (context, index) {
                  return NewsTile(
                    imgUrl: newsList[index].urlToImage ?? "",
                    title: newsList[index].title ?? "",
                    desc: newsList[index].description ?? "",
                    content: newsList[index].content ?? "",
                    posturl: newsList[index].articleUrl ?? "",
                  );
                }),
          ),
        ),
      ),
    );
  }
}