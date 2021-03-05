import 'package:flutter/material.dart';
import 'package:flutter_jdshop/common/utils/screen.dart';
import 'package:flutter_jdshop/services/SearchServices.dart';
import 'package:flutter_jdshop/services/Storage.dart';
import 'package:get/get.dart';

class SearchPage extends StatelessWidget {
  SearchPageController vm = Get.put(SearchPageController());

  Widget hotWords(String item) {
    return InkWell(
      onTap: () {
        Get.offNamed('/productList', arguments: {'search': item});
      },
      child: Container(
        padding: EdgeInsets.all(10),
        margin: EdgeInsets.all(10),
        decoration: BoxDecoration(
            color: Color.fromRGBO(233, 233, 233, 0.9),
            borderRadius: BorderRadius.circular(10)),
        child: Text(item),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    _showAlertDialog(keywords) async {
      var result = await showDialog(
          barrierDismissible: false,
          context: context,
          builder: (context) {
            return AlertDialog(
              title: Text('提示信息！'),
              content: Text('您确定要删除该条历史记录吗？'),
              actions: [
                FlatButton(
                    onPressed: () {
                      print('取消');
                      Navigator.pop(context, 'Cancle');
                    },
                    child: Text('取消')),
                FlatButton(
                    onPressed: () {
                      print('确定');
                      vm._removeHistoryData(keywords);
                      Navigator.pop(context, 'ok');
                    },
                    child: Text('确定'))
              ],
            );
          });
    }

    Widget _historyListWidget() {
      if (vm._historyListData.length > 0) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              margin: EdgeInsets.only(top: setWidth(20)),
              child: Text(
                '历史记录',
                style: TextStyle(color: Colors.red, fontSize: setFontSize(40)),
              ),
            ),
            Divider(),
            Column(
                children: vm._historyListData.map((element) {
              return Column(
                children: [
                  ListTile(
                    title: Text(element),
                    onLongPress: () {
                      _showAlertDialog(element);
                    },
                    onTap: () {
                      Get.offNamed('/productList',
                          arguments: {'search': element});
                    },
                  ),
                  Divider()
                ],
              );
            }).toList()),
            SizedBox(
              height: setHeight(100),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                InkWell(
                  child: Container(
                    width: setWidth(400),
                    height: setHeight(64),
                    decoration: BoxDecoration(
                      border: Border.all(width: 1, color: Colors.black45),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [Icon(Icons.delete), Text('清空历史记录')],
                    ),
                  ),
                  onTap: () {
                    vm._clearHistoryData();
                  },
                )
              ],
            ),
          ],
        );
      } else {
        return Text('');
      }
    }

    return Scaffold(
      appBar: AppBar(
        title: Container(
          height: setHeight(68),
          decoration: BoxDecoration(
              color: Color.fromRGBO(233, 233, 233, 0.8),
              borderRadius: BorderRadius.circular(30)),
          child: TextField(
            autofocus: true,
            decoration: InputDecoration(
              border: OutlineInputBorder(
                  borderSide: BorderSide.none,
                  borderRadius: BorderRadius.circular(30)),
            ),
            onChanged: (value) {
              vm._keywords = value;
            },
          ),
        ),
        actions: [
          Container(
            height: setHeight(68),
            width: setWidth(80),
            child: Row(
              children: [
                InkWell(
                  child: Text('搜索'),
                  onTap: () {
                    SearchServices.setSearchData(vm._keywords);
                    Get.offNamed('/productList',
                        arguments: {'search': vm._keywords});
                  },
                ),
              ],
            ),
          )
        ],
      ),
      body: Container(
        child: Container(
          padding: EdgeInsets.all(setWidth(10)),
          child: ListView(
            children: [
              Container(
                child: Text(
                  '热搜',
                  style:
                      TextStyle(color: Colors.red, fontSize: setFontSize(40)),
                ),
              ),
              Divider(),
              Wrap(children: vm._hosKeyWords.map((e) => hotWords(e)).toList()),
              Obx(() => _historyListWidget())
            ],
          ),
        ),
      ),
    );
  }
}

class SearchPageController extends GetxController {
  String _keywords = '';
  final _historyListData = [].obs;
  List<String> _hosKeyWords = ['笔记本', '女装', '手机', "衣服"];
  @override
  void onInit() {
    // TODO: implement onInit
    _getHistoryData();
    super.onInit();
  }

  _getHistoryData() async {
    _historyListData.addAll(await SearchServices.getSearchData('searchList'));
  }

  _clearHistoryData() async {
    _historyListData.clear();
  }

  _removeHistoryData(value) async {
    await SearchServices.removeSearchData(value);
    _historyListData.clear();
    _getHistoryData();
  }
}
