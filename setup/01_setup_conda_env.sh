#!/usr/bin/env bash

# build leafmap based Python environment for workshop notebooks

# --------------------------------------------------------------------------------------------------------------------

ENV_NAME=geoworkshop
PYTHON_VERSION="3.11"

# Note: If you want to install QGIS via Conda - it only supports up to Python 3.9

# --------------------------------------------------------------------------------------------------------------------

echo "-------------------------------------------------------------------------"
echo "Creating new Conda Environment '${ENV_NAME}'"
echo "-------------------------------------------------------------------------"

# deactivate current environment and start base env (in case you just deactivated it) - lazy method
conda deactivate
conda activate base

# WARNING - removes existing environment
conda env remove --name ${ENV_NAME}

# update Conda base environment
conda update -y conda

# Create Conda environment
conda create -y -n ${ENV_NAME} python=${PYTHON_VERSION}

# activate and setup env
conda activate ${ENV_NAME}
conda config --env --add channels conda-forge
conda config --env --set channel_priority strict

# reactivate for env vars to take effect
conda activate ${ENV_NAME}

# install geospatial packages and restart env
conda install -y geopandas
conda install -y -c conda-forge mamba
mamba install -y -c conda-forge leafmap=0.23.4 sqlalchemy psycopg2
#conda install -y -c conda-forge leafmap geopandas localtileserver keplergl pydeck sqlalchemy psycopg jupyter_contrib_nbextensions
conda activate ${ENV_NAME}

## additional package requiring pip
#pip install psycopg_pool

# clear cache (builds over time)
conda clean -y --all
