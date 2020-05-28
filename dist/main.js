// Generated by LiveScript 1.3.1
(function(){
  var uuidGen, hsh, map, sep, i$, to$, i, enc, dec, obj;
  if (typeof module != 'undefined' && module !== null) {
    uuidGen = require("uuid").v4;
  } else {
    uuidGen = uuid;
  }
  hsh = {};
  map = "123456789ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz+-$".split('');
  sep = "0";
  for (i$ = 0, to$ = map.length; i$ < to$; ++i$) {
    i = i$;
    hsh[map[i]] = i;
  }
  enc = function(v){
    var r;
    r = '';
    for (;;) {
      r = map[v & 0x3f] + r;
      v = v >>> 6;
      if (!v) {
        break;
      }
    }
    return r;
  };
  dec = function(s){
    var r, i$, to$, i;
    r = 0;
    for (i$ = 0, to$ = s.length; i$ < to$; ++i$) {
      i = i$;
      r = (r << 6) + hsh[s[i]];
    }
    return r;
  };
  obj = function(u){
    var this$ = this;
    if (!u) {
      u = uuidGen();
    }
    return u.split('-').map(function(it){
      return enc(parseInt(it, 16));
    }).join(sep);
  };
  if (typeof module != 'undefined' && module !== null) {
    module.exports = obj;
  }
  if (typeof window != 'undefined' && window !== null) {
    return window.suuid = obj;
  }
})();
