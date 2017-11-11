docker-compose build
docker-compose run --rm auth-ms rails db:create
docker-compose run --rm auth-ms rails db:migrate
docker-compose up
