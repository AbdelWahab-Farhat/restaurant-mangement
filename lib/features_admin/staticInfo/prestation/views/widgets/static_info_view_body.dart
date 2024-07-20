import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/widgets/custom_error_widget.dart';
import '../../../../../core/widgets/custom_loading_widget.dart';
import '../../viewModel/static_info_cubit.dart';
import 'info_box.dart';

class StaticInfoViewBody extends StatefulWidget {
  const StaticInfoViewBody({super.key});

  @override
  State<StaticInfoViewBody> createState() => _StaticInfoViewBodyState();
}

class _StaticInfoViewBodyState extends State<StaticInfoViewBody> {
  @override
  void initState() {
    context.read<StaticInfoCubit>().fetchOrders();
    context.read<StaticInfoCubit>().fetchEmployees();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final StaticInfoCubit cubit = context.read<StaticInfoCubit>();
    return Scaffold(
      appBar: AppBar(
        title: const Text('Static Information'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: BlocBuilder<StaticInfoCubit, StaticInfoState>(
          builder: (context, state) {
            if (state is StaticInfoFailure){
              return CustomErrorWidget(errMessage: state.errorMessage);
            }
            if (state is StaticInfoSuccess) {
              return GridView.count(
              crossAxisCount: 2,
              crossAxisSpacing: 16.0,
              mainAxisSpacing: 16.0,
              children:   [
                InfoBox(
                  title: 'Number of Employees',
                  subtitle: 'Total number of employees',
                  value: cubit.employees.length.toString(), // Total number of employees
                ),
                InfoBox(
                  title: 'Bills',
                  subtitle: 'Current expenses',
                  value: '${cubit.bills(cubit.employees)} LY', // Current expenses
                ),
                InfoBox(
                  title: 'Daily Orders',
                  subtitle: 'Number of orders today',
                  value: cubit.numberOfDailyOrders(cubit.orders).toString(), // Number of daily orders
                ),
                InfoBox(
                  title: 'Total Income',
                  subtitle: 'Total income',
                  value: '${cubit.totalIncome(cubit.orders).toStringAsFixed(2)} LY', // Total income
                ),
              ],
            );
            }
            else {
              return const CustomLoadingWidget();
            }
          },
        ),
      ),
    );
  }
}

