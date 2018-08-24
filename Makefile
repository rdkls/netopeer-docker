build:
	docker rmi -f netopeer2 2>/dev/null
	docker build --tag netopeer2 .

test:
	docker run --rm -ti --name netopeer2 netopeer2 bash

all: image
	docker run --rm -ti --name netopeer2 netopeer2 ash


