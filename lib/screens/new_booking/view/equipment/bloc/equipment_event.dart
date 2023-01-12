part of 'equipment_bloc.dart';

abstract class EquipmentEvent {}

class FetchDataEquipmentEvent extends EquipmentEvent {
  final List<Site>? sites;
  final List<int>? levels;
  FetchDataEquipmentEvent({
    this.sites,
    this.levels,
  });
}

class SetDatFilter extends EquipmentEvent {
  final List<Site>? sites;
  final List<int>? levels;
  SetDatFilter({
    this.sites,
    this.levels,
  });
}

class LoadMoreEquipmentEvent extends EquipmentEvent {
  final List<Site>? sites;
  final List<int>? levels;
  LoadMoreEquipmentEvent({
    this.sites,
    this.levels,
  });
}

class ToggleLikeEquipmentEvent extends EquipmentEvent {
  final EquipmentItem equipmentItem;
  ToggleLikeEquipmentEvent({
    required this.equipmentItem,
  });
}

class ShowButtonScrollTopEvent extends EquipmentEvent {}

class ScrollTopEvent extends EquipmentEvent {}
