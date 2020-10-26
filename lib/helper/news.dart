import 'dart:convert';

import 'package:flutternews/models/artical_model.dart';
import 'package:location/location.dart';
import 'package:geocoder/geocoder.dart';
import 'package:http/http.dart' as http;

class News {
  List<Article> news = [];

  Future<String> getLocation() async {
    String countryCode;
    LocationData myLocation;
    bool _serviceEnabled;
    PermissionStatus _permissionGranted;

    Location location = Location();

    _serviceEnabled = await location.serviceEnabled();
    if (!_serviceEnabled) {
      _serviceEnabled = await location.requestService();
      if (!_serviceEnabled) {
        return 'us';
      }
    }

    _permissionGranted = await location.hasPermission();
    if (_permissionGranted == PermissionStatus.denied) {
      _permissionGranted = await location.requestPermission();
      if (_permissionGranted != PermissionStatus.granted) {
        return 'us';
      }
      myLocation = await location.getLocation();

      
    }
    final coordinates = Coordinates(myLocation.latitude, myLocation.longitude);

    List<Address> addresses =
        await Geocoder.local.findAddressesFromCoordinates(coordinates);

    var first = addresses.first;

    countryCode = first.countryCode;

    print(countryCode);
    print(myLocation.latitude.toString() +
          ", " +
          myLocation.longitude.toString());
    return countryCode;
  }

  Future<void> getNews() async {
    //String countryCode;

    String url =
        "http://newsapi.org/v2/top-headlines?country=eg&category=business&apiKey=3994cb11a9044708948ed065b25c2764";

    var response = await http.get(url);

    var jsonData = jsonDecode(response.body);

    if (jsonData['status'] == "ok") {
      jsonData["articles"].forEach((element) {
        if (element['urlToImage'] != null && element['description'] != null) {
          Article article = Article(
            title: element['title'],
            author: element['author'],
            description: element['description'],
            urlToImage: element['urlToImage'],
            publshedAt: DateTime.parse(element['publishedAt']),
            content: element["content"],
            articleUrl: element["url"],
          );
          news.add(article);
        }
      });
    }
  }
}

class NewsForCategories {
  List<Article> news = [];

  Future<void> getNewsForCategory(String category) async {
    //String countryCode;
    
    /*String url = "http://newsapi.org/v2/everything?q=$category&apiKey=${apiKey}";*/
    String url =
        "http://newsapi.org/v2/top-headlines?country=eg&category=business&apiKey=3994cb11a9044708948ed065b25c2764";

    var response = await http.get(url);

    var jsonData = jsonDecode(response.body);

    if (jsonData['status'] == "ok") {
      jsonData["articles"].forEach((element) {
        if (element['urlToImage'] != null && element['description'] != null) {
          Article article = Article(
            title: element['title'],
            author: element['author'],
            description: element['description'],
            urlToImage: element['urlToImage'],
            publshedAt: DateTime.parse(element['publishedAt']),
            content: element["content"],
            articleUrl: element["url"],
          );
          news.add(article);
        }
      });
    }
  }
}
