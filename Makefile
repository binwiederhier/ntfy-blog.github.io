.PHONY:

help:
	@echo "Build documentation:"
	@echo "  make build                       - Build the documentation"
	@echo "  make update                     - Update Python dependencies (pip3 install)"
	@echo


# Building everything

clean: .PHONY
	rm -rf docs

build: clean
	mkdocs build
	echo blog.ntfy.sh > docs/CNAME

update: .PHONY
	pip3 install -r requirements.txt --upgrade

