FROM gvgramazio/gym:latest

RUN apt-get update


# Download V-REP v3.5 from the official website
RUN sudo apt-get install -y wget
RUN wget http://coppeliarobotics.com/files/V-REP_PRO_EDU_V3_5_0_Linux.tar.gz
RUN tar -xf V-REP_PRO_EDU_V3_5_0_Linux.tar.gz

# Install V-REP dependecies
RUN sudo apt-get install -y \
  libglib2.0-0  \
  libgl1-mesa-glx \
  xcb \
  "^libxcb.*" \
  libx11-xcb-dev \
  libglu1-mesa-dev \
  libxrender-dev \
  libxi6 \
  libdbus-1-3 \
  libfontconfig1

# Export paths
RUN echo 'export QT_DEBUG_PLUGINS=1' >> ~/.bashrc
RUN echo 'export PATH=/V-REP_PRO_EDU_V3_5_0_Linux/:$PATH' >> ~/.bashrc

# Install python3 and python packages
RUN sudo apt-get install -y git python3 python3-pip
RUN python3 -m pip install numpy matplotlib psutil

# Download vrepper
RUN git clone https://github.com/gvgramazio/vrepper.git
RUN python3 -m pip install -e vrepper

# Install xvfb to emulates a dumb framebuffer using virtual memory.
RUN apt-get install -y xvfb

# Download gym-foosball
RUN git clone https://gitlab.com/gvgramazio/gym-foosball.git
RUN python3 -m pip install -e gym-foosball

# Download keras-rl
RUN git clone https://github.com/gvgramazio/keras-rl.git
RUN python3 -m pip install -e keras-rl
