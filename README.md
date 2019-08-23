# NetCDFDocker
DockerFile for NetCDF fortran

---

FOR THE FIRST TIME ONLY :

-Install Docker: `apt-get install docker.io`

-Set Docker to run : `sudo systemctl start docker`

-Enable docker : `sudo systemctl enable docker`

-First build the image with : `sudo docker build -t netcdf -f Dockerfile .`

---

MULTIPLE TIMES : 

-You can then check its build (it takes 25min approximately) with:
`sudo docker images`

-If there is an image called netcdf then congrats you have it ( you can save it locally with `docker save netcdf > netcdf.tar` and load it on any docker device with `docker load netcdf.tar`

-Then you run
`sudo docker run -e "LD_LIBRARY_PATH=/lib:/usr/lib:/usr/local/lib" --rm --name=imageNetCDF -it -v ~/netcdf:/home -p 5000:80 netcdf`
which will run an interactive console (-d for detached for background) with the folder at ~/netcdf (created if not existing) mapped to the /home folder inside the image so you can share between both easily (just drop on your machine in ~/netcdf and it will pop in /home) and with the port 5000 of your machine mapped to the port 80 on the image (so you can send data over http to your host for relay if needed)

You can then run anything in that image and even destroy it, the --rm flag make it so when you exit the image it goes back to a working state (no need of rebuilding if you messed just run the docker run command again)




