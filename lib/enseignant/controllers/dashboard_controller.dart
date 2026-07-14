import '../state/dashboard_state.dart';

class DashboardController {

  DashboardState state =
      DashboardState(

    currentPage: "home",
  );

  void changePage(
    String page,
  ) {

    state = DashboardState(
      currentPage: page,
    );
  }
}