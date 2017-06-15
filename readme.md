# ASP.NET Core in a Container

Here's a simple example for getting an ASP.NET Core project running in a Docker container.

This was created to teach the core concepts of Docker.

Definitions:
- **Dockerfile**: A manifest file that describes your Docker Image.
- **Docker Image**: The output of a build of your Dockerfile. Use `docker build` command to create a Docker Image.
- **Docker Container**: An runtime instance of your Docker Image. Use `docker run` to start a new container instance.

## Pre-reqs

1. Install **.NET Core SDK**: https://www.microsoft.com/net/core#windowscmd
2. Install **Docker**: https://docs.docker.com/engine/installation/
- If you are running Windows, [switch to Windows containers](https://docs.docker.com/docker-for-windows/#switch-between-windows-and-linux-containers).

## Just Run the Sample
To just run the sample: 
1. Clone this repo
2. Run `build.cmd` in the root.
> The `build.cmd` file will build the aspnetcore project, copy the output to ./publish folder, build the Docker Image and run the Docker Container.

3. Copy and Paste the outputted IP address into a browser.  



You will see "Hello World" - an ASP.NET Core site hosted in a container!

## Build the Sample from Scratch
Follow these instructions to create this sample from scratch.

### 1. Create New Folder

Open a command prompt and execute the following:

```
mkdir aspnetcorecontainer
```

### 2. Create New Core Web Project

```
dotnet new web
```

### 3. Restore Dependencies
```
dotnet restore
```

### 4. Run Site
```
dotnet run
```

### 5. Load Site

[http://localhost:5000](http://localhost:5000)

### 6. Create Dockerfile

This will use the aspnetcore image and copy the files from publish to the /app directory and then configure the dotnet entrypoint to the dll.

```
FROM microsoft/aspnetcore
WORKDIR /app
COPY ./publish .
ENTRYPOINT ["dotnet", "aspnetcorecontainer.dll"]
```

### 7. Build and Publish Site
```
dotnet build
dotnet publish -o ./publish
```

### 8. Build Container Image
```
docker build -t aspnetcore-image .
```

### 9. Run Container
```
docker run -d -p 8000:80 --name aspnetcore-container aspnetcore-image
```

### 10. Get Container IP Address
```
docker inspect -f "{{ .NetworkSettings.Networks.nat.IPAddress }}" aspnetcore-container
```

### 11. Load Site

Load the IP address returned in the previous step in a browser

## Clean Up

Execute the following command to remove the container before you re-run these steps.

```
docker rm /aspnetcore-container -f
```
