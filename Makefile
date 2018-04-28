#The name of the binary we'll use for our app
BINARY=gote

#The  current commit
BUILD_COMMIT=`git rev-parse HEAD`

#The current build version tag if it exists, defaults to commitsha if not. Also if dirty appends -dirty.
VERSION_TAG=`git describe --tags --always --dirty`

#The root import path for the project
ROOT_IMPORT_PATH := github.com/andrewpolidori/gote

# The build target
.DEFAULT_GOAL= $(BINARY)

# Makes binary
$(BINARY):
	@echo Building $(BINARY)
	cd cmd/dungeondb && go build $(LDFLAGS) -o $(BINARY)	

#Runs the application unit tests
test:
	@echo Running unit tests for all packages
	./scripts/test.sh
.PHONY: test

#Cleanup
clean: 
	@echo removing $(BINARY) executable
	if [ -f $(BINARY) ] ; then rm $(BINARY) ; fi
	@echo executable removed

	@echo removing coverage folder
	if [ -d cover ]; then rm -rf cover; fi
	@echo coverage folder removed

.PHONY: clean

cover:
	@echo generating test coverage
	./scripts/coverage.sh
.PHONY: cover