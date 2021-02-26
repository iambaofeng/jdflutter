import 'dart:convert';

import 'Storage.dart';

class SearchServices {
  static setSearchData(value) async {
    try {
      //判断里面有没有数据
      List searchListData = json.decode(await Storage.getString('searchList'));
      print(searchListData);
      bool hasData = searchListData.any((v) {
        return v == value;
      });
      if (!hasData) {
        searchListData.add(value);
        await Storage.setString('searchList', json.encode(searchListData));
      }
    } catch (e) {
      print('没有数据');
      List tempList = [];
      tempList.add(value);
      Storage.setString('searchList', json.encode(tempList));
    }
  }

  static getSearchData(value) async {
    try {
      List searchListData = json.decode(await Storage.getString('searchList'));
      return searchListData;
    } catch (e) {
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
