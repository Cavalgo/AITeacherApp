import 'package:flutter/material.dart';

@immutable
abstract class NavEvent {
  const NavEvent();
}

class NavEventGoToHomePageView extends NavEvent {
  const NavEventGoToHomePageView();
}

class NavEventGoChatGPTView extends NavEvent {
  const NavEventGoChatGPTView();
}
