library(fs)
library(knitr)
library(rmarkdown)

# Copy source files to build directory
if (dir_exists("build")) {
    dir_delete("build")
}
dir_copy("src", "build")

# purl() should be run from the same directory as its target
setwd("build")

for (file in Sys.glob("*.Rmd")) {
    # Generate executable R files with Markdown text included as comments
    purl(file, documentation = 2)

    # Generate other presentation formats
    render(file, c("md_document", "html_document", "pdf_document"))
}

# Restore original working irectory
setwd("../")
