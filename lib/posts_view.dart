// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:testpro/posts_cubit.dart';

// import 'post.dart';

// class PostsView extends StatelessWidget {
//   const PostsView({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//         appBar: AppBar(title: const Text('dsa')),
//         body: BlocBuilder<PostsBloc, PostsState>(
//           builder: (context, state) {
//             //THE CUBIT WRAPS THE FUTURE BUILDER AND HANDLES AS WELL THE NULL AND POST CONTE
//             if (state is LoadingPostsState) {
//               return const Center(child: CircularProgressIndicator());
//             } else if (state is LoadedPostsState) {
//               return ListView.builder(itemBuilder: (context, index) {
//                 return Card(
//                     child: ListTile(title: Text(state.posts[index].title)));
//               });
//             } else if (state is FailedToLoadPostsState) {
//               return Center(
//                 child: Text('Error ocurred: ${state.error}'),
//               );
//             } else {
//               return Container();
//             }
//           },
//         ));
//   }
// }

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:testpro/posts_cubit.dart';

import 'post.dart';

class PostsView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Posts'),
      ),
      body: BlocBuilder<PostsBloc, PostsState>(
        builder: (context, state) {
          if (state is LoadingPostsState) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else if (state is LoadedPostsState) {
            return RefreshIndicator(
              onRefresh: () async =>
                  BlocProvider.of<PostsBloc>(context).add(PullToRefreshEvent()),
              child: ListView.builder(
                  itemCount: state.posts.length,
                  itemBuilder: (context, index) {
                    return Card(
                      child: ListTile(
                        title: Text(state.posts[index].title),
                      ),
                    );
                  }),
            );
          } else if (state is FailedToLoadPostsState) {
            return Center(
              child: Text('Error occured: ${state.error}'),
            );
          } else {
            return Container();
          }
        },
      ),
    );
  }
}
