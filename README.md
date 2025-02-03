# NooroWeather

### Setup

1. Create new configuration file from template.

<img width="349" alt="Screenshot 2025-02-03 at 1 36 15 AM" src="https://github.com/user-attachments/assets/27f81966-7dfe-41ca-8fb2-256ca5e24e2b" />

2. Choose "Configuration Settings File"

<img width="715" alt="Screenshot 2025-02-03 at 1 35 38 AM" src="https://github.com/user-attachments/assets/e6efa7a4-2d11-459a-bec1-559f4017f134" />

3. Set name "Config" and check NooroWeather app target.

<img width="451" alt="Screenshot 2025-02-03 at 1 40 04 AM" src="https://github.com/user-attachments/assets/2be37417-dafa-4f59-b44e-e140f7d13135" />

4. Open Config file add line:

WEATHER_API_KEY = 1231231231231231231

Key name should be 'WEATHER_API_KEY'
Key value should be you weather API key without any quotes.

<img width="700" alt="Screenshot 2025-02-03 at 1 45 15 AM" src="https://github.com/user-attachments/assets/34375956-aff9-4109-8427-beac1590dc6b" />

5. Now try to build. I hope it will work 🤞.

### About

Technologies used for this task:

- SwiftUI
- Combine
- MVVM Architecture
- Dependency Injection
- Async/Await
- Swift Testing

I tried to make this demo project as simple as possible.

I used AsyncImage for images because it has some basic caching under the hood and easy to use.
But in case of need to use more presise caching mechanisms better create manager which will download and save images to the file system.

I used UserDefaults for persistence because I don't want to overcomplicate demo project with SwiftData/CoreData or any other 3rd-party libraries.

I used configuration file to keep API keys, but in real-life project I would probably use on-demand resources because it's much safer to keep API keys outside the package.

# Task

### **Objective**

Build a weather app that demonstrates your skills in **Swift**, **SwiftUI**, and **clean architecture**. The app should allow users to search for a city, display its weather on the home screen, and persist the selected city across launches. Follow the **Figma designs** closely and integrate data from **WeatherAPI.com**.

---

### **Task Description**

1. **Home Screen**:
    - Displays weather for a single **saved city**, including:
        - City name.
        - Temperature.
        - Weather condition (with corresponding icon from the API).
        - Humidity (%).
        - UV index.
        - "Feels like" temperature.
    - If no city is saved, prompt the user to search.
    - **Search bar** for querying new cities.
2. **Search Behavior**:
    - Show a **search result card** for the queried city.
    - Tapping the result updates the Home Screen with the city’s weather and persists the selection.
3. **Local Storage**:
    - Use **UserDefaults** (or equivalent) to persist the selected city.
    - Reload the city’s weather on app launch.

---

### **API Integration**

- Use **WeatherAPI.com** to fetch weather data:
    - API Documentation: [WeatherAPI Documentation](https://www.weatherapi.com/docs/).
    - Free tier includes current weather data with:
        - **Temperature**.
        - **Weather condition** (including an icon URL).
        - **Humidity (%).**
        - **UV index.**
        - **Feels like** temperature.

---

### **Requirements**

1. **Tech Stack**:
    - Use **Swift** and **SwiftUI** exclusively.
    - Follow **MVVM architecture** with modular, testable code.
    - Use **protocol-oriented programming** and dependency injection.
2. **API**:
    - Fetch weather data using WeatherAPI.com.
    - Handle errors gracefully (e.g., invalid cities, no network).
3. **UI**:
    - Match the **Figma designs** [here](https://www.figma.com/design/0zySCKWbyeRO805ifaz1lr/Weather-App-Test-Task?node-id=0-1).
    - Ensure visual consistency (**95% accuracy**).
4. **Time**:
    - This task should take **no more than 5 hours**. Please stop after 5 hours so that not only do you not overwork yourself but we get a feel for your speed.

---

### **Submission**

1. Send an email and provide a public **GitHub repo** with:
    - Complete source code.
    - Setup instructions in the README.
2. Questions? Feel free to reach out for clarification.

---

### **Evaluation Criteria**

1. **Architecture & Code Quality**:
    - Clean, modular, and testable code.
    - Proper separation of concerns (MVVM).
2. **Local Storage**:
    - Reliable persistence of the selected city.
3. **Networking**:
    - Smooth API integration and error handling.
4. **UI/UX**:
    - Matches Figma designs and feels intuitive.
    - Includes all required weather details (e.g., icons, humidity, UV index, "feels like").


