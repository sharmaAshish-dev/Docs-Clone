import 'package:flutter/material.dart';
import 'package:google_docs/screens/document_screen.dart';
import 'package:google_docs/screens/home_screen.dart';
import 'package:google_docs/screens/login_screen.dart';
import 'package:routemaster/routemaster.dart';

final loggedOutRoute = RouteMap(routes: {
  '/': (_) => const MaterialPage(child: LoginScreen()),
});

final loggedInRoute = RouteMap(routes: {
  '/': (_) => const MaterialPage(child: HomeScreen()),
  '/document/:id': (info) => MaterialPage(
        child: DocumentScreen(id: info.pathParameters['id'] ?? ''),
      ),
});
