import '../state/sidebar_state.dart';

class SidebarController {

  SidebarState state =
      SidebarState(
        showMenu: false,
      );

  void toggleMenu() {

    state = SidebarState(
      showMenu:
          !state.showMenu,
    );
  }
}