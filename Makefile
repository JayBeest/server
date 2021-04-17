NAME = ft_server

all:
	docker build -t $(NAME) .

stop:
	docker stop $(NAME)

start:
	docker run --name $(NAME) -dp 80:80 -p 443:443 $(NAME)

bash:
	docker exec -it ft_server bash
clean:
	docker rm $(NAME)
	docker image rm $(NAME)

re: clean all

test: all start bash