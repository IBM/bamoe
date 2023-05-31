# Build as
```
docker build -t bamoe-canvas:test1 -f Containerfile .
```
where bamoe-canvas:test1 is your custom image tag

# Start as
```
docker run -it -p8080:8080 bamoe-canvas:test1
```
where bamoe-canvas:test1 is your custom image tag


Ability to brand added in: https://github.com/kiegroup/kie-issues/issues/283