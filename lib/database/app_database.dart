import 'dart:io';

import 'package:drift/native.dart';
import 'package:drift/drift.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as path;
import 'package:personal_reviews/core/constants/category_icons.dart';
import 'package:personal_reviews/data/repositories/folder_repository.dart';

import 'package:personal_reviews/database/daos/categories_dao.dart';
import 'package:personal_reviews/database/daos/folder_trees_dao.dart';
import 'package:personal_reviews/database/daos/folders_dao.dart';
import 'package:personal_reviews/database/daos/items_dao.dart';
import 'package:personal_reviews/database/daos/review_images_dao.dart';
import 'package:personal_reviews/database/daos/reviews_dao.dart';

import 'package:personal_reviews/database/tables/categories_table.dart';
import 'package:personal_reviews/database/tables/folder_trees_table.dart';
import 'package:personal_reviews/database/tables/folders_table.dart';
import 'package:personal_reviews/database/tables/items_table.dart';
import 'package:personal_reviews/database/tables/reviews_table.dart';
import 'package:personal_reviews/database/tables/review_images_table.dart';

part 'app_database.g.dart';

/// Principal database class for the app, using Drift as ORM and SQLite as storage.
///
/// Recommended architecture:
/// - Drift as ORM/query builder
/// - Native SQLite
/// - Migrations managed by Drift
/// - DAOs for data access
/// - Domain models separate from Drift rows
///
/// NOT USE:
/// - rawQuery()
/// - SQL strings in the app (use DAOs and Drift's query builder instead)
/// - global static singleton
///
/// Recommended architecture:
/// - Inyect this class with Riverpod/GetIt
/// - Keep SQL logic inside DAOs
@DriftDatabase(
  tables: [Categories, Folders, FolderTrees, Items, Reviews, ReviewImages],
  daos: [
    CategoriesDao,
    ReviewImagesDao,
    ItemsDao,
    FoldersDao,
    FolderTreesDao,
    ReviewsDao,
  ],
)
class AppDatabase extends _$AppDatabase {
  AppDatabase() : super(_openConnection());
  static final isInDebugMode = false;

  /// Incrementar cada vez que cambie el schema.
  @override
  int get schemaVersion => 1;

  /// Lazy aperture
  ///
  /// Advantages:
  /// - Not blocking app startup
  /// - Clean async initialization
  /// - Allows SQLite setup before opening
  static LazyDatabase _openConnection() {
    return LazyDatabase(() async {
      final documentsDirectory = await getApplicationDocumentsDirectory();

      final file = File(
        path.join(documentsDirectory.path, 'personal_reviews.db'),
      );

      return NativeDatabase.createInBackground(
        file,
        setup: (database) {
          // Obligatory foreign keys ON.
          database.execute('PRAGMA foreign_keys = ON;');

          // WAL improves concurrency and performance, especially for mobile apps.
          database.execute('PRAGMA journal_mode = WAL;');

          // Recommended for mobile apps: balance between durability and performance.
          database.execute('PRAGMA synchronous = NORMAL;');

          // SQLitle cache
          database.execute('PRAGMA cache_size = -20000;');

          // Memory temp store for faster temp tables and indices.
          database.execute('PRAGMA temp_store = MEMORY;');
        },
      );
    });
  }

  @override
  MigrationStrategy get migration {
    return MigrationStrategy(
      onCreate: (Migrator m) async {
        await m.createAll();
        await _seedInitialData();
      },

      onUpgrade: (Migrator m, int from, int to) async {
        // Here you can define migrations between versions. For example:
        // if (from < 2) {
        //   await m.addColumn(items, items.newColumn);
        // }
      },

      beforeOpen: (openingDetails) async {
        if (isInDebugMode) {
          await deleteDatabase();
        }
      },
    );
  }

