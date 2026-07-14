class EtudiantSidebarState {

  bool showMenu;

  EtudiantSidebarState({
    required this.showMenu,
  });
}

class EtudiantSidebarController {

  EtudiantSidebarState state =
      EtudiantSidebarState(
    showMenu: false,
  );

  void toggleMenu() {

    state.showMenu =
        !state.showMenu;
  }
}