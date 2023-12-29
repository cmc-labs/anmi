# Makefile to automate the processing of M4 templates and executing Cypher scripts

# Variables
M4_SOURCE := mediengraph.m4
CYPHER_SCRIPT := create.cypher
DELETE_SCRIPT := delete.cypher

# Default target
all: run

# Generate Cypher script from M4 template
$(CYPHER_SCRIPT): $(M4_SOURCE)
    m4 $(M4_SOURCE) > $(CYPHER_SCRIPT)

# Run the Cypher script
run: $(CYPHER_SCRIPT)
    cypher-shell -f $(CYPHER_SCRIPT)

delete:
    cypher-shell -f $(DELETE_SCRIPT)

# Clean up generated files
clean:
    rm -f $(CYPHER_SCRIPT)

.PHONY: all run clean
