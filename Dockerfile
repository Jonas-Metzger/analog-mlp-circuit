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

# Source the Spack environment
RUN . $SPACK_ROOT/share/spack/setup-env.sh && \
    spack compiler find && \
    spack install xyce && \
    spack install miniforge3

# Set the environment variables to use Spack-installed software
RUN echo "source $SPACK_ROOT/share/spack/setup-env.sh" >> ~/.bashrc

# Ensure Spack environment is activated in the container
CMD ["/bin/bash"]
