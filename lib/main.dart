import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:team_7_sfacpolio/provider/pagecontrol.dart';
import 'package:team_7_sfacpolio/screen/chatting.dart';
import 'package:team_7_sfacpolio/screen/onboarding.dart';
import 'package:team_7_sfacpolio/screen/search.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => Page_Controller()),
      ],
      child: MaterialApp(color: Color(0xFFFFFFFF), home: Search()),
    ),
  );
}
