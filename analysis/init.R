# source('init.r')

# ----------- # # ----------- # # ----------- #
# DEPENDENCIES

library( reshape2 )
library( knitr )
library( markdown )
library( rattle )
library( ggplot2 )
library( scales )
library( dplyr )
library( RColorBrewer )
library( RPostgreSQL )
library( Quandl )
library( quantmod )

# ----------- # # ----------- # # ----------- #
# SET UP

# helper functions

loadDir <- function( dir ) {
  if ( file.exists( dir ) ) {
    files <- dir( dir , pattern = '[.][rR]$' )
    lapply( files, function( file ) loadFile( file, dir ) )
  }
}

loadFile <- function( file, dir ) {
  filename <- paste0( dir, '/', file )
  source( filename )
}

setReportingWd <- function() {
  if( basename( getwd() ) == 'templates' ) {
    setwd( '../../' )
  }
}

knitrGlobalConfig <- function() {
  opts_chunk$set( fig.width = 14, fig.height = 6,
    fig.path = paste0( getwd(), '/reports/output/figures/',
    set_comment = NA ) )
}

setEnvVars <- function() {
  source('env.R')
}

connectToAnalyticsDB <- function() {
  if (!exists('ANALYTICS_DB')) {
    ANALYTICS_DB = dbConnect(
      PostgreSQL(),
      user = DB_UNAME,
      password = DB_PWORD,
      dbname = DB_NAME,
      host = DB_HOST,
      port = DB_PORT
    )
  }
}

# Config env
setReportingWd()
knitrGlobalConfig()
setEnvVars()

# Env vars
# DB_HOST  = Sys.getenv('DB_HOST')
# DB_PORT  = as.numeric(Sys.getenv('DB_PORT'))
# DB_NAME  = Sys.getenv('DB_NAME')
# DB_UNAME = Sys.getenv('DB_UNAME')
# DB_PWORD = Sys.getenv('DB_PWORD')
# connectToAnalyticsDB()

# Load code
dirs <- c( 'extract', 'load', 'transform', 'graphs', 'lib', 'data' )
lapply( dirs, loadDir )
source( './reports/run.R' )

# No scientific notation
options( scipen = 999 )

Quandl.auth( Sys.getenv( 'QUANDL' ) )