  Future<void> _seedInitialData() async {
    // Check if used icons still exists
    final validIcons = presetCategories.keys.toSet();
    final usedIcons = {"book", "restaurant", "movie", "gamepad"};
    final missingIcons = usedIcons.difference(validIcons);
    if (missingIcons.isNotEmpty) {
      throw Exception(
        'Error: Missing preset icons: ${missingIcons.join(", ")}. Please update the presetCategories map.',
      );
    }

    await batch((batch) {
      batch.insertAll(categories, [
        CategoriesCompanion.insert(
          name: 'Libros',
          color: 'preset:green',
          icon: 'book',
        ),

        CategoriesCompanion.insert(
          name: 'Comida',
          color: 'preset:orange',
          icon: 'restaurant',
        ),

        CategoriesCompanion.insert(
          name: 'Peliculas',
          color: 'preset:blue',
          icon: 'movie',
        ),

        CategoriesCompanion.insert(
          name: 'Videojuegos',
          color: 'preset:purple',
          icon: 'gamepad',
        ),
      ]);
    });

    // TODO: Quitar datos de prueba
    await FolderRepository(foldersDao, folderTreesDao).create(name: 'Novelas');

    await FolderRepository(
      foldersDao,
      folderTreesDao,
    ).create(name: 'Fantasía', parentId: 1);

    await FolderRepository(
      foldersDao,
      folderTreesDao,
    ).create(name: 'Brandon Sanderson', parentId: 2);

    await FolderRepository(
      foldersDao,
      folderTreesDao,
    ).create(name: 'Tolkien', parentId: 2);

    await FolderRepository(
      foldersDao,
      folderTreesDao,
    ).create(name: 'Ciencia Ficción', parentId: 1);

    await FolderRepository(
      foldersDao,
      folderTreesDao,
    ).create(name: 'Desarrollo Personal');

    await FolderRepository(foldersDao, folderTreesDao).create(name: 'Recetas');

    await FolderRepository(
      foldersDao,
      folderTreesDao,
    ).create(name: 'Italianas', parentId: 7);

    await FolderRepository(foldersDao, folderTreesDao).create(
      name: 'Asiáticas',
      parentId: 7,
      imagePath: 'folders/asiatic_food.jpg',
    );

    await FolderRepository(
      foldersDao,
      folderTreesDao,
    ).create(name: 'Restaurantes');

    await batch((batch) {
      batch.insertAll(items, [
        // Novelas (id 1)
        ItemsCompanion.insert(
          name: 'El nombre del viento',
          categoryId: 1,
          folderId: const Value(1),
        ),

        // Fantasía (id 2)
        ItemsCompanion.insert(
          name: 'Mistborn',
          categoryId: 1,
          folderId: const Value(2),
        ),

        ItemsCompanion.insert(
          name: 'El Archivo de las Tormentas',
          categoryId: 1,
          folderId: const Value(2),
        ),

        // Brandon Sanderson (id 3)
        ItemsCompanion.insert(
          name: 'El Imperio Final',
          categoryId: 1,
          folderId: const Value(3),
        ),

        ItemsCompanion.insert(
          name: 'Palabras Radiantes',
          categoryId: 1,
          folderId: const Value(3),
        ),

        // Tolkien (id 4)
        ItemsCompanion.insert(
          name: 'El Hobbit',
          categoryId: 1,
          folderId: const Value(4),
        ),

        ItemsCompanion.insert(
          name: 'El Señor de los Anillos',
          categoryId: 1,
          folderId: const Value(4),
        ),

        ItemsCompanion.insert(
          name: 'El Señor de los Anillos',
          categoryId: 2,
          folderId: const Value(4),
        ),

        // Ciencia Ficción (id 5)
        ItemsCompanion.insert(name: 'Dune', categoryId: 1),

        // Desarrollo Personal (id 6)
        ItemsCompanion.insert(name: 'Hábitos Atómicos', categoryId: 1),

        // Recetas (id 7)
        ItemsCompanion.insert(name: 'Pizza Casera', categoryId: 2),

        // Italianas (id 8)
        ItemsCompanion.insert(name: 'Lasagna', categoryId: 2),

        ItemsCompanion.insert(name: 'Risotto', categoryId: 2),

        // Asiáticas (id 9)
        ItemsCompanion.insert(name: 'Ramen', categoryId: 2),

        ItemsCompanion.insert(name: 'Sushi', categoryId: 2),

        // Restaurantes (id 10)
        ItemsCompanion.insert(name: 'Restaurante Japonés', categoryId: 2),
      ]);

      // Añadir reviews de ejemplo
      batch.insertAll(reviews, [
        ReviewsCompanion.insert(
          itemId: 6,
          rating: Value(2.5),
          comment:
              'Una novela increíble, con un mundo fascinante y personajes memorables.',
        ),

        ReviewsCompanion.insert(
          itemId: 6,
          rating: Value(1),
          comment: 'Una novela malisima.',
        ),

        ReviewsCompanion.insert(
          itemId: 8,
          rating: Value(4),
          comment:
              'Me encantó, aunque algunos personajes podrían haberse desarrollado más.',
        ),

        ReviewsCompanion.insert(
          itemId: 7,
          rating: Value(5),
          comment:
              '¡La mejor pizza casera que he hecho! La receta es fácil de seguir y el resultado es delicioso.',
        ),

        ReviewsCompanion.insert(
          itemId: 9,
          rating: Value(1.5),
          comment:
              'El ramen quedó muy sabroso, aunque me hubiera gustado un poco más de picante.',
        ),

        ReviewsCompanion.insert(
          itemId: 10,
          rating: Value(0.5),
          comment:
              'El ambiente del restaurante es agradable, pero la comida no cumplió mis expectativas.',
        ),

        ReviewsCompanion.insert(
          itemId: 5,
          rating: Value(3),
          comment:
              'Dune es una obra maestra de la ciencia ficción, con un mundo complejo y una historia épica.',
        ),
      ]);
    });
  }

  /// REMOVE THIS IN PRODUCTION. Only for development to reset the database.
  Future<void> deleteDatabase() async {
    // Importante: cerrar conexiones antes de borrar
    await close();

    final dbFolder = await getApplicationDocumentsDirectory();

    final file = File(path.join(dbFolder.path, 'personal_reviews.db'));

    if (await file.exists()) {
      await file.delete();
    }
  }
}
