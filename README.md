#Bend Benchmaking
This is some sample code used for benchmaking the Bend programming language and the HVM runtime. There are implementaitons of the same algorithm written in Go that for comparision purposed. 

All of the sample programs calulate the determinant of a matrix. The code is actually all template files, and the matrix needs to be specifed by running the nodejs code provided. 

##Build
First make sure you have nodejs and npm installed as well the the Go and Bend runtimes. Then from the root of the project get all the necessary NPM pakcages
```
npm install
```

Then create the Bend and Go programs from the templates. For a 3x3 matrix you woudl run
```
node ./build.js 3
```

#Run 
For the Bend version, go into the bend subdirectory and run this to get the runtime for the single threaded version
```
time bend run det.bend
```
And this for the Multi threaded version
```
time bend run-c det.bend
```
To run the go exampels, enter their subdirectories and run 
```
time go run ./main.go
```

