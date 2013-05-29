install:
	install -m 0755 log-ci /usr/local/bin

uninstall:
	rm /usr/local/bin/log-ci

.PHONY: install