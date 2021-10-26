##Install retimes from archive
url = "https://cran.r-project.org/src/contrib/Archive/retimes/retimes_0.1-2.tar.gz"
pkgFile = "retimes_0.1-2.tar.gz"
download.file(url = url, destfile = pkgFile)

install.packages(pkgs=pkgFile, type="source", repos=NULL)

unlink(pkgFile)
