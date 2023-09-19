# Makefile

# Updated: <2023-09-18 16:15:35 david.hisel>

build:
	podman build -t punt:latest -f Dockerfile

nocache-build:
	podman build --no-cache -t punt:latest -f Dockerfile

run:
	podman run --rm -it --name punt -v $(CURDIR)/local.env:/tmp/local.env --mount type=tmpfs,destination=/data localhost/punt:latest
