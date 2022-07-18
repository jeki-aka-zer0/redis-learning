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
	@echo "Enter the key" && read key && \
	echo "Enter the ttl" && read ttl && \
	echo "Enter the value" && read value && \
	if [ $$ttl > 0 ]; then \
	  docker-compose exec redis redis-cli setex $$key $$ttl $$value; \
	else \
	  docker-compose exec redis redis-cli set $$key $$value; \
	fi

get:
	echo "Enter the key" && read key && \
	docker-compose exec redis redis-cli get $$key

del:
	echo "Enter the key" && read key && \
	docker-compose exec redis redis-cli del $$key

exists:
	echo "Enter the key" && read key && \
	docker-compose exec redis redis-cli exists $$key

flush:
	docker-compose exec redis redis-cli flushall

expire:
	echo "Enter the key" && read key && \
	echo "Enter the ttl" && read ttl && \
	docker-compose exec redis redis-cli expire $$key $$ttl

ttl:
	echo "Enter the key" && read key && \
	docker-compose exec redis redis-cli ttl $$key

# List

push:
	echo "Enter the key" && read key && \
	echo "Enter the value" && read value && \
	docker-compose exec redis redis-cli lpush $$key $$value

read:
	echo "Enter the key" && read key && \
	docker-compose exec redis redis-cli lrange $$key 0 -1
