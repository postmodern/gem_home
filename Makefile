NAME=gem_home
VERSION=0.1.0
AUTHOR=postmodern
URL=https://github.com/$(AUTHOR)/$(NAME)

DIRS=etc lib bin sbin share
INSTALL_DIRS=`find $(DIRS) -type d 2>/dev/null`
INSTALL_FILES=`find $(DIRS) -type f 2>/dev/null`
DOC_FILES=*.md *.txt

PKG_DIR=pkg
PKG_NAME=$(NAME)-$(VERSION)
PKG=$(PKG_DIR)/$(PKG_NAME).tar.gz
SIG=$(PKG).asc

PREFIX?=/usr/local
SHARE_DIR=share
DOC_DIR=$(SHARE_DIR)/doc/$(PKG_NAME)

pkg:
	mkdir $(PKG_DIR)

share/man/man1/gem_home.1: doc/man/gem_home.1.md
	kramdown-man doc/man/gem_home.1.md > share/man/man1/gem_home.1

man: doc/man/gem_home.1.md share/man/man1/gem_home.1
	git add doc/man/gem_home.1.md share/man/man1/gem_home.1
	git commit

download: pkg
	wget -O $(PKG) $(URL)/archive/v$(VERSION).tar.gz

build: pkg
	git archive --output=$(PKG) --prefix=$(PKG_NAME)/ HEAD

sign: $(PKG)
	gpg --sign --detach-sign --armor $(PKG)
	git add $(PKG).asc
	git commit $(PKG).asc -m "Added PGP signature for v$(VERSION)"
	git push origin master

verify: $(PKG) $(SIG)
	gpg --verify $(SIG) $(PKG)

clean:
	rm -f $(PKG) $(SIG)

all: $(PKG) $(SIG)

check:
	shellcheck share/$(NAME)/*.sh

test:
	SHELL=`command -v zsh`  ./test/runner
	SHELL=`command -v bash` ./test/runner
	SHELL=`command -v bash` GEM_HOME= GEM_PATH= ./test/runner
	SHELL=`command -v bash` GEM_HOME=/usr/gems GEM_PATH=/usr/gems:/sys/gems PATH=/usr/gems/bin:/sys/gems/bin:$(PATH) ./test/runner

tag:
	git push origin master
	git tag -s -m "Releasing $(VERSION)" v$(VERSION)
	git push origin master --tags

release: tag download sign

rpm:
	rpmdev-setuptree
	spectool -g -R rpm/chruby.spec
	rpmbuild -ba rpm/chruby.spec

install:
	for dir in $(INSTALL_DIRS); do mkdir -p $(DESTDIR)$(PREFIX)/$$dir; done
	for file in $(INSTALL_FILES); do cp $$file $(DESTDIR)$(PREFIX)/$$file; done
	mkdir -p $(DESTDIR)$(PREFIX)/$(DOC_DIR)
	cp -r $(DOC_FILES) $(DESTDIR)$(PREFIX)/$(DOC_DIR)/

uninstall:
	for file in $(INSTALL_FILES); do rm -f $(DESTDIR)$(PREFIX)/$$file; done
	rm -rf $(DESTDIR)$(PREFIX)/$(DOC_DIR)

.PHONY: build download sign verify clean check test tag release rpm install uninstall all
