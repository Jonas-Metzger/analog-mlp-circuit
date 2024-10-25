# Use the spack/ubuntu-focal image as the base image
FROM spack/ubuntu-focal

# Set environment variables for Spack
#SHELL ["/bin/bash", "-c"]
ENV SPACK_ROOT=/opt/spack
#ENV SPACK_ENV_COMPILER_JOBS=2

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
    spack install -j2 xyce

RUN pip install torch numpy pyspice matplotlib tqdm

RUN echo "source /opt/spack/share/spack/setup-env.sh" >> ~/.bashrc

RUN echo "spack load xyce" >> ~/.bashrc

RUN mkdir /root/analog-mlp-circuit

# Ensure Spack environment and conda environment are activated in the container
ENTRYPOINT ["/bin/bash"]
CMD []

