var fs=require("fs");
var mustache = require("mustache");
let size = parseInt(process.argv[2]);


console.log("Automatically generating matrix of size " +size)

//Build the matrix
var matrixVals = [];
for(i=0; i<size; i++){
 	var row = [];
	for(j=0; j<size; j++){
		row.push(Math.floor(Math.random()*3));	
	}
	matrixVals.push(row);
}


//Build the bend program
var mat = "  mat = [\n"
for(i =0; i< size; i++)
{
	mat += "     ["
	for(j=0; j< size; j++){
		entry = matrixVals[i][j];
		let plus = (entry <0) ? "" : "+";
                mat += " " + plus +entry +", "
	}
	mat += "],\n"
}
mat += "  ]\n"
let data = {};
data.mat = mat;
data.size = size;
var tpl = fs.readFileSync("./bend/det.tpl", "utf8");
let finalBendProg = mustache.render(tpl, data);
fs.writeFileSync("./bend/det.bend", finalBendProg);

//Build the single threaded go program(s)
var mat = "var matrix = [][]int{"
for(i =0; i< size; i++)
{
	mat += "\n    {"
	for(j=0; j< size; j++){
		mat += matrixVals[i][j] +", "
	}
	mat += "},"
}
mat +="\n}"
data.mat = mat;
tpl = fs.readFileSync("./go_single/main.tpl", "utf8");
let finalGoSingleProg = mustache.render(tpl, data);
fs.writeFileSync("./go_single/main.go", finalGoSingleProg);

//And just resue above for multi threaded go
tpl = fs.readFileSync("./go_multi1/main.tpl", "utf8");
let finalGoMulti1Prog = mustache.render(tpl, data);
fs.writeFileSync("./go_multi1/main.go", finalGoMulti1Prog);

//And just resue above for multi threaded go
tpl = fs.readFileSync("./go_multi2/main.tpl", "utf8");
let finalGoMulti2Prog = mustache.render(tpl, data);
fs.writeFileSync("./go_multi2/main.go", finalGoMulti2Prog);


