# gym_tec

A mobile and web app writen in flutter that uses Firebase as a backend to manage the gym of the Tecnológico de Costa Rica.

## Getting Started

This project is a starting point for a Flutter application.

## Firebase
install firebase cli
`npm install -g firebase-tools`

### run emulators
to start the app in debug mode make shure to use the emulators as follows:
`firebase emulators:start --import emulator_data`

### Deploy rules
Firebase rules will be loaded automatically to the emulators when they are started. To deploy the rules to the production database use the following command:
`firebase deploy --only firestore:rules`
https://www.youtube.com/watch?v=eW5MdE3ZcAw
