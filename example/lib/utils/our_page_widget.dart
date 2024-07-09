import 'package:app/utils/our_cubit.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

/// A stateless widget that we extend our pages with, to
/// build them together with their cubit provider and making
/// it already available to read in the build method.
abstract class OurPageWidget<T extends OurCubit> extends StatelessWidget {
  const OurPageWidget({super.key});

  T buildCubit(BuildContext context);
  Widget buildWidget(BuildContext context);

  @override
  Widget build(BuildContext context) => BlocProvider<T>(
        create: buildCubit,
        child: HookBuilder(builder: buildWidget),
      );
}
