up: docker-up
down: docker-down
restart: docker-down docker-up

docker-up:
	docker-compose up -d

docker-down:
	docker-compose down --remove-orphans

docker-down-clear:
	docker-compose down -v --remove-orphans

set:
	@read -p "Enter the key: " key && \
	read -p "Enter the ttl (optional): " ttl && \
	read -p "Enter the value: " value && \
	if [ $$ttl > 0 ]; then \
	  docker-compose exec redis redis-cli setex $$key $$ttl $$value; \
	else \
	  docker-compose exec redis redis-cli set $$key $$value; \
	fi

incr:
	@read -p "Enter the key: " key && \
	read -p "Enter the increment (optional): " increment && \
	if [ $$increment > 0 ]; then \
	  docker-compose exec redis redis-cli incrby $$key $$increment; \
	else \
	  docker-compose exec redis redis-cli incr $$key; \
	fi

get:
	read -p "Enter the key: " key && \
	docker-compose exec redis redis-cli get $$key

del:
	read -p  "Enter the key: " key && \
	docker-compose exec redis redis-cli del $$key

exists:
	read -p "Enter the key: " key && \
	docker-compose exec redis redis-cli exists $$key

flush:
	docker-compose exec redis redis-cli flushall

expire:
	read -p "Enter the key: " key && \
	read -p "Enter the ttl: " ttl && \
	docker-compose exec redis redis-cli expire $$key $$ttl

ttl:
	read -p "Enter the key: " key && \
	docker-compose exec redis redis-cli ttl $$key

# List

l-add:
	@read -p "Enter the key: " key && \
	read -p "Enter the value: " value && \
	read -p "Enter l/r for the direction, right by default: " direction && \
	if [ $$direction = "l" ]; then \
	  docker-compose exec redis redis-cli lpush $$key $$value; \
	else \
	  docker-compose exec redis redis-cli rpush $$key $$value; \
	fi

l-read:
	read -p "Enter the key: " key && \
	docker-compose exec redis redis-cli lrange $$key 0 -1

l-pop:
	@read -p "Enter the key: " key && \
	read -p "Enter l/r for the direction, right by default: " direction && \
	if [ $$direction = "l" ]; then \
	  docker-compose exec redis redis-cli lpop $$key; \
	else \
	  docker-compose exec redis redis-cli rpop $$key; \
	fi

# Set

s-add:
	read -p "Enter the key: " key && \
	read -p "Enter the value: " value && \
  	docker-compose exec redis redis-cli sadd $$key $$value;

s-read:
	read -p "Enter the key: " key && \
  	docker-compose exec redis redis-cli smembers $$key;

s-del:
	read -p "Enter the key: " key && \
	read -p "Enter the value: " value && \
  	docker-compose exec redis redis-cli srem $$key $$value;

z-add:
	read -p "Enter the key: " key && \
	read -p "Enter the score: " score && \
	read -p "Enter the member: " member && \
	docker-compose exec redis redis-cli zadd $$key $$score $$member;

z-incr:
	read -p "Enter the key: " key && \
	read -p "Enter the score: " score && \
	read -p "Enter the member: " member && \
	docker-compose exec redis redis-cli zincrby $$key $$score $$member;

# Hash

h-add:
	read -p "Enter the key: " key && \
	read -p "Enter the field: " field && \
	read -p "Enter the value: " value && \
  	docker-compose exec redis redis-cli hset $$key $$field $$value;

h-read:
	read -p "Enter the key: " key && \
	read -p "Enter the field (optional): " field && \
	if [ $$field ]; then \
	  docker-compose exec redis redis-cli hget $$key $$field; \
	else \
	  docker-compose exec redis redis-cli hgetall $$key; \
	fi

h-del:
	read -p "Enter the key: " key && \
	read -p "Enter the field: " field && \
	docker-compose exec redis redis-cli hdel $$key $$field;
