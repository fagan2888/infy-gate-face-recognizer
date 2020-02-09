#FROM python:alpine3.7
FROM python:3.7-slim
#RUN apk update && apk add \
RUN apt-get update && apt install -y --fix-missing \
  autoconf \
  automake \
  bzip2 \
#  build-base \
	build-essential \
    cmake \
    gfortran \
    git \
    wget \
    curl \
    graphicsmagick \
    libgraphicsmagick1-dev \
    libatlas-base-dev \
    libavcodec-dev \
    libavformat-dev \
    libgtk2.0-dev \
    libjpeg-dev \
    liblapack-dev \
    libswscale-dev \
    pkg-config \
  cmake \
  ccache \
  curl \
  gcc \
  git \
  libtool \
 # linux-headers \
  make \
  perl \
  strace \
  python3-dev \
  unzip \
  wget \
  zip \
  openssl \
  # dev dependencies
  git \
  bash \
  sudo 
  # Pillow dependencies
#  jpeg-dev \
#  zlib-dev \
#  freetype-dev \
#  lcms2-dev \
#  openjpeg-dev \
#  tiff-dev \
#  tk-dev \
#  tcl-dev \
#  harfbuzz-dev \
#  fribidi-dev

# Install Python packages from PyPI
RUN pip install  --no-cache-dir  --upgrade pip
COPY . /app
WORKDIR /app
#RUN pip install  --no-cache-dir  -r requirements.txt
RUN wget https://files.pythonhosted.org/packages/78/9e/c1f78f46753924ad3dc25786c3744eba0b752683dd23be527feda46a1d5e/ray-0.8.1-cp36-cp36m-manylinux1_x86_64.whl
RUN mv ray-0.8.1-cp36-cp36m-manylinux1_x86_64.whl ray-0.8.1-cp37-cp37m-manylinux1_x86_64.whl
RUN pip install  --no-cache-dir  ray-0.8.1-cp37-cp37m-manylinux1_x86_64.whl
RUN pip install  --no-cache-dir  attrs==19.3.0
RUN pip install  --no-cache-dir  Click==7.0
RUN pip install  --no-cache-dir  cloudpickle==1.2.2
RUN pip install  --no-cache-dir  colorama==0.4.3
RUN pip install  --no-cache-dir  dlib==19.19.0
RUN pip install  --no-cache-dir  face-recognition==1.2.3
RUN pip install  --no-cache-dir  face-recognition-models==0.3.0
RUN pip install  --no-cache-dir  filelock==3.0.12
RUN pip install  --no-cache-dir  Flask==1.1.1
RUN pip install  --no-cache-dir  funcsigs==1.0.2
RUN pip install  --no-cache-dir  importlib-metadata==1.5.0
RUN pip install  --no-cache-dir  itsdangerous==1.1.0
RUN pip install  --no-cache-dir  Jinja2==2.11.1
RUN pip install  --no-cache-dir  joblib==0.14.1
RUN pip install  --no-cache-dir  jsonschema==3.2.0
RUN pip install  --no-cache-dir  MarkupSafe==1.1.1
RUN pip install  --no-cache-dir  more-itertools==8.2.0
RUN pip install  --no-cache-dir  numpy==1.18.1
RUN pip install  --no-cache-dir  opencv-python==4.1.2.30
RUN pip install  --no-cache-dir  packaging==20.1
RUN pip install  --no-cache-dir  Pillow==7.0.0
RUN pip install  --no-cache-dir  pluggy==0.13.1
RUN pip install  --no-cache-dir  protobuf==3.11.2
RUN pip install  --no-cache-dir  py==1.8.1
RUN pip install  --no-cache-dir  pyparsing==2.4.6
RUN pip install  --no-cache-dir  pyrsistent==0.15.7
RUN pip install  --no-cache-dir  pytest==5.3.5
RUN pip install  --no-cache-dir  PyYAML==5.3

#RUN pip install  --no-cache-dir  ray==0.8.1

RUN pip install  --no-cache-dir  redis==3.4.1
RUN pip install  --no-cache-dir  scipy==1.4.1
RUN pip install  --no-cache-dir  six==1.14.0
RUN pip install  --no-cache-dir  wcwidth==0.1.8
RUN pip install  --no-cache-dir  Werkzeug==0.16.1
RUN pip install  --no-cache-dir  zipp==2.1.0
RUN rm -rf /var/lib/apt/lists/*
RUN rm ray-0.8.1-cp37-cp37m-manylinux1_x86_64.whl

EXPOSE 5000
CMD python ./app_server.py