.PHONY: all
all: artifacts/macos-x86-64 artifacts/linux-x86-64

.PHONY: clean
clean:
	rm -rf artifacts

.PHONY: deploy
deploy: all
	bin/deploy.sh

artifacts/macos-x86-64: libsass
	bash bin/build-macos-x86-64.sh

artifacts/linux-x86-64: libsass
	docker build -t racket-libsass-ubuntu:latest .
	docker run --rm -v $(shell pwd):/workspace -w /workspace racket-libsass-ubuntu:latest bin/build-linux-x86-64.sh
