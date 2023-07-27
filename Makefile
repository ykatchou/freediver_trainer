all: front-build back-build

clean: front-clean back-clean

run: 
	cd $(BACK_SRC);cargo run

front: front-build
back: back-build

BACK_SRC=src-back
FRONT_SRC=src-front
PKG_ELM_JS=$(BACK_SRC)/html/static/main.js

front-build:
	cd $(FRONT_SRC); elm make src/Main.elm --output=main.js
	mv $(FRONT_SRC)/main.js $(PKG_ELM_JS)

front-clean:
	cd $(FRONT_SRC); rm main.js


back-build:
	cd $(BACK_SRC); cargo build

back-clean:
	cd $(BACK_SRC); cargo clean
	rm -f $(PKG_ELM_JS)
