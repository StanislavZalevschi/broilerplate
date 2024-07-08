up:
	docker-compose up -d

rebuild:
	docker-compose up -d --build --force-recreate

ps:
	docker-compose ps

stop:
	docker-compose stop

php:
	docker-compose exec php bash

run-tests:
	docker-compose run tests bin/run_paratest.sh

logs:
	docker-compose logs -f

restart:
	docker-compose stop
	docker-compose up -d
