# The weather
A simple test app

# How to run
## Fetch packages
```
flutter pub get
```

## Environment configuring
First of all you need to configure the environment vars:
1. Create the `.env` file in the root of this project
2. Fill it:
```
# Rapid API access key
RAPID_API_KEY=XXX

# Open Weather Map access key
OWM_API_KEY=XXX
```

## Run it
VSCode debugger configuration located at `.vscode` directory<br/>
You may to select the configuration and press `F5`

Terminal way:
```
flutter run[ -d %DEVICE_IDENTIFICATOR%]
```
