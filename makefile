help: ## show this help
	@sed -ne "s/^##\(.*\)/\1/p" $(MAKEFILE_LIST)
	@printf "────────────────────────`tput bold``tput setaf 2` Make Commands `tput sgr0`────────────────────────────────\n"
	@sed -ne "/@sed/!s/\(^[^#?=]*:\).*##\(.*\)/`tput setaf 2``tput bold`\1`tput sgr0`\2/p" $(MAKEFILE_LIST)
	@printf "────────────────────────`tput bold``tput setaf 4` Make Variables `tput sgr0`───────────────────────────────\n"
	@sed -ne "/@sed/!s/\(.*\)?=\(.*\)##\(.*\)/`tput setaf 4``tput bold`\1:`tput setaf 5`\2`tput sgr0`\3/p" $(MAKEFILE_LIST)
	@printf "───────────────────────────────────────────────────────────────────────\n"

# remove if you want another default.
.DEFAULT_GOAL := help

deps := data/11000-medicines.db

run: ${deps} ## Run the app (in developer mode)
	R -e "shiny::runApp(port=5000)"

deploy: ${deps} ## Push the app to shinyapps.io
	R -e "rsconnect::deployApp()"

data/11000-medicines.db: process_data.py
	./$^

data: data/11000-medicines.db ## make the data from the raw data

clean:
	rm ${deps}

.PHONY := help run deploy data clean

