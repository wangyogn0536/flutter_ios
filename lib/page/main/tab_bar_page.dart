import 'package:agent_app_vpn/page/main/personal/personal_page.dart';
import 'package:agent_app_vpn/page/main/purchase_center/purchase_center_page.dart';

import '../../project_imports.dart';
import 'home/home_page.dart';

/// Created by 刘冰.
/// Date:2024/5/23
/// des:封装底层的TabBar
int _currentIndex = 0;

class TabBarPage extends StatefulWidget {
  const TabBarPage({super.key});

  @override
  State<TabBarPage> createState() => _TabBarPageState();
}

class _TabBarPageState extends State<TabBarPage> {
  PageController _pageController = PageController();

  static final GlobalKey<HomePageState> _globalKey = GlobalKey();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // CacheManager.getInstance()?.set('tabBarPageIndex', 2);
    if (CacheManager.getInstance()?.get('tabBarPageIndex') != null) {
      print('111111');
      _currentIndex = CacheManager.getInstance()!.get('tabBarPageIndex') as int;
      _pageController = PageController(initialPage: _currentIndex);
      CacheManager.clearKey('tabBarPageIndex');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MyColor.desTextColor,
      body: PageView(
        controller: _pageController,
        physics: const NeverScrollableScrollPhysics(),
        children: [
          HomePage(
            key: _globalKey,
          ),
          const PersonalPage(),
          const PurchaseCenterPage(),
        ],
      ),
      bottomNavigationBar: ClipRRect(
        child: BottomNavigationBar(
            currentIndex: _currentIndex,
            // 固定title
            type: BottomNavigationBarType.fixed,
            selectedItemColor: MyColor.themeColor,
            unselectedItemColor: MyColor.tabTextColor,
            selectedFontSize: 15.sp,
            unselectedFontSize: 15.sp,
            items: _item(),
            onTap: (index) {
              _onTap(index);
            },
            backgroundColor: Colors.white),
      ),
    );
  }

  List<BottomNavigationBarItem> _item() {
    return [
      _bottomItem(ConfigString.homePageText, 'images/home_page_icon.png',
          'images/select_home_page_icon.png'),
      _bottomItem(
        ConfigString.personalText,
        'images/purchase_icon.png',
        'images/select_purchase_icon.png',
      ),
      _bottomItem(ConfigString.purchaseCenterText, 'images/mine_icon.png',
          'images/select_mine_icon.png'),
    ];
  }

  _bottomItem(String title, String normalIcon, String selectorIcon) {
    return BottomNavigationBarItem(
      icon: Image.asset(
        normalIcon,
        width: 38.w,
        height: 40.h,
      ),
      activeIcon: Image.asset(
        selectorIcon,
        width: 38.w,
        height: 40.h,
      ),
      label: title,
    );
  }

  _onTap(int index) {
    if (_currentIndex != index) {
      // 直接跳转不带动画，自动 setState
      if (index == 0) {
        _globalKey.currentState?.viewModel.rectDetectionApiManager();
      } else {
        eventBus.fire(PointChange('$index'));
      }
      _pageController.jumpToPage(index);
    }
    setState(() {
      _currentIndex = index;
    });
  }
}
