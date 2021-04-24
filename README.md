# ft_server
42 ft_server project 


# Notes

## What is web server? 
It is a software that serves web content. Web server listens on a port for request send via transport protocol and returns a response contains the requested content.
**Note:** A web server's is for static pages whereas application server is for dynamic contents.

## Sending a request to a web server
Web servers or clients( browsers) communicate via hypertext transfer protocol (HTTP). What HTTP looks like? An example is: 

```
GET /orders/123 HTTP/1.1
HOST: 127.0.0.1:8000
User-Agent: Manual-Http-Request
```
So HTTP request is just this text containing request method, target and headers. But how this http request actually send it to web server?
HTTP is only a application layer (like a language) but we need to have tranmission layer (TCP) to actually send the request to the server.

## Getting a response from the web server
Response includes; status, headers and the body. So when you open a website, let's say youtube.com, you see bunch of http responses sent by Youtube's web servers.

## Docker Notes
### Why Docker? 
Container is an isolated environment for running an application. We use it because it is secure, it will work on any machine any OS, and it is fast. I think here in this video, it explained it very well with a similar example. [!Docker Explained](https://www.youtube.com/watch?v=WoZobj2Ruj0)

Where virtual machines virtualize **hardware**, Docker virtualize **operating system**. 

### How Docker is different from VM?
With a hypervisor(VirtualBox,VMware) we can manage virtual machines. But it is slower the computer because each of the VM needs an entire OS to be loaded just like a starting a new computer. Also each VM takes a actual pyshical hardware resources. So if you have 8GB memory, that memory has to be divided into different VMs. So there is a limit how many VM we can run on our machine.

Containers allow running multiple applications in isolation as well but they are more lightweight. They don't need a full OS. All containers in a single machine share the same OS of the host. And there is no need extra harware resources for containers.

### Architecture of Docker
 Docker uses a Client-Server architecture. Server also called Docker Engine which is responsible for building and running containers. Technically a container is just a **process**. But it has own file system which is provided by the image.

Containers dont contain a full OS so containers only use the computer's OS.

![OS](/OS.PNG)

## DockerHub
It is like github to git. It's a storage for docker images that anyone can use. So one our application image is on dockerhub, then we can put it on any machines running docker. This machine has the same image we have on our development machine which contains a specific version of our application with everything it needs.

Once you finish an application, create an image of that application, send it to DockerHub and it will be accessible to everyone. You can deploy your application to anywhere like AWS or other cloud environments from there. Your coworkers get the image and build the container on their local machine which will definitely work the same as it did in your local machine regardless of their OS, packages, versions, dependencies etc.


## Building an image
A Docker image is an immutable (unchangeable) file that contains the source code, libraries, dependencies, tools, and other files needed for an application to run.  Therefore, containers are dependent on images and use them to construct a run-time environment and run an application. 
You will probably not find the exact image that you want on the dockerhub, so you need to modify/extend a base image you get from Dockerhub.
You can preferably create your own base image as well.

Docker builds images automatically by reading the instructions from a Dockerfile. (Dockerfile is like a Makefile for executing C projects).

The command for creating an image from a Dockerfile is ``docker build``.
- You can specify a different location with the file flag (-f).
- Docker looks for an existing image in its cache that it can reuse, rather than creating a new (duplicate) image. You can disable it with ``--no-cache``

## Writing the Dockerfile
The best practice for writing a Dockerfile should be to build a container that can be stopped and destroyed, then rebuilt and replaced with an absolute minimum set up and configuration. Including files that are not necessary for building an image results in a larger build context and larger image size. This can increase the time to build the image, time to pull and push it, and the container runtime size. To exclude files not relevant to the build use a .dockerignore file. 

- Don’t install unnecessary packages
- Decouple applications: Each container should have only one concern.It is more reusable and scalable. (Not applicable to ft_server project)
- RUN, COPY, ADD create layers. Make sure you minimized the number of layers in your images to ensure they were performant. (Other instructions create temporary intermediate images, and do not increase the size of the build.)
- Sort multi-line arguments alphanumerically so it is easier to read and there is no duplicate.

For more: [!Dockerfile Best Practices](https://docs.docker.com/develop/develop-images/dockerfile_best-practices/)

### Dockerfile instructions
**FROM** -- initializes a new build stage and sets the Base Image for subsequent instructions. 
**LABEL** -- labels to your image to help organize images by project.
**RUN** -- executes any commands in a new layer on top of the current image and commit the results. 

Usually we use ``RUN apt-get`` to install packages. **Always combine RUN apt-get update with apt-get install in the same RUN statement to prevent caching issues and failure of installations**. This technique is known as “cache busting”. Example: 
``RUN apt-get update && apt-get install -y \``

**CMD** --  specifies the default command to run when starting a container from the image. It provides defaults for an executing container. These defaults mostly include an executable: Usage: ``CMD ["executable","param1","param2"]``.  Or you can only give parameters to the ``ENTRYPOINT``. SHould be only one ``CMD`` in a Dockerfile or it will use the last one.

**EXPOSE** --  indicates the ports on which a container listens for connections on the runtime.
**ENV** --  sets the environment variable <key> to the value <value>. Example: 

```
ENV MY_NAME="John Doe"
ENV MY_DOG=Rex\ The\ Dog
ENV MY_CAT=fluffy
```
You can use ENV to update the PATH environment variable for the software your container installs. For example, ENV PATH=/usr/local/nginx/bin:$PATH ensures that CMD ["nginx"] just works.

**ADD or COPY** -- copies new files, directories or remote file URLs from <src> and adds them to the filesystem of the image at the path <dest>.
`COPY` is preferred. That’s because it’s more transparent than `ADD`. `COPY` only supports the basic copying of local files into the container, while `ADD` has some features (like local-only tar extraction and remote URL support) that are not immediately obvious. 

**If you have multiple Dockerfile steps that use different files from your context, COPY them individually, rather than all at once. This ensures that each step’s build cache is only invalidated (forcing the step to be re-run) if the specifically required files change.**

using `ADD` to fetch packages from remote URLs is strongly discouraged.You should use `curl` or `wget` instead.

**VOLUME** -- creates a mount point with the specified name and marks it as holding externally mounted volumes from native host or other containers. It is used to expose any database storage area, configuration storage, or files/folders created by your docker container.
**Note on Volume:**  While containers can create, update, and delete files, those changes are lost when the container is removed and all changes are isolated to that container. With volumes, we can change all of this.Volumes provide the ability to connect specific filesystem paths of the container back to the host machine.

## Ft_server
Requirements: 
-  a web server with Nginx, in only one docker container.
- The container OS must be debian buster.
- Must be able to run several services at the same time. The services will be a WordPress website, phpMyAdmin and MySQL. (*MariaDB is a drop-in replacement for MySQL.*)
**Note** Usually best practice is run multiple containers with a single service need. Then use docker-compose to combine the multiple containers. Here, for this project it will be only one container running multiple services. 
- server should be able to use the SSL protocol.
- server redirects to the correct website.
- server is running with an autoindex that must be able to be disabled.
autoindex on --> Enables Nginx auto indexing to browse your files from the web browser.

## Steps for creating the project
First I try to understand how nginx + php-fpm + mysql work together. I installed them using ubuntu terminal and tried to use them together. But if you have experienced LEPM stack before you may skip this step and build your docker container.

## What is LEMP stack?
The term LEMP is an acronym that represents the configuration of a Linux operating system with an nginx web server with site data stored in a MySQL database and dynamic content processed by PHP. 

https://www.digitalocean.com/community/tutorials/how-to-install-linux-nginx-mysql-php-lemp-stack-on-ubuntu-20-04

After understand LEMP stack and Docker, we can start working on the first DockerFile to create a web nginx web server on Debian. 

First Step:

```
FROM debian:buster

RUN apt-get update && apt-get install -y \
    nginx 
CMD ["nginx", "-g", "daemon off;"]
```

Now you should see nginx Welcome Page on the screen. 
Second step is configuring the Page.
https://www.digitalocean.com/community/tutorials/how-to-install-nginx-on-debian-10

**Note:** You can only access the files you copied inside your /tmp folder. So first copy your files into tmp folder in Dockerfile. Then do your scripts (using tmp folder) to configure pages in the shell script. 

Second Step: 
Installing and configuring the PHP.
https://www.digitalocean.com/community/tutorials/how-to-install-phpmyadmin-from-source-debian-10

Third Step:
Installing and configuring the Wordpress. 
https://wordpress.org/support/article/editing-wp-config-php/

Other configurations:
Create a SSL certificate 
https://linuxize.com/post/creating-a-self-signed-ssl-certificate/

Write a autoindex script to change autoindexing while container is running throug a shell.


### Some useful docker commands you will use throughout the project

Building:

``docker build -t ft_server .``

Run a container:

``docker run --name ft_server -d -p 443:443 -p 80:80 ft_server``

Open shell:

``docker exec -it ft_server bash``

Note: Or you can use bash command in the initial script so it automatically opens a shell.

Stop container: 

``docker kill <name>``