NAME = ft_server

all:
	docker build -t $(NAME) .

stop:
	docker stop $(NAME)

start:
	docker run --name $(NAME) -dp 80:80 -p 443:443 $(NAME)

start_noindex:
	docker run --env AUTO_INDEX=off --name $(NAME) -dp 80:80 -p 443:443 $(NAME)

bash:
	docker exec -it ft_server bash

save:
	docker save jaybeest/ft_server:latest | gzip > ft_server_latest.tar.gz
clean:
	docker rm $(NAME)

fclean: clean
	docker image rm $(NAME)

re: fclean all

test: all start bash