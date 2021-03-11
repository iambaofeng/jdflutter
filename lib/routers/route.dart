import 'package:flutter_jdshop/pages/Address/AddressList.dart';
import 'package:flutter_jdshop/pages/Address/AddressAdd.dart';
import 'package:flutter_jdshop/pages/Address/AddressEdit.dart';
import 'package:flutter_jdshop/pages/CheckOut.dart';
import 'package:flutter_jdshop/pages/Login.dart';
import 'package:flutter_jdshop/pages/ProductContent.dart';
import 'package:flutter_jdshop/pages/ProductList.dart';
import 'package:flutter_jdshop/pages/Register/RegisterFirst.dart';
import 'package:flutter_jdshop/pages/Register/RegisterSecond.dart';
import 'package:flutter_jdshop/pages/Register/RegisterThird.dart';
import 'package:flutter_jdshop/pages/Search.dart';
import 'package:flutter_jdshop/pages/Tab.dart';
import 'package:flutter_jdshop/pages/tabs/Cart.dart';
import 'package:flutter_jdshop/pages/tabs/Category.dart';
import 'package:flutter_jdshop/pages/tabs/Home.dart';
import 'package:flutter_jdshop/pages/tabs/People.dart';
import 'package:get/get.dart';

var routes = [
  GetPage(name: '/', page: () => Tabs()),
  GetPage(name: '/home', page: () => HomePage()),
  GetPage(name: '/cart', page: () => CartPage()),
  GetPage(name: '/people', page: () => PeoplePage()),
  GetPage(name: '/Category', page: () => CategoryPage()),
  GetPage(name: '/productList', page: () => ProductListPage()),
  GetPage(name: '/search', page: () => SearchPage()),
  GetPage(name: '/productContent', page: () => ProductContentPage()),
  GetPage(name: '/loginPage', page: () => LoginPage()),
  GetPage(name: '/registerFirst', page: () => RegisterFirstPage()),
  GetPage(name: '/registerSecond', page: () => RegisterSecondPage()),
  GetPage(name: '/registerThird', page: () => RegisterThirdPage()),
  GetPage(name: '/checkOut', page: () => CheckOutPage()),
  GetPage(name: '/addressList', page: () => AddressListPage()),
  GetPage(name: '/addressAdd', page: () => AddressAddPage()),
  GetPage(name: '/addressEdit', page: () => AddressEditPage()),
];
