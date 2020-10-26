import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutternews/helper/data.dart';
import 'package:flutternews/helper/news.dart';
import 'package:flutternews/helper/widgets.dart';
import 'package:flutternews/models/category_model.dart';
import 'package:flutternews/widgets/category_tile.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  bool isLoading = false;
  var newsList;

  List<CategoryModel> categories = new List<CategoryModel>();

  @override
  void initState() {
    isLoading = true;
    super.initState();

    categories = getCategories();
    getNews();
  }

  Future<void> getNews() async {
    News news = News();
    await news.getNews();
    newsList = news.news;
    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'World',
              style:
                  TextStyle(color: Colors.black87, fontWeight: FontWeight.w600),
            ),
            const Text(
              'News',
              style: TextStyle(color: Colors.blue, fontWeight: FontWeight.w600),
            )
          ],
        ),
        backgroundColor: Colors.transparent,
        elevation: 0.0,
      ),
      body: newsList == null
          ? Center(
              child: CircularProgressIndicator(
                backgroundColor: Colors.white,
                strokeWidth: 3.0,
              ),
            )
          : RefreshIndicator(
              onRefresh: getNews,
              child: Column(
                children: <Widget>[
                  Container(
                    height: 70,
                    padding: EdgeInsets.symmetric(horizontal: 16),
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
                    height: 610,
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
                ],
              ),
            ),
    );
  }
}
