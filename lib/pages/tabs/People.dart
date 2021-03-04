import 'package:flutter/material.dart';
import 'package:flutter_jdshop/common/utils/screen.dart';
import 'package:get/get.dart';

class PeoplePage extends StatelessWidget {
  PeoplePageController vm = Get.put(PeoplePageController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: [
          Container(
            height: setHeight(220),
            width: double.infinity,
            decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage('images/user_bg.jpg'),
                    fit: BoxFit.cover)),
            child: Row(
              children: [
                Container(
                  margin: EdgeInsets.fromLTRB(setWidth(10), 0, setWidth(10), 0),
                  child: ClipOval(
                    child: Image.asset(
                      'images/user.png',
                      fit: BoxFit.cover,
                      height: setHeight(100),
                      width: setWidth(100),
                    ),
                  ),
                ),
                // Expanded(
                //   child: Text(
                //     '登录/注册',
                //     style: TextStyle(color: Colors.white),
                //   ),
                //   flex: 1,
                // )

                Expanded(
                    flex: 1,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '用户名：Administrator',
                          style: TextStyle(
                              color: Colors.white, fontSize: setFontSize(32)),
                        ),
                        Text(
                          '普通会员',
                          style: TextStyle(
                              color: Colors.white, fontSize: setFontSize(20)),
                        ),
                      ],
                    ))
              ],
            ),
          ),
          ListTile(
            leading: Icon(
              Icons.assessment,
              color: Colors.red,
            ),
            title: Text('全部订单'),
          ),
          Divider(),
          ListTile(
            leading: Icon(
              Icons.payment,
              color: Colors.green,
            ),
            title: Text('代付款'),
          ),
          Divider(),
          ListTile(
            leading: Icon(
              Icons.local_car_wash,
              color: Colors.orange,
            ),
            title: Text('待收货'),
          ),
          Container(
            height: setHeight(20),
            color: Colors.black12,
          ),
          ListTile(
            leading: Icon(
              Icons.favorite,
              color: Colors.lightGreen,
            ),
            title: Text('我的收藏'),
          ),
          Divider(),
          ListTile(
            leading: Icon(
              Icons.people,
              color: Colors.black54,
            ),
            title: Text('在线客服'),
          ),
          Divider(),
        ],
      ),
    );
  }
}

class PeoplePageController extends GetxController {}
