#!/bin/bash

# This bash script should be run ONCE only.
# The script setups tljh for use in a classroom environment, installing addtional packages.
# Scipt tested with SSH through the terminal.

# We add /opt/tljh/user/bin to the $PATH environment variable for all JupyterHub users,
# so everything installed in the user environment is available to them automatically.
export PATH=/opt/tljh/user/bin:${PATH}


# When using sudo, the PATH environment variable is usually reset, for security reasons.
# Using "PATH=$PATH" makes sure that the PATH is preserved in sudo mode. Here we install
# nbgrader.
sudo env "PATH=$PATH" conda install -c conda-forge nbgrader


# Debug: check that the permissions are correct
# sudo useradd nbgrader
# sudo mkdir /home/nbgrader
# sudo mkdir /home/nbgrader/courses
# sudo mkdir /home/nbgrader/courses/test
# sudo chown -R nbgrader:nbgrader nbgrader/
# sudo chmod -R 700 /home/nbgrader

# Setup exchange folder for nbgrader
sudo mkdir /srv/nbgrader
sudo mkdir /srv/nbgrader/exchange
sudo chmod ugo+rw /srv/nbgrader/exchange

# Debug: test with -y flag
# Install nbgrader and enable all extensions(assignment list, create assignment, formgrader and validate).
# NOTE: Reboot system if formgrader is not working properly after installation.
sudo env "PATH=$PATH" conda install -y -c conda-forge nbgrader
sudo env "PATH=$PATH" jupyter nbextension install --sys-prefix --py nbgrader --overwrite
sudo env "PATH=$PATH" jupyter nbextension enable --sys-prefix --py nbgrader
sudo env "PATH=$PATH" jupyter serverextension enable --sys-prefix --py nbgrader
