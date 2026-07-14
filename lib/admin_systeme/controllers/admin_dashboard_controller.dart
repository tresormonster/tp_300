import '../state/admin_dashboard_state.dart';

class AdminDashboardController {

  AdminDashboardState state =
      AdminDashboardState(

    currentPage: "home",
  );

  void changePage(
    String page,
  ) {

    state = AdminDashboardState(

      currentPage: page,
    );
  }
}