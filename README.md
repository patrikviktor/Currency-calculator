# Currency Calculator App

This repository contains a currency calculator that uses the actual European Central Bank (ECB) rates for conversions. The project is divided into two main parts:

- **Frontend:** A Flutter application.
- **Backend:** A NestJS server handling the API.

## Project Structure

- **exchange_app/**  
  Contains the Flutter application for currency conversion.
- **exchange-currency/**  
  Contains the NestJS backend for processing API requests and currency rate calculations.

## Getting Started

Follow these instructions to set up and run both the Flutter frontend and the NestJS backend.

### NestJS Backend

1. Open a separate terminal and navigate to the backend directory:

`cd exchange-currency`

2. Install the required dependency (including the NestJS core library):

`npm install @nestjs/core`

3. Start the NestJS backend server:

`nest start`

### Flutter Application

1. Open your terminal and navigate to the Flutter project directory:

cd exchange_app

2. Install the necessary Flutter packages:

`flutter pub get`

3. Run the Flutter app on your emulator or device:

`flutter run`  

