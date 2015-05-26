pns-pub
===

## Install

```
npm install
```

## Create .env

Here is the sample `.env`. See also `dotenv` file in the project root.

	# Adapter type
	ADAPTER=redis
	#ADAPTER=pusher

	# Pusher API credentials
	PUSHER_APPID=<Your pusher appId>
	PUSHER_KEY=<Your pusher key>
	PUSHER_SECRET=<Your pusher secret>

## Run

```
npm run start
```

## Test

```
npm run test
```

## Pushing events

### Curl

```
$ curl -i -H 'Content-Type: application/json' -d '{"name":"my_event", "data":{"message":"Hello world"}, "channels":["test_channel","test_channel2", "test_channel3", "test_channel4", "test_channel5", "test_channel6", "test_channel7", "test_channel8", "test_channel9"]}' "http://localhost:8080/api/v1/events"
```
