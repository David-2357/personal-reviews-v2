// ignore_for_file: recursive_getters

import 'package:drift/drift.dart';
import 'package:personal_reviews/database/tables/items_table.dart';

@TableIndex(name: 'reviews_index', columns: {#itemId, #isDeleted})
class Reviews extends Table {
  IntColumn get id => integer().autoIncrement()();
  Column<double> get rating => real()
      .withDefault(const Constant(0.0))
      .check(
        rating.isBiggerOrEqual(const Constant(0.0)) &
            rating.isSmallerOrEqual(const Constant(5.0)),
      )();
  TextColumn get comment => text()();

  BoolColumn get isDeleted => boolean().withDefault(const Constant(false))();
  DateTimeColumn get deletedAt => dateTime().nullable()();

  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();
  DateTimeColumn get updatedAt => dateTime().nullable()();

  IntColumn get itemId =>
      integer().references(Items, #id, onDelete: KeyAction.setNull)();
}
