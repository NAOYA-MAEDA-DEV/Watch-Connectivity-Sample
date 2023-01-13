# Watch-Connectivity-Sample
Watch-Connectivity-Sample is a sample SwiftUI code for Watch-Connectivity explanation.

https://zenn.dev/naoya_maeda/articles/d63504a860c36c

<img width="400" alt="Text" src="https://user-images.githubusercontent.com/79180266/212253886-736ea29e-323f-427a-8ec0-7c7c753af9f0.gif">

## How to build
1. Download or Clone this project and open in Xcode.

2. Build on your actual device or simulator.

## Contents
### sendMessage(_:replyHandler:errorHandler:)
Sends a message immediately to the paired and active device and optionally handles a response.

<img width="400" alt="Text" src="https://user-images.githubusercontent.com/79180266/212253886-736ea29e-323f-427a-8ec0-7c7c753af9f0.gif">

### updateApplicationContext(_:)
Sends a dictionary of values that a paired and active device can use to synchronize its state.

<img width="400" alt="Text" src="https://user-images.githubusercontent.com/79180266/212257838-9af038d5-48a5-492f-aa88-30446fd41b5b.gif">

### transferUserInfo(_:)
Sends the specified data dictionary to the counterpart.

Since transferUserInfo(_:) does not work in the simulator, the operation video is omitted.

### transferFile(_:metadata:)
Sends the specified file and optional dictionary to the counterpart.

<img width="400" alt="Text" src="https://user-images.githubusercontent.com/79180266/212256913-1f286a4f-d895-4ffb-9f80-ef0ba735c00d.gif">
