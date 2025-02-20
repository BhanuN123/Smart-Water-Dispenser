# Smart Water Dispenser

## Overview

The Smart Water Dispenser is an innovative IoT-based project designed to provide a seamless and efficient water dispensing experience. This system integrates with a mobile application, allowing users to monitor and control water dispensing remotely.

## Features

- **Automated Dispensing**: Dispenses a predefined amount of water with a single command.
- **Remote Monitoring**: Keep track of water levels and dispensing history through the mobile app.
- **User Authentication**: Ensures that only authorized users can dispense water, enhancing security.
- **Customizable Settings**: Adjust dispensing volumes and schedules according to user preferences.

## Components

- **Hardware**:
  - Microcontroller (e.g., Arduino UNO)
  - Water flow sensor
  - Solenoid valve
  - Wi-Fi module (e.g., ESP8266)
  - LCD display
  - Push buttons
  - Power supply

- **Software**:
  - Embedded C/C++ for microcontroller programming
  - Mobile application developed using Flutter (Dart)

## Installation and Setup

1. **Hardware Assembly**:
   - Connect the water flow sensor to monitor the amount of water dispensed.
   - Install the solenoid valve to control the flow of water.
   - Set up the Wi-Fi module for network connectivity.
   - Attach the LCD display and push buttons for manual control and status display.
   - Ensure all components are properly powered and connected.

2. **Software Installation**:
   - Program the microcontroller with the provided firmware code.
   - Install the mobile application on your smartphone.
   - Connect the mobile application to the hardware system via Wi-Fi.

## Usage

- **Dispensing Water**:
  - Use the mobile application or the physical push buttons to dispense water.
  - Monitor the dispensed volume in real-time on the LCD display or the mobile app.

- **Monitoring and Control**:
  - Check the current water level and dispensing history through the mobile app.
  - Adjust settings such as dispensing volume and schedule as per your requirements.

## Repository Structure

- `SmartWaterApp/`: Contains the source code for the mobile application developed using Flutter.
- `SmartWaterDispenser_System/`: Includes the firmware code for the microcontroller and hardware schematics.
- `LICENSE`: Details the licensing information for this project.
- `README.md`: Provides an overview and instructions for the project.

## License

This project is licensed under the MIT License. See the `LICENSE` file for more details.

## Acknowledgments

Special thanks to the contributors and the open-source community for their support and resources.
