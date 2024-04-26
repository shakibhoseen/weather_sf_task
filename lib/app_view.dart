import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'utils/route/routes.dart';
import 'utils/route/routes_name.dart';


class MyAppView extends StatelessWidget {
  const MyAppView({super.key});

  @override
  Widget build(BuildContext context) {
    return
      MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          canvasColor: const Color(0xffe4e9ec),
          useMaterial3: true,
          fontFamily: GoogleFonts.inter().fontFamily,
        ),
        initialRoute: RoutesName.homeScreen,
        onGenerateRoute: Routes.generateRoute,
      );

  }
}