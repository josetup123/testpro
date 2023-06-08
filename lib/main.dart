// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:testpro/posts_view.dart';
// import 'package:testpro/posts_cubit.dart';

// void main() {
//   runApp(const MyApp());
// }

// class MyApp extends StatefulWidget {
//   const MyApp({super.key});

//   @override
//   State<MyApp> createState() => _MyAppState();
// }

// class _MyAppState extends State<MyApp> {
//   // This widget is the root of your application.
//   @override
//   Widget build(BuildContext context) {
//     // return MaterialApp(home: PostsView());//COMMONLY return MaterialApp(home: PostsView());
//     return MaterialApp(
//         home: BlocProvider<PostsBloc>(
//             create: (context) => PostsBloc()
//               ..add(
//                   LoadPostsEvent()), //CASCADE AN INTANCE BUT ON THAT SAME INSTANCE WE GET THE GETPOST mETHOD!!
//             child:
//                 const PostsView())); //MULTIPLE BLOCKS BUT FOR THIS I WILL BE WORKING SPECIFICTLY WITH THE POSTCUBIT STATE //PostsCubit
//   }
// }

// //HOME WIL BE PROVIDER AND THANKS TO THIS WE WILL BE ABLE TO ACCESS THE STATE TRHOUGH OUT THE APP! HIGH UP IN THE WIDGEt trEE t
// // IN ORDER TO ACESS IT!

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:testpro/posts_cubit.dart';
import 'package:testpro/posts_view.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: BlocProvider<PostsBloc>(
            create: (context) => PostsBloc()..add(LoadPostsEvent()),
            child: PostsView()));
  }
}
