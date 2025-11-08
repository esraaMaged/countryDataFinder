# 🌍 Country Data Finder

A SwiftUI iOS app that lets users search for countries, view their capitals and currencies, and automatically add the user’s own country based on location.

---

## ✨ Features

- 🔍 Search countries by name using the REST Countries API  
- 📍 Detect and display user’s country by location (default on launch)  
- 🚫 Show reminder to grant location permission if denied  
- 📄 Country details screen with capital and currency info  
- 🧾 Country list with swipe-to-delete and max limit of 5  
- 🧭 Loading & error views  
- 🧪 Unit tests and UI tests included  

---

## 🌐 API Used

**REST Countries API (v2):**  
https://restcountries.com/v2/name/\(encodedName)?fields=name,capital,currencies

**Example:**  
https://restcountries.com/v2/name/Egypt?fields=name,capital,currencies


---

## ⚙️ Tech Stack

- SwiftUI  
- Combine  
- CoreLocation / MapKit  
- XCTest  

---

## 🧭 Location Simulation

To test location in Xcode Simulator:  
**Features → Location → Custom Location…**  
Example for Paris: `48.8566, 2.3522`

---

## 🎥 App Demo

|  |  |
|------|---------|
| ![SimulatorScreenRecording-iPhone17Pro-2025-11-08at21 34 49-ezgif com-optimize](https://github.com/user-attachments/assets/d8c0c4bf-9529-456a-b7c5-ad0fe44b1b8f) | ![SimulatorScreenRecording-iPhone17Pro-2025-11-08at21 36 27-ezgif com-optimize](https://github.com/user-attachments/assets/c25ccad2-2b2c-437d-a2c2-0c0855cf385a)|

## 📸 Screenshots

| Home | Search | Details |
|------|---------|----------|
| <img width="1206" height="2622" alt="Simulator Screenshot - iPhone 17 Pro - 2025-11-08 at 21 39 26" src="https://github.com/user-attachments/assets/95b44b3c-3857-4e32-8f23-2354b6697bcb" /> | <img width="1206" height="2622" alt="Simulator Screenshot - iPhone 17 Pro - 2025-11-08 at 21 39 07" src="https://github.com/user-attachments/assets/cb8e6d61-4517-4272-92d8-978c63fbdd97" /> | <img width="1206" height="2622" alt="Simulator Screenshot - iPhone 17 Pro - 2025-11-08 at 21 38 40" src="https://github.com/user-attachments/assets/902733eb-db84-4587-b4c4-36009fbcce76" /> |


## Created by Esraa Eldaltony ##

