packages <- c(
  "knitr", "readr", "dplyr", "plyr",
  "here", # for the project's organization
  "tidyverse", "kableExtra", "microbenchmark",
  "ggplot2", "plot.matrix", "rstan", "quanteda",
  "quanteda.textstats", "lexicon", "tidytext", "reshape2",
  "rstan",'deSolve','stats',"MASS",'ModelMetrics',"reshape",
  'gganimate','ggimage','transformr','ggimage',
  "gapminder", "ggforce", "gh", "globals", "openintro", "profvis",
  "RSQLite", "shiny", "shinycssloaders", "shinyFeedback",
  "shinythemes", "testthat", "thematic", "tidyverse", "vroom",
  "waiter", "xml2", "zeallot",'shiny','shinyWidgets'
)

packages <- data.frame(packages)

pkgs <- packages

# Print the package names and versions
for (pkg in pkgs[,1]) {
  version <- pkgs[pkgs[,1]==pkg, "Version"]
  print(packageVersion(version))
}

install.packages('shinyWidgets')

# Create a vector of packages
packages <- c(
  "knitr", "readr", "dplyr", "plyr",
  "here", # for the project's organization
  "tidyverse", "kableExtra", "microbenchmark",
  "ggplot2", "plot.matrix", "rstan", "quanteda",
  "quanteda.textstats", "lexicon", "tidytext", "reshape2",
  "rstan",'deSolve','stats',"MASS",'ModelMetrics',"reshape",
  'gganimate','ggimage','transformr','ggimage',
  "gapminder", "ggforce", "gh", "globals", "openintro", "profvis",
  "RSQLite", "shiny", "shinycssloaders", "shinyFeedback",
  "shinythemes", "testthat", "thematic", "tidyverse", "vroom",
  "waiter", "xml2", "zeallot",'shiny','shinyWidgets'
)

# Convert the vector into a data frame
pkgs <- data.frame(packages)

# Print the package names and versions
for (pkg in pkgs[,1]) {
  version <- packageVersion(pkg)
  print(paste(pkg, "(>=" ,version, ")"))
}
