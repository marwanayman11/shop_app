import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shop_app/modules/search/search.dart';
import 'package:shop_app/modules/shop_login/shop_login.dart';
import 'package:shop_app/shared/components/components.dart';
import 'package:shop_app/shared/network/local/cache_helper.dart';
import 'cubit/cubit.dart';
import 'cubit/states.dart';

class ShopLayout extends StatelessWidget {
  const ShopLayout({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit, ShopStates>(
        listener: (context, state) {},
        builder: (context, state) {
          var cubit = ShopCubit.get(context);
          return Scaffold(
            appBar: AppBar(
              actions: [
                IconButton(
                    onPressed: () {
                      pushTo(context, SearchScreen());
                    },
                    icon: const Icon(Icons.search)),
                IconButton(
                    onPressed: () {
                      CacheHelper.clearData(key: 'token').then((value) {
                        if (value) {
                          pushToAndFinish(context, ShopLogin());
                        }
                      });
                    },
                    icon: const Icon(
                      Icons.logout,
                      color: Colors.green,
                    )),
              ],
              title: Row(
                children: [
                  Text('M11 | Shop', style: GoogleFonts.aladin(fontSize: 30)),
                  const Icon(
                    Icons.shopping_cart_outlined,
                    size: 30,
                  )
                ],
              ),
            ),
            bottomNavigationBar: BottomNavigationBar(
              items: cubit.items,
              selectedLabelStyle: GoogleFonts.aladin(fontSize: 15),
              unselectedLabelStyle: GoogleFonts.aladin(fontSize: 15),
              currentIndex: cubit.currentIndex,
              onTap: (value) {
                cubit.changeBottomNavIndex(value);
              },
            ),
            body: cubit.screens[cubit.currentIndex],
          );
        });
  }
}
