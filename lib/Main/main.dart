import 'package:bootstrap_icons/bootstrap_icons.dart';
import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:project_fluttercse10/provider/animationProvider.dart';
import 'package:project_fluttercse10/provider/cardProvider.dart';
import 'package:project_fluttercse10/provider/deckProvider.dart';
import 'package:project_fluttercse10/provider/themeProvider.dart';
import 'package:project_fluttercse10/view/Create%20View/createViewRevision.dart';
import 'package:project_fluttercse10/view/Deck%20View/deckView.dart';
import 'package:provider/provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:zoom_tap_animation/zoom_tap_animation.dart';
import '../db_service/sqf.dart';
import '../provider/pageProvider.dart';
import '../view/Home View/homeView.dart';
import '../view/Profile View/profileView.dart';
import 'package:project_fluttercse10/getset.dart';


import 'package:sqflite_common_ffi_web/sqflite_ffi_web.dart';


ThemeData theme = FlexThemeData.light(
  scheme: FlexScheme.hippieBlue,
  textTheme: GoogleFonts.poppinsTextTheme(),
  surfaceMode: FlexSurfaceMode.highScaffoldLowSurface,
  blendLevel: 1,
  subThemesData: const FlexSubThemesData(
    interactionEffects: true,
    tintedDisabledControls: true,
    blendOnLevel: 8,
    useM2StyleDividerInM3: true,
    defaultRadius: 12.0,
    elevatedButtonSchemeColor: SchemeColor.onPrimaryContainer,
    elevatedButtonSecondarySchemeColor: SchemeColor.primaryContainer,
    outlinedButtonOutlineSchemeColor: SchemeColor.primary,
    toggleButtonsBorderSchemeColor: SchemeColor.primary,
    segmentedButtonSchemeColor: SchemeColor.primary,
    segmentedButtonBorderSchemeColor: SchemeColor.primary,
    unselectedToggleIsColored: true,
    sliderValueTinted: true,
    inputDecoratorSchemeColor: SchemeColor.primary,
    inputDecoratorIsFilled: true,
    inputDecoratorBackgroundAlpha: 31,
    inputDecoratorBorderType: FlexInputBorderType.outline,
    inputDecoratorUnfocusedHasBorder: false,
    inputDecoratorFocusedBorderWidth: 1.0,
    inputDecoratorPrefixIconSchemeColor: SchemeColor.primary,
    fabUseShape: true,
    fabAlwaysCircular: true,
    fabSchemeColor: SchemeColor.tertiary,
    popupMenuRadius: 8.0,
    popupMenuElevation: 3.0,
    alignedDropdown: true,
    drawerIndicatorRadius: 12.0,
    drawerIndicatorSchemeColor: SchemeColor.primary,
    bottomNavigationBarMutedUnselectedLabel: false,
    bottomNavigationBarMutedUnselectedIcon: false,
    menuRadius: 8.0,
    menuElevation: 3.0,
    menuBarRadius: 0.0,
    menuBarElevation: 2.0,
    menuBarShadowColor: Color(0x00000000),
    searchBarElevation: 1.0,
    searchViewElevation: 1.0,
    searchUseGlobalShape: true,
    navigationBarSelectedLabelSchemeColor: SchemeColor.primary,
    navigationBarSelectedIconSchemeColor: SchemeColor.onPrimary,
    navigationBarIndicatorSchemeColor: SchemeColor.primary,
    navigationBarIndicatorRadius: 12.0,
    navigationRailSelectedLabelSchemeColor: SchemeColor.primary,
    navigationRailSelectedIconSchemeColor: SchemeColor.onPrimary,
    navigationRailUseIndicator: true,
    navigationRailIndicatorSchemeColor: SchemeColor.primary,
    navigationRailIndicatorOpacity: 1.00,
    navigationRailIndicatorRadius: 12.0,
    navigationRailBackgroundSchemeColor: SchemeColor.surface,
    navigationRailLabelType: NavigationRailLabelType.all,
  ),
  keyColors: const FlexKeyColors(
    useSecondary: true,
    useTertiary: true,
    keepPrimary: true,
  ),
  tones: FlexSchemeVariant.jolly.tones(Brightness.light),
  visualDensity: FlexColorScheme.comfortablePlatformDensity,
  cupertinoOverrideTheme: const CupertinoThemeData(applyThemeToAll: true),
);

