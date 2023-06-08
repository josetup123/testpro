import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:testpro/data_service.dart';
import 'post.dart';

// class PostsCubit extends Cubit<List<Post>> {
//   //CREATING AN INSTANCE OF A CUBIT!
//   final _dataService = DataService();

//   PostsCubit() : super([]);
//   //WHENEVER WE DO thIS GET POSTS WE WILL DO THIS ASYNCRONOUS EMIT:

//   void getPosts() async => emit(await _dataService.getPosts());
// }

// // https://www.youtube.com/watch?v=YhRZzq1yNKc&list=PL5h37q2DJtAP36eI9j9yKxbZBASUMb9eZ&index=16 19.23
// //HOW TO REFRESH THE DATA !!! getPosts again!

// //emit to emplty list how to clear the post!
// //GO TO HIGH ARE AN ADD THE BLOC PROVIDER THERE!

// //TRANFERING TO BLOC
// //EVERY STATE HAS EVENT
// abstract class PostsEvent {}

// class LoadPostsEvent extends PostsEvent {}

// //AND YTIELD STATES
// abstract class PostsState {}

// class LoadingPostsState extends PostsState {}

// class LoadedPostsState extends PostsState {
//   //IF IT LOADS THEN WE HAVE OUR POST
//   List<Post> posts;
//   LoadedPostsState({required this.posts});
// }

// class FailedToLoadPostsState extends PostsState {
//   Error error;
//   FailedToLoadPostsState({required this.error});
// }
// //IF I FAILED TO LOAD THE POST I SHOULD HAVE SOME TYPE OF FEEDBACK!

// //MAIN THING
// class PostsBloc extends Bloc<PostsEvent, PostsState> {
//   final _dataService = DataService();
//   PostsBloc() : super(LoadingPostsState());

//   //HERE WE START WITH THE LOADING STATE!

//   @override
//   Stream<PostsState> mapEventToState(PostsEvent event) async* {
//     //Take a event and then something will happen!
//     //we write the functionality for that!
//     // throw UnimplementedError();
//     if (event is LoadPostsEvent) {
//       yield LoadingPostsState();
//       try {
//         final posts = await _dataService.getPosts();
//         //IF WE GET IT OK! THEN
//         yield LoadedPostsState(posts: posts);
//       } on Error catch (e) {
//         yield FailedToLoadPostsState(error: e);
//       }
//     }
//   }
// }

// //NOTE:
// //POSTS IS JUST A CLASS LIKE VACCINES, INFORMATION, PROFILES
// import 'package:glutter_/flutter_bloc.dart';
// import 'package:testpro/data_service.dart';
// import 'post.dart';

class PostsCubit extends Cubit<List<Post>> {
  PostsCubit() : super([]);

  final _dataService = DataService();

  void getPosts() async => emit(await _dataService.getPosts());
}

abstract class PostsEvent {}

class LoadPostsEvent extends PostsEvent {}

class PullToRefreshEvent extends PostsEvent {}

abstract class PostsState {}

class LoadingPostsState extends PostsState {}

class LoadedPostsState extends PostsState {
  LoadedPostsState({required this.posts});

  List<Post> posts;
}

class FailedToLoadPostsState extends PostsState {
  FailedToLoadPostsState({required this.error});

  Error error;
}

class PostsBloc extends Bloc<PostsEvent, PostsState> {
  PostsBloc() : super(LoadedPostsState(posts: [])) {
    on((event, emit) async {
      try {
        final data = await _dataService.getPosts();
        if (event is PullToRefreshEvent || event is LoadPostsEvent) {
          emit(LoadedPostsState(posts: data));
        }
      } on Error catch (e) {
        emit(FailedToLoadPostsState(error: e));
      }
    });
  }

  final _dataService = DataService();
}
