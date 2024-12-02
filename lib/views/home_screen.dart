import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:weather_app/view_models/home_screen_view_model.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<HomeViewModel>.reactive(
      viewModelBuilder: () => HomeViewModel(),
      onViewModelReady: (viewModel) {
       // viewModel.loadCachedWeather();
      },
      builder: (context, viewModel, child) {
        return Scaffold(
          appBar: AppBar(
            title: const Center(child: Text('Weather App')),
            actions: [
              IconButton(
                icon: const Icon(Icons.info),
                onPressed: () => viewModel.navigateToAbout(context),
              ),
            ],
          ),
          body: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              children: [
                TextField(
                  controller: viewModel.cityController,
                  decoration: InputDecoration(
                    labelText: 'Enter city name',
                    border: const OutlineInputBorder(),
                    suffixIcon: IconButton(
                      icon: const Icon(Icons.clear),
                      onPressed: viewModel.clearInput,
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                ElevatedButton(
                  onPressed: viewModel.getWeather,
                  child: viewModel.isBusy
                      ? const CircularProgressIndicator()
                      : const Text('Get Weather'),
                ),
                const SizedBox(height: 16),
                if (viewModel.weather != null) ...[
                  Text(
                    'City: ${viewModel.weather!.cityName}',
                    style: const TextStyle(fontSize: 20),
                  ),
                  Text(
                    'Temperature: ${viewModel.weather!.temperature}°C',
                    style: const TextStyle(fontSize: 20),
                  ),
                  Text(
                    'Condition: ${viewModel.weather!.condition}',
                    style: const TextStyle(fontSize: 20),
                  ),
                ] else if (viewModel.errorMessage != null) ...[
                  Text(
                    viewModel.errorMessage!,
                    style: const TextStyle(color: Colors.red),
                  ),
                ],
                const SizedBox(height: 16),
                ElevatedButton(
                  onPressed: viewModel.clearHistory,
                  child: const Text('Clear History'),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}


