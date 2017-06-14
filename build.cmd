dotnet restore
dotnet build
dotnet publish -o ./publish

docker rm /aspnetcore-container -f

docker build -t aspnetcore-image .
docker run -d -p 8000:80 --name aspnetcore-container aspnetcore-image
docker inspect -f "{{ .NetworkSettings.Networks.nat.IPAddress }}" aspnetcore-container
