(function(){
  var sep, base62map, log62, zeroes, randomBytes, ref$, hex2, uuidV4, enc, dec, obj;
  sep = '';
  base62map = "0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz";
  log62 = Math.log2(62);
  zeroes = "000000000";
  randomBytes = (typeof require != 'undefined' && require !== null) && ((ref$ = require('crypto')) != null ? ref$.randomBytes : void 8) != null
    ? function(n){
      return require('crypto').randomBytes(n);
    }
    : function(n){
      var buf;
      buf = new Uint8Array(n);
      crypto.getRandomValues(buf);
      return buf;
    };
  hex2 = function(n){
    return ("0" + n.toString(16)).slice(-2);
  };
  uuidV4 = function(){
    var b;
    b = randomBytes(16);
    b[6] = b[6] & 0x0f | 0x40;
    b[8] = b[8] & 0x3f | 0x80;
    return [
      [0, 1, 2, 3].map(function(it){
        return hex2(b[it]);
      }).join(''), [4, 5].map(function(it){
        return hex2(b[it]);
      }).join(''), [6, 7].map(function(it){
        return hex2(b[it]);
      }).join(''), [8, 9].map(function(it){
        return hex2(b[it]);
      }).join(''), [10, 11, 12, 13, 14, 15].map(function(it){
        return hex2(b[it]);
      }).join('')
    ].join('-');
  };
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
      u = uuidV4();
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
  if (typeof module != 'undefined' && module !== null) {
    module.exports = obj;
  } else {
    window.suuid = obj;
  }
}).call(this);
