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

add:
	@read -p "Enter the key: " key && \
	read -p "Enter the value: " value && \
	read -p "Enter l/r for the direction, right by default: " direction && \
	if [ $$direction = "l" ]; then \
	  docker-compose exec redis redis-cli lpush $$key $$value; \
	else \
	  docker-compose exec redis redis-cli rpush $$key $$value; \
	fi

read:
	read -p "Enter the key: " key && \
	docker-compose exec redis redis-cli lrange $$key 0 -1
