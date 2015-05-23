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

	# Redis setting
	#REDIS_HOST=localhost
	#REDIS_PORT=7000

## Launch

```
npm run start
```

## Pushing a message

### With curl

```
$ curl -i -H 'Content-Type: application/json' -d '{"name":"my_event", "data":{"message":"Hello world"}, "channels":["test_channel","test_channel2", "test_channel3", "test_channel4", "test_channel5", "test_channel6", "test_channel7", "test_channel8", "test_channel9", "test_channel10", "test_channel11"]}' "http://localhost:3000/api/v1/events"
```
