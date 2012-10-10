# Set hook to be run when Defaults is attached
setHook(packageEvent("Defaults", "attach"), function(...) { setDefaults(q, save="no"); useDefaults(q) })
# add Defaults to the default packages loaded on startup
old <- getOption("defaultPackages");
options(defaultPackages = c(old, "Defaults"))

options(editor="vim")
options(prompt="r| ")
options(tab.width = 2)
options(width = 130)
options(graphics.record=TRUE)
options(htmlhelp=FALSE)
options(max.print=9999)
options(show.signif.stars=FALSE)
#Sys.setenv(R_HISTFILE=file.path("~", ".Rhistory"))
Sys.setenv(R_HISTSIZE='100000')
options("pdfviewer"="evince")

.First <- function() {
    library(graphics)
    options("repos" = c(CRAN = "http://cran.r-project.org/"))
    options("device" = "X11")
}

.Last <- function() {
        if (!any(commandArgs()=='--no-readline') && interactive()){
                require(utils)
                try(savehistory(Sys.getenv("R_HISTFILE")))
        }
}

library(colorout) # Colorize R output in terminal
library(plyr)
# ensure that scat is available.
#source("http://biostatmatt.com/R/scat.R")
library(txtplot)

