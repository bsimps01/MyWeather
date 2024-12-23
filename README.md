# MyWeather

MyWeather is a Swift-based iOS appl that provides real-time weather information for selected cities. Users can search for cities, view detailed weather information, and save their preferred city. This project demonstrates the use of SwiftUI, asynchronous API integration, and clean architecture.

## FEATURES
- 🌎 **CITY SEARCH**: Search for cities and fetch weather details dynamically.
- ☀️ **WEATHER DETAILS**: Displays:
  - Current temperature
  - "Feels like" temperature
  - Humidity
  - UV index
  - Weather condition with icons
- 💾 **PERSISTENCE**: Saves the selected city and reloads its weather data upon app relaunch.
- 🧑‍💻 **CLEAN ARCHITECTURE**: Implements MVVM design pattern with a modular and testable codebase.

## HOW TO CREATE A WEATHERAPI.COM ACCOUNT AND GENERATE AN API KEY
1. Go to the **[WeatherAPI.com Signup Page](https://www.weatherapi.com/signup.aspx)**.
2. Fill in the registration form:
   - **EMAIL ADDRESS**: Enter your valid email address.
   - **PASSWORD**: Choose a strong password.
3. Verify your email if prompted.
4. Log in and find your **API KEY** in the dashboard.

When you get your API key, create a file or go to one of the already present files and create the variable apiKey. It should look something like this:

```swift
let apiKey = "YOUR_API_KEY_HERE"

