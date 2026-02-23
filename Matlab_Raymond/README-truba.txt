# File: README.txt
#
#  Instructions for installing on-cluster MATLAB Support Package
#

Version: R2025b
Date: 2026-02-08

1. Description of files

  . Getting_Started_With_Serial_And_Parallel_MATLAB.docx : User Guide to be
       posted on internal wiki page.
  . truba.Cluster.zip : MATLAB scripts for submitting on-prem Slurm jobs.
       To be installed on TRUBA in the root MATLAB directory (e.g., /arf/sw/apps/matlab)
  . tubitak.Desktop.zip : MATLAB scripts for submitting remote Slurm
       jobs.  To be posted on internal wiki page.


2. Installation

  unzip truba.Cluster.zip -d /arf/sw/apps/matlab


3. Update *each* MATLAB module file (e.g., /arf/sw/modulefiles/apps/matlab/R2025b)

LUA
===
  local SUPPORT_PACKAGES = "/arf/sw/apps/matlab/support_packages"
  local MATLAB_CLUSTER_PROFILES_LOCATION = pathJoin(SUPPORT_PACKAGES,"matlab_parallel_server/scripts")
  setenv("MATLAB_CLUSTER_PROFILES_LOCATION", MATLAB_CLUSTER_PROFILES_LOCATION)

  append_path("PATH", pathJoin(SUPPORT_PACKAGES,"matlab_parallel_server/bin"))
  prepend_path("MATLABPATH", MATLAB_CLUSTER_PROFILES_LOCATION)

TCL
===
  set SUPPORT_PACKAGES                  /arf/sw/apps/matlab/support_packages
  set MATLAB_CLUSTER_PROFILES_LOCATION  $SUPPORT_PACKAGES/matlab_parallel_server/scripts

  append-path   PATH                    $SUPPORT_PACKAGES/matlab_parallel_server/bin
  prepend-path  MATLABPATH              $MATLAB_CLUSTER_PROFILES_LOCATION
  prepend-path  MATLAB_CLUSTER_PROFILES_LOCATION $MATLAB_CLUSTER_PROFILES_LOCATION
