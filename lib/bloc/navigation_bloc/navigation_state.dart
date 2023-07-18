import 'package:flutter/material.dart';

@immutable
abstract class NavState {
  const NavState();
}

class NavStateInHomePageView extends NavState {
  const NavStateInHomePageView();
}

class NavStateInChatGPTView extends NavState {
  const NavStateInChatGPTView();
}
