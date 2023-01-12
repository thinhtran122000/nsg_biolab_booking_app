part of 'filter_search_bloc.dart';

abstract class FilterSearchEvent {}

class FetchDataFilterEvent extends FilterSearchEvent {
  final FilterModel? filterModel;
  FetchDataFilterEvent({
    required this.filterModel,
  });
}

class CheckLevelEvent extends FilterSearchEvent {
  final int index;
  CheckLevelEvent({
    required this.index,
  });
}

class CheckRoomEvent extends FilterSearchEvent {
  final int index;
  CheckRoomEvent({
    required this.index,
  });
}

class FilterEvent extends FilterSearchEvent {}

class UnFilterEvent extends FilterSearchEvent {}

class ResetLevelFilterEvent extends FilterSearchEvent {}

class ResetSiteRoomFilterEvent extends FilterSearchEvent {}
