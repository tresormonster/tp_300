import '../state/admin_sidebar_state.dart';

class AdminSidebarController {

  AdminSidebarState state =
      AdminSidebarState(

    showMenu: false,
  );

  void toggleMenu() {

    state = AdminSidebarState(

      showMenu:
          !state.showMenu,
    );
  }
}