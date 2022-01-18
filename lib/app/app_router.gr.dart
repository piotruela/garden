// **************************************************************************
// AutoRouteGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouteGenerator
// **************************************************************************
//
// ignore_for_file: type=lint

part of 'app_router.dart';

class _$AppRouter extends RootStackRouter {
  _$AppRouter([GlobalKey<NavigatorState>? navigatorKey]) : super(navigatorKey);

  @override
  final Map<String, PageFactory> pagesMap = {
    PlantListRoute.name: (routeData) {
      return MaterialPageX<dynamic>(
          routeData: routeData, child: const PlantListPage());
    }
  };

  @override
  List<RouteConfig> get routes => [RouteConfig(PlantListRoute.name, path: '/')];
}

/// generated route for
/// [PlantListPage]
class PlantListRoute extends PageRouteInfo<void> {
  const PlantListRoute() : super(PlantListRoute.name, path: '/');

  static const String name = 'PlantListRoute';
}
