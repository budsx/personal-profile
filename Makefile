build:
	docker build -t personal-profile .

run:
	docker run -p 80:80 personal-profile
