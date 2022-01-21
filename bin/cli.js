#!/usr/bin/env node
(function(){
  var suuid;
  suuid = require('../dist/suuid');
  console.log(suuid());
}).call(this);
