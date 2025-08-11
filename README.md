# 📱 Daily Motivation

A Flutter-based mobile app that delivers daily motivational quotes to inspire positivity and productivity. Designed with a clean, modern UI featuring a random quote on the home screen and a full list of quotes with translations.

---

## ✨ Features

* 🎯 **Daily Quote** — Get a random motivational quote every day.
* 📜 **Quote List** — Browse all stored quotes at any time.
* 🌐 **Bilingual Quotes** — Original text + meaning/translation.
* 📤 **Share Feature** — Share quotes via WhatsApp and other apps.
* 🎨 **Modern UI** — Clean card design with pleasant typography.

---

## 🛠️ Tech Stack

* **Framework**: Flutter (Dart)
* **State Management**: Simple `setState`
* **Dependencies**:

  * [`google_fonts`](https://pub.dev/packages/google_fonts) — typography
  * [`share_plus`](https://pub.dev/packages/share_plus) — system share sheet
  * [`shared_preferences`](https://pub.dev/packages/shared_preferences) — lightweight local storage

---

## 🚀 Getting Started

1. **Clone the repository**

   ```bash
   git clone https://github.com/hijrahassalam/dailymotivation.git
   cd dailymotivation
   ```

2. **Install dependencies**

   ```bash
   flutter pub get
   ```

3. **Run the app**

   ```bash
   flutter run
   ```

> **Note**: Ensure you have Flutter SDK set up. See the [Flutter docs](https://docs.flutter.dev/get-started/install).

---

## 📁 Project Structure (excerpt)

```
lib/
  main.dart           # App entry, UI & logic
assets/
  quotes.json         # Quote data (text + meaning)
```

---

## 🗺️ Roadmap (nice-to-have)

* Favorite & bookmark quotes
* Search & filter
* Theming (light/dark)
* Simple local notifications for daily reminder

---

## 👤 Author

**Nur Hijrah As Salam Al Ihsan** — [@hijrahassalam](https://github.com/hijrahassalam)

---

## 📄 License

This project is licensed under the **MIT License**. See the `LICENSE` file for details.
