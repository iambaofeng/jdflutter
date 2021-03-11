import 'package:flutter/material.dart';
import 'package:flutter_jdshop/common/utils/screen.dart';
import 'package:get/get.dart';

class AddressListPage extends StatelessWidget {
  AddressListPageController vm = Get.put(AddressListPageController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('收获地址列表'),
      ),
      body: Container(
          child: Stack(
        children: [
          ListView(
            children: [
              SizedBox(
                height: setHeight(40),
              ),
              ListTile(
                leading: Icon(
                  Icons.check,
                  color: Colors.red,
                ),
                title: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('张三 15809603472'),
                    SizedBox(
                      height: setHeight(10),
                    ),
                    Text('北京市海淀区西二旗')
                  ],
                ),
                trailing: Icon(
                  Icons.edit,
                  color: Colors.blue,
                ),
              ),
              Divider(
                height: setHeight(20),
              ),
              ListTile(
                leading: Icon(
                  Icons.check,
                  color: Colors.red,
                ),
                title: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('张三 15809603472'),
                    SizedBox(
                      height: setHeight(10),
                    ),
                    Text('北京市海淀区西二旗')
                  ],
                ),
                trailing: Icon(
                  Icons.edit,
                  color: Colors.blue,
                ),
              ),
              Divider(
                height: setHeight(20),
              ),
            ],
          ),
          Positioned(
              bottom: 0,
              width: setWidth(750),
              height: setHeight(88),
              child: Container(
                padding: EdgeInsets.all(setWidth(10)),
                height: setHeight(100),
                // color: Colors.red,
                decoration: BoxDecoration(
                    color: Colors.red,
                    border: Border(
                        top: BorderSide(width: 1, color: Colors.black26))),
                child: InkWell(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.add,
                        color: Colors.white,
                      ),
                      Text(
                        '增加收货地址',
                        style: TextStyle(color: Colors.white),
                      )
                    ],
                  ),
                  onTap: () {
                    Get.toNamed('/addressAdd');
                  },
                ),
              ))
        ],
      )),
    );
  }
}

class AddressListPageController extends GetxController {}