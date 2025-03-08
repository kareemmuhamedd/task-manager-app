import '../../domain/entities/todo_details_entity.dart';
import '../../domain/entities/todo_entity.dart';
import '../models/todo_details_model.dart';
import '../models/todo_model.dart';

class TodoMapper {
  // For TodoDetails conversions
  static TodoDetailsEntity detailsModelToEntity(TodoDetailsModel model) {
    return TodoDetailsEntity(
      id: model.id,
      todo: model.todo,
      completed: model.completed,
      userId: model.userId,
    );
  }

  static TodoDetailsModel detailsEntityToModel(TodoDetailsEntity entity) {
    return TodoDetailsModel(
      id: entity.id,
      todo: entity.todo,
      completed: entity.completed,
      userId: entity.userId,
    );
  }

  // For Todo list conversions
  static TodoEntity collectionModelToEntity(TodoModel model) {
    return TodoEntity(
      todos: model.todos?.map((m) => detailsModelToEntity(m)).toList(),
      total: model.total,
      skip: model.skip,
      limit: model.limit,
    );
  }

  static TodoModel collectionEntityToModel(TodoEntity entity) {
    return TodoModel(
      todos: entity.todos?.map((e) => detailsEntityToModel(e)).toList(),
      total: entity.total,
      skip: entity.skip,
      limit: entity.limit,
    );
  }
}

// For single Todo item conversions
extension TodoDetailsModelX on TodoDetailsModel {
  TodoDetailsEntity toEntity() => TodoMapper.detailsModelToEntity(this);
}

extension TodoDetailsEntityX on TodoDetailsEntity {
  TodoDetailsModel toModel() => TodoMapper.detailsEntityToModel(this);
}

// For Todo collection conversions
extension TodoModelX on TodoModel {
  TodoEntity toEntity() => TodoMapper.collectionModelToEntity(this);
}

extension TodoEntityX on TodoEntity {
  TodoModel toModel() => TodoMapper.collectionEntityToModel(this);
}
