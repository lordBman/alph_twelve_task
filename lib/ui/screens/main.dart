import 'package:alpha_twelve_task/ui/pages/cart.dart';
import 'package:alpha_twelve_task/ui/pages/favourites.dart';
import 'package:alpha_twelve_task/ui/pages/home.dart';
import 'package:alpha_twelve_task/ui/pages/profile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

BottomNavigationBarItem __bottomNavItem({ required String  label, required String icon, required Color activeColor }){
    DecoratedBox active = DecoratedBox(
        decoration: BoxDecoration( color: activeColor, borderRadius: BorderRadius.circular(16) ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
          child: SvgPicture.asset("assets/images/$icon", width: 24, height: 24, colorFilter: ColorFilter.mode(Colors.white, BlendMode.srcIn),),
        ),
    );

    DecoratedBox inactive = DecoratedBox(
        decoration: BoxDecoration( color: Colors.transparent, borderRadius: BorderRadius.circular(16) ),
        child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
            child: SvgPicture.asset("assets/images/$icon", width: 24, height: 24, colorFilter: ColorFilter.mode(Colors.black54, BlendMode.srcIn),),
        ),
    );

    return BottomNavigationBarItem(label: label, activeIcon: active, icon: inactive);
}

class Main extends StatefulWidget{
    const Main({ super.key });

    @override
    State<Main> createState() => __MainState();
}

class __MainState extends State<Main>{
    int currentIndex = 0;
    final PageController controller = PageController(initialPage: 0);

    void nextPage(int page){
        setState(() {
            currentIndex = page;
            controller.jumpToPage(currentIndex);
        });
    }

    void pageChange(int page){
        setState(() {
            currentIndex = page;
        });
    }

    @override
    Widget build(BuildContext context) {
      ColorScheme theme = Theme.of(context).colorScheme;

      return Scaffold(
          body: PageView(controller: controller, onPageChanged: pageChange, children: const [
              Home(), Cart(), Favourites(), Profile()
          ]),
          bottomNavigationBar: BottomNavigationBar(
              type: BottomNavigationBarType.fixed,
              selectedFontSize: 14, unselectedFontSize: 14, enableFeedback: false,
              selectedItemColor: theme.primary, unselectedItemColor: theme.onSurface, showUnselectedLabels: true,
              currentIndex: currentIndex, onTap: nextPage, items: [
              __bottomNavItem(label: "Home", icon: "hugeicons_home-07.svg", activeColor: theme.primary),
              __bottomNavItem(label: "Cart", icon: "hugeicons_shopping-cart-01.svg", activeColor: theme.primary),
              __bottomNavItem(label: "Favourite", icon: "hugeicons_favourite.svg", activeColor: theme.primary),
              __bottomNavItem(label: "Profile", icon: "hugeicons_user-circle.svg", activeColor: theme.primary)
          ]),
      );
    }
}