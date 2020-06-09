FROM jupyter/base-notebook

USER root

RUN apt-get update && \
    apt-get install -y git \
    dotnet-sdk-3.1 \ 
    aspnetcore-runtime-3.1 \
    dotnet-runtime-3.1 \
 && apt-get clean && rm -rf /var/lib/apt/lists/*

USER $NB_UID

# install nbgitpuler && nbgrader && dotnet core

RUN conda install -c conda-forge nbgitpuller && \
    conda install -c conda-forge nbgrader && \
    jupyter serverextension enable --py nbgitpuller && \
    jupyter nbextension install --sys-prefix --py nbgrader --overwrite && \
    jupyter nbextension enable --sys-prefix --py nbgrader && \
    jupyter serverextension enable --sys-prefix --py nbgrader && \
    dotnet tool install -g dotnet-try && \
    /home/$NB_USER/.dotnet/tools/dotnet-try jupyter install 

# install nbextension push_assigment https://github/iymarch/push_assignment

RUN git clone https://github.com/iymarch/jupyter_contrib_nbextensions.git && \
    jupyter nbextension install jupyter_contrib_nbextensions/src/jupyter_contrib_nbextensions/nbextensions/push_assignment --user && \
    jupyter nbextension enable push_assignment/main --user

ENV PATH=$CONDA_DIR/bin:$PATH:/home/$NB_USER/.dotnet/tools

    
