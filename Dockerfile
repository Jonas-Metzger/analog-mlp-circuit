# Use the spack/ubuntu-focal image as the base image
FROM spack/ubuntu-focal

# Set environment variables for Spack
SHELL ["/bin/bash", "-c"]
ENV SPACK_ROOT=/opt/spack

# Update the image and install dependencies
RUN apt-get update && apt-get install -y \
    build-essential \
    git \
    curl \
    && rm -rf /var/lib/apt/lists/*

# Use the spack/ubuntu-focal image as the base image
FROM spack/ubuntu-focal

# Set environment variables for Spack
SHELL ["/bin/bash", "-c"]
ENV SPACK_ROOT=/opt/spack

# Update the image and install dependencies
RUN apt-get update && apt-get install -y \
    build-essential \
    git \
    curl \
    && rm -rf /var/lib/apt/lists/*

# Source the Spack environment and use binary cache as much as possible
# Use the spack/ubuntu-focal image as the base image
FROM spack/ubuntu-focal

# Set environment variables for Spack
SHELL ["/bin/bash", "-c"]
ENV SPACK_ROOT=/opt/spack

# Update the image and install dependencies
RUN apt-get update && apt-get install -y \
    build-essential \
    git \
    curl \
    && rm -rf /var/lib/apt/lists/*

# Source the Spack environment, add the correct mirror, and trust buildcache keys
RUN . $SPACK_ROOT/share/spack/setup-env.sh && \
    spack mirror add v0.22.2 https://binaries.spack.io/v0.22.2 && \
    spack buildcache keys --install --trust && \
    spack compiler find && \
    spack install --use-cache-only xyce && \
    spack install --use-cache-only miniforge3

# Add Spack-installed miniforge3 to PATH
ENV PATH="/opt/spack/opt/spack/linux-ubuntu20.04-x86_64/gcc-*/miniforge3-*/bin:$PATH"

# Create a Conda environment and install required packages (torch, numpy, pyspice, matplotlib)
RUN conda init bash && \
    conda create -n analog-mlp -y python=3.10 && \
    echo "conda activate analog-mlp" >> ~/.bashrc && \
    conda activate analog-mlp && \
    conda install -y pytorch numpy pyspice matplotlib

# Ensure Spack environment and conda environment are activated in the container
CMD ["/bin/bash"]
