#!/usr/bin/env node
(function(){
  var suuid, nots;
  suuid = require("../dist/index");
  nots = in$('--nots', process.argv.slice(2));
  console.log(suuid(nots ? {
    timestamp: false
  } : void 8));
  function in$(x, xs){
    var i = -1, l = xs.length >>> 0;
    while (++i < l) if (x === xs[i]) return true;
    return false;
  }
}).call(this);
