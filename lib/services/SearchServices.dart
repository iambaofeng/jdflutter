import 'dart:convert';

import 'Storage.dart';

class SearchServices {
  static setSearchData(value) async {
    var data = await Storage.getString('searchList');
    if (data != null) {
      //有数据
      List searchListData = json.decode(data);
      bool hasData = searchListData.any((v) {
        return v == value;
      });
      if (!hasData) {
        searchListData.add(value);
        await Storage.setString('searchList', json.encode(searchListData));
      }
    } else {
      //无数据
      List tempList = [];
      tempList.add(value);
      await Storage.setString('searchList', json.encode(tempList));
    }
  }

  static getSearchData(value) async {
    var data = await Storage.getString('searchList');
    if (data != "") {
      //有数据
      List searchListData = json.decode(data);
      return searchListData;
    } else {
      //无数据
      return [];
    }
  }

  static clearSearchData() async {
    await Storage.remove('searchList');
  }

  static removeSearchData(value) async {
    List searchListData = json.decode(await Storage.getString('searchList'));
    searchListData.remove(value);
    await Storage.setString('searchList', json.encode(searchListData));
  }
}
