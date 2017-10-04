# SFAuthenticationSession not sharing cookies with/from Safari

Example showing iOS 11's [SFAuthenticationSession](https://developer.apple.com/documentation/safariservices/sfauthenticationsession) is not sharing cookies with/from Safari on devices. Contains a simple python Flask web service to create and return cookies and an iOS app that uses SFAuthenticationSession API to set/fetch cookies from the Flask app. Assumes you have some level of familiarity with Xcode and the command line, but does not require experience with python / Flask.

**Note:** *There appears to be [a bug with SFAuthenticationSession](https://twitter.com/rmondello/status/887434621989789696) that prevents this from working.*

**NOTE:** Credit goes to [dvdhpkns](https://github.com/dvdhpkns/SFAuthenticationSession-example) for the initial example template.

## Running

You will need to start the Flask server, and run the iOS app on a device using xcode 9.

### Run the Server

The following assume you have python 2.7 installed and set as your default python version:

```bash
cd server
pip install virtualenv
source env/bin/activate
pip install -r requirements.txt
python app.py
```

Go to [http://0.0.0.0:5000/](http://0.0.0.0:5000/) in your browser to confirm the app is working. You should see something like the following:

```
Simple flask app to create and get cookies. Can redirect to a callbackUrl to deep link into app.

Example using cookie "user" - replace with any cookie of your choice:
/create-cookie/user - sets random cookie val for "user"
/get-cookie/user - gets cookie val for "user" with optional query param "callbackUrl" to be redirected to with cookie appended as query param
/delete-cookie/user - expires cookie for "user"
```

### Run the Apps

Xcode 9 and iOS 11 are required to run the app. To attempt fetching cookies from Safari, do the following:

1. Run the app1 and app2 on an iOS 11 device.
2. Enter local network address of machine into text field (MacOS: Settings > Sharing > Under "Computer Name" Field )
3. In one app, click "Create Cookie" and ensure label is populated with cookie string
4. Switch to other app, and click "Get Cookie"
