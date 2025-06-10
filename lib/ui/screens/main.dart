import 'package:alpha_twelve_task/cubits/shopping_cubit.dart';
import 'package:alpha_twelve_task/cubits/states/shopping_state.dart';
import 'package:alpha_twelve_task/ui/components/searchbar.dart';
import 'package:alpha_twelve_task/ui/pages/cart.dart';
import 'package:alpha_twelve_task/ui/pages/favourites.dart';
import 'package:alpha_twelve_task/ui/pages/home.dart';
import 'package:alpha_twelve_task/ui/pages/profile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';

BottomNavigationBarItem __bottomNavItem({ required ColorScheme theme, required String  label, int num = 0, required String icon, required Color activeColor }){
    DecoratedBox active = DecoratedBox(
        decoration: BoxDecoration( color: activeColor, borderRadius: BorderRadius.circular(16) ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 4),
          child: SvgPicture.asset("assets/vectors/$icon", width: 24, height: 24, colorFilter: ColorFilter.mode(theme.onPrimary, BlendMode.srcIn),),
        ),
    );

    DecoratedBox inactive = DecoratedBox(
        decoration: BoxDecoration( color: Colors.transparent, borderRadius: BorderRadius.circular(16) ),
        child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 4),
            child: SvgPicture.asset("assets/vectors/$icon", width: 24, height: 24, colorFilter: ColorFilter.mode(theme.onSurface.withAlpha(176), BlendMode.srcIn),),
        ),
    );

    Widget finalIcon(Widget main){
        return Stack(children: <Widget>[
            main,
            if(num > 0)...[
                Positioned(top: 0.0, right: 0.0, child: Container(alignment: Alignment.center,
                    decoration: BoxDecoration(color: theme.onSurface, shape: BoxShape.circle),
                    constraints: BoxConstraints(minWidth: 24, minHeight: 24),
                    child: Text(num.toString(), style: TextStyle(color: theme.surface, fontSize: 12), textAlign: TextAlign.center),
                ))
            ]
        ]);
    }

    return BottomNavigationBarItem(label: label, activeIcon: finalIcon(active), icon: finalIcon(inactive));
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

        if(currentIndex == 1){
            context.read<ShoppingCubit>().clearSeen();
        }
    }

    void pageChange(int page){
        setState(() {
            currentIndex = page;
        });

        if(currentIndex == 1){
            context.read<ShoppingCubit>().clearSeen();
        }
    }

    @override
    Widget build(BuildContext context) {
      ColorScheme theme = Theme.of(context).colorScheme;

      return Scaffold(
          body: NestedScrollView(headerSliverBuilder: (context, value) =>[
                  SliverAppBar(elevation: 2, backgroundColor: theme.surfaceContainerLowest, centerTitle: true,
                      title: Column(children: [
                          Text("DELIVERY ADDRESS", style: TextStyle(fontSize: 10, fontWeight: FontWeight.w600)),
                          SizedBox(height: 4),
                          Text("Umuezike Road, Oyo State", style: TextStyle(fontSize: 12, fontWeight: FontWeight.w600))
                      ]),
                      actions: [
                          IconButton(onPressed: (){}, icon: SvgPicture.asset("assets/vectors/hugeicons_notification-02.svg"))
                      ],
                      collapsedHeight: currentIndex == 0 ? 120 : null,
                      flexibleSpace: currentIndex == 0 ? Padding(padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                          child: Column(mainAxisAlignment: MainAxisAlignment.end, children: [
                              Row(children: [
                                  Expanded(child: InputSearchBar())
                              ]),
                          ]),
                      ) : null,
                      pinned: true)
              ],
              body: PageView(controller: controller, onPageChanged: pageChange, children: const [
                  Home(), Cart(), Favourites(), Profile()
              ])
          ),
          bottomNavigationBar: BlocBuilder<ShoppingCubit, ShoppingState>(builder: (context, state){
              return BottomNavigationBar(
                  type: BottomNavigationBarType.fixed,
                  selectedFontSize: 14, unselectedFontSize: 14, enableFeedback: false,
                  selectedItemColor: theme.primary, unselectedItemColor: theme.onSurface, showUnselectedLabels: true,
                  currentIndex: currentIndex, onTap: nextPage, items: [
                  __bottomNavItem(theme: theme, label: "Home", icon: "hugeicons_home-07.svg", activeColor: theme.primary),
                  __bottomNavItem(theme: theme, label: "Cart", num: state.unseen, icon: "hugeicons_shopping-cart-01.svg", activeColor: theme.primary),
                  __bottomNavItem(theme: theme, label: "Favourite", icon: "hugeicons_favourite.svg", activeColor: theme.primary),
                  __bottomNavItem(theme: theme, label: "Profile", icon: "hugeicons_user-circle.svg", activeColor: theme.primary)
              ]);
          }),
      );
    }
}