# Final Project for PH8093

ShinyApps.io link: https://illustratedman-code.shinyapps.io/project/

This app is an interactive vizualization of the dataset: ["11000-medicine-details"](https://www.kaggle.com/datasets/singhnavjot2062001/11000-medicine-details).
While limited in scope, this project hopes to explore how a UI for interactive exploration
and comparison of many medicines would look.

The app has two pages, the home page and the data viewer page. The home page lists summary details about the dataset including how many unique uses and components a medicine might have. The data viewer page contains an interactive way to browse for individual medications. The main table supports selections, so the user can select multiple medications, which show up in the scatter, pie chart, and additional tables.

Initial data processing is done with `process_data.py`. The entry point to the shiny app is, of course, `app.R`.

## Package management

This project uses [Nix](https://nixos.org) for package managment. Nix is similar to docker in that it provides a declaritive way to install packages. As Nix means "snow" in latin, the nix file is named `flake.nix` and `flake.lock`. As I don't use the normal R package manager, I am not aware how similar declaritive installation is done in R, please see the list of R packages and python packages used:

```nix
rPackages = with pkgs.rPackages; [
	promises
	future
	languageserver
	shiny_router
	tidyverse
	shiny
	usethis
	rextendr
	devtools
	rsconnect
	DT
	box
	bslib
	plotly
	box_lsp
	box_linters
	RSQLite
];
myPy = pkgs.python3.withPackages (
	p: with p; [
		pandas
		numpy
		matplotlib
	]
);
```
