part of 'filter_search_bloc.dart';

abstract class FilterSearchState {
  final List<int> listLevel;
  final List<int>? listFilterLevel;
  final List<Site> listSite;
  final List<Site>? listFilterSite;
  final List<Site>? listSiteFilterWithLevel;
  FilterSearchState({
    required this.listLevel,
    this.listFilterLevel,
    required this.listSite,
    this.listFilterSite,
    required this.listSiteFilterWithLevel,
  });
}

class FilterSearchInitial extends FilterSearchState {
  FilterSearchInitial({
    required super.listLevel,
    required super.listSite,
    // super.listFilterLevel,
    // super.listFilterSite,
    required super.listSiteFilterWithLevel,
  });
}

class FilterSearchSuccess extends FilterSearchState {
  FilterSearchSuccess({
    required super.listLevel,
    required super.listSite,
    super.listFilterLevel,
    super.listFilterSite,
    super.listSiteFilterWithLevel,
  });
}

class FilterSuccess extends FilterSearchState {
  FilterSuccess({
    required super.listLevel,
    required super.listSite,
    super.listFilterLevel,
    super.listFilterSite,
    super.listSiteFilterWithLevel,
  });
}

class FilterSearchError extends FilterSearchState {
  final String errorMessage;
  FilterSearchError({
    required super.listLevel,
    required super.listSite,
    // super.listFilterLevel,
    // super.listFilterSite,
    super.listSiteFilterWithLevel,
    required this.errorMessage,
  });
}
