

.onAttach <- function(libname, pkgname) {

    .startup_message <-
"
  ___          ____  ___ __     __ ___  ____   _   ___
 / _ \\ __  __ / ___|/ _ \\\\ \\   / /|_ _||  _ \\ / | / _ \\
| | | |\\ \\/ /| |   | | | |\\ \\ / /  | | | | | || || (_) |
| |_| | >  < | |___| |_| | \\ V /   | | | |_| || | \\__, |
 \\___/ /_/\\_\\ \\____|\\___/   \\_/   |___||____/ |_|   /_/
    ___           _          _
   |  _ \\   __ _ | |_  __ _ | |__    __ _  ___   ___
   | | | | / _` || __|/ _` || '_ \\  / _` |/ __| / _ \\
   | |_| || (_| || |_| (_| || |_) || (_| |\\__ \\|  __/
   |____/  \\__,_| \\__|\\__,_||_.__/  \\__,_||___/ \\___|

The OxCOVID19 Database makes use of several datasets. If you
use any of the data provided by this package, please include
the appropriate citation as described at the following
website:

https://covid19.eng.ox.ac.uk/data_sources.html

"

    packageStartupMessage(.startup_message)
}
