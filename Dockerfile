FROM ubuntu:16.04
MAINTAINER Erwan KESSLER

# Build with `sudo docker build -t <imageName> -f Dockerfile .`
ENV HOME /root

RUN apt update
RUN apt -yq install gcc \
		    gfortran \
		    build-essential \
		    wget \
		    tar \
		    vim \
		    gedit \
		    m4
RUN 	LOCALDIR=/usr/local; \
    	CC=/usr/bin/gcc; \
	FC=/usr/bin/gfortran

#Build ZLIB

RUN	wget http://zlib.net/zlib-1.2.11.tar.gz; \
	tar xvf zlib-1.2.11.tar.gz; \
	cd zlib-1.2.11/; \
	./configure --prefix=${LOCALDIR}; \
	# make check; \
	make install; \
	cd ..; \
	rm -rf /zlib-1.2.11.tar.gz /zlib-1.2.11

#Build CURL

RUN	wget https://curl.haxx.se/download/curl-7.65.3.tar.gz; \
	tar xvf curl-7.65.3.tar.gz; \
	cd curl-7.65.3/; \
	./configure --prefix=${LOCALDIR}; \
	# make check -j 8; \
	make install; \
	cd ..; \
	rm -rf /curl-7.65.3.tar.gz /curl-7.65.3

#Build HDF5 with fortran

RUN	wget https://support.hdfgroup.org/ftp/HDF5/releases/hdf5-1.10/hdf5-1.10.5/src/hdf5-1.10.5.tar.gz; \
	tar xvf hdf5-1.10.5.tar.gz; \
	cd hdf5-1.10.5/; \
	./configure --with-zlib=${LOCALDIR} --prefix=${LOCALDIR} --enable-hl --enable-fortran; \
	# make check -j 8; \
	make install; \
	cd ..; \
	rm -rf /hdf5-1.10.5.tar.gz /hdf5-1.10.5

#Build NETCDF

RUN	wget ftp://ftp.unidata.ucar.edu/pub/netcdf/netcdf-4.5.0.tar.gz; \
	tar xvf netcdf-4.5.0.tar.gz; \
	cd netcdf-4.5.0/; \
	export LD_LIBRARY_PATH=${LOCALDIR}/lib; \
	CPPFLAGS=-I${LOCALDIR}/include LDFLAGS=-L${LOCALDIR}/lib ./configure --prefix=${LOCALDIR}; \
	# make check; \
	make install; \
	cd ..; \
	rm -rf /netcdf-4.5.0.tar.gz /netcdf-4.5.0

RUN 	nc-config --cc

RUN	wget ftp://ftp.unidata.ucar.edu/pub/netcdf/netcdf-fortran-4.4.4.tar.gz; \
	tar xvf netcdf-fortran-4.4.4.tar.gz; \
	cd netcdf-fortran-4.4.4/; \
	CPPFLAGS=-I${LOCALDIR}/include LDFLAGS=-L${LOCALDIR}/lib ./configure --prefix=${LOCALDIR}; \
	# make check; \
	make install; \
	cd ..; \
	rm -rf netcdf-fortran-4.4.4.tar.gz netcdf-fortran-4.4.4

RUN 	nc-config --fc
RUN	{ nc-config --cc; nc-config --fc; } | tr "\n" " "





