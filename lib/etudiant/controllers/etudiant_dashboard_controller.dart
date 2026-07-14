class EtudiantDashboardState {

  String currentPage;

  EtudiantDashboardState({
    required this.currentPage,
  });
}

class EtudiantDashboardController {

  EtudiantDashboardState state =
      EtudiantDashboardState(
    currentPage: "home",
  );

  void changePage(
    String page,
  ) {

    state.currentPage = page;
  }
}