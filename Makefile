# Include .env file if it exists
ifneq (,$(wildcard .env))
    include .env
    export
endif

# Define the target
deploy:
	@echo "Running deploy script for TransferUSDC to deploy it on Fuji"
	forge script script/TransferUSDC.s.sol --rpc-url $(FUJI_RPC_URL) --private-key $(PRIVATE_KEY) --broadcast --verifier-url $(SNOWTRACE_VERIFIER_URL) --etherscan-api-key $(SNOWTRACE_API_KEY)

# Optional: Add a help target to describe how to use the Makefile
help:
	@echo "Usage:"
	@echo "  make deploy        Run the deploy script with the specified environment variables"