void main() async{

  WidgetsFlutterBinding.ensureInitialized();
  databaseFactory = databaseFactoryFfiWeb;
  await DbHelper.dbHelper.initDatabase();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});


  @override
  Widget build(BuildContext context) {
    getWid.wSize = MediaQuery.sizeOf(context).width;
    getHgt.hSize = MediaQuery.sizeOf(context).height;
    color.col = const Color.fromRGBO(26, 117, 159,1);
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => animation()),
        ChangeNotifierProvider(create: (context) => deckProvider()),
        ChangeNotifierProvider<CardClass>(create: (context) => CardClass()),
      ChangeNotifierProvider(create: (context) => PageProvider()),
        ChangeNotifierProvider(create: (context) => themesChoice()),
      ],
      child:  Consumer<themesChoice>(
    builder: (BuildContext context, provider, Widget? child) =>MaterialApp(
        theme: provider.themes,
        debugShowCheckedModeBanner: false,
        home: HomePage(),
      ),
    ));
  }
}
final GlobalKey<HomePageState> homePageKey = GlobalKey<HomePageState>();
class HomePage extends StatefulWidget {
  HomePage({Key? key}) : super(key: homePageKey);


  @override
  State<HomePage> createState() => HomePageState();
}

class HomePageState extends State<HomePage> {
  Color _fabColor = Colors.grey;
  final PageController _controller = PageController();
  int _currentIndex = 0;
  void onButtonPressed(int index) {
    _controller.animateToPage(index,duration: const Duration(milliseconds: 1) ,curve:Curves.ease);
    _currentIndex = index;
    setState(() {
      _fabColor =
          _currentIndex == 2 ? Theme.of(context).primaryColor : Colors.grey;
    });
  }

  @override
  Widget build(BuildContext context) {
    final pageProvider = Provider.of<PageProvider>(context, listen: false);

    return Scaffold(
      extendBody: true,
      bottomNavigationBar: const _bottomAppBar(
      ),
      body: PageView(
          controller: pageProvider.pageController,
        onPageChanged: (index) {
          pageProvider.setPage(index);
        },
          physics: const NeverScrollableScrollPhysics(),
          children: const [
            homeView(),
            profileView(),
            addFlashCardView(),
            deckView(),
          ],
        ),
    );
  }
}

class _bottomAppBar extends StatelessWidget {


  const _bottomAppBar({
    Key? key,
  });

  @override
  Widget build(BuildContext context) {
    return Consumer<PageProvider>(
        builder: (context, provider, child)=>Container(
        height: 90,
        decoration: const BoxDecoration(
      
          boxShadow: [
            BoxShadow(
              color: Colors.black26,
              blurRadius: 8.0,
              spreadRadius: 5.0,
              offset: Offset(0.0, 2.0), // changes position of shadow
            ),
          ],
        ),
        child: ClipRRect(
          borderRadius: const BorderRadius.only(
              topRight: Radius.circular(15), topLeft: Radius.circular(15)),
          child: BottomAppBar(
            color: Colors.white,
            elevation: 20,
            child: Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                ZoomTapAnimation(
                  child: Column(
                    children: [
                      IconButton(
                        onPressed: () => provider.jumpToPage(0), // Navigate to page 0
                        icon: const Icon(BootstrapIcons.house_door, size: 25),
                        color: provider.currentPage == 0
                            ? Theme.of(context).primaryColor
                            : Colors.grey,
                      ),
                      const Text('Home'),
                    ],
                  ),
      
                ),
      
                ZoomTapAnimation(
                  child: Column(
                    children: [
                      IconButton(
                        onPressed: () => {provider.jumpToPage(3)},
                        icon: const Icon(Icons.filter_none, size: 25),
                        color: provider.currentPage == 3
                            ? Theme.of(context).primaryColor
                            : Colors.grey,
                      ),
                      const Text('Decks'),
                    ],
                  ),
      
                ),
                ZoomTapAnimation(
                  child: Column(
                    children: [
                      IconButton(
                        onPressed: () => provider.jumpToPage(2), // Navigate to page 0
                        icon: const Icon(Icons.add, size: 25),
                        color: provider.currentPage == 2
                            ? Theme.of(context).primaryColor
                            : Colors.grey,
                      ),
                      const Text('Add')
                    ],
                  ),
                ),
                ZoomTapAnimation(
                  child: Column(
                    children: [
                      IconButton(
                        onPressed: () => provider.jumpToPage(1), // Navigate to page 1
                        icon: const Icon(Icons.account_circle_outlined, size: 25),
                        color: provider.currentPage == 1
                            ? Theme.of(context).primaryColor
                            : Colors.grey,
                      ),
                      const Text('Profile')
                    ],
                  ),

                ),
      
                ZoomTapAnimation(
                  child: Column(
                    children: [
                      IconButton(
                        onPressed: (){}, // Navigate to page 1
                        icon: const Icon(Icons.settings, size: 25),
                        color: provider.currentPage == 4
                            ? Theme.of(context).primaryColor
                            : Colors.grey,
                      ),
                      const Text('Settings')
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

