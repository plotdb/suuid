(function(){
  var uuidGen, sep, base62map, log62, zeroes, enc, dec, obj;
  uuidGen = require("uuid").v4;
  sep = '';
  base62map = "0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz";
  log62 = Math.log2(62);
  zeroes = "000000000";
  enc = function(s, pad){
    var n, r;
    n = typeof s === 'string' ? parseInt(s, 16) : s;
    r = "";
    while (n !== 0) {
      r = base62map[n % 62] + r;
      n = Math.floor(n / 62);
    }
    if (pad) {
      r = (zeroes + r).slice(-pad);
    }
    return r;
  };
  dec = function(s){
    var n;
    n = s.split('').reduce(function(acc, c){
      return acc * 62 + base62map.indexOf(c);
    }, 0);
    return n.toString(16);
  };
  obj = function(u){
    var ref$, opt, ret;
    if (typeof u === 'object') {
      ref$ = [u.id, u], u = ref$[0], opt = ref$[1];
    } else {
      opt = {};
    }
    if (!(opt.timestamp != null)) {
      opt.timestamp = true;
    }
    if (!u) {
      u = uuidGen().toLowerCase();
    }
    ret = u.split('-').map(function(d, i){
      return enc(d, Math.ceil(d.length * 4 / log62));
    }).join(sep);
    ret = (opt.timestamp ? enc(Date.now()) : '') + sep + ret;
    return ret;
  };
  obj.timestamp = function(u){
    return parseInt(dec(u.substring(0, u.length - 24)).replace(/^0+/, ''), 16);
  };
  obj.encode = function(s){
    return enc(s, Math.ceil(s.length * 4 / log62));
  };
  module.exports = obj;
}).call(this);
