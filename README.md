# socketio-docker

Docker image for socket.io with ioredis

## Usage

Copy your socket.io server script to `/srv/socket.js`

Supervisord logs are stored in `/srv/logs`

### Exapmles

#### socket.js

```js
var server = require('http').Server();

var io = require('socket.io')(server);

var Redis = require('ioredis');
var redis = new Redis(6379, 'redis');

redis.subscribe('my-channel', function () {
    console.log('Subscription successful');
});

redis.on('message', function(channel, message) {
    console.log(channel, message);
    io.emit(channel, message);
});

server.listen(3000);

```

#### docker-compose.yml

```yaml
version: '2'
services:
    redis:
        image: redis:alpine

    websocket:
        image: socketio
        depends_on:
            - redis
        links:
            - redis
        volumes:
            - ./socket.js:/srv/socket.js
            - ./.data/websocket:/srv/logs
        ports:
            - "3000:3000"

```
