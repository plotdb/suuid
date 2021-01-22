if module? => {v4: uuid-gen} = require "uuid" else uuid-gen = uuid

sep = ''
base64 = do
  map: "123456789ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0_."
  offset: 6
  padding: "000000"
base16 = do
  map: "0123456789abcdef"
  offset: 4
  padding: "0000"

convert = (s, src, des) ->
  if typeof(s) == \string =>
    bits = s
      .split ''
      .map (c) -> (src.padding + (src.map.indexOf(c)).toString(2)).slice(-src.offset)
      .reduce ((a,b) -> a + '/' + b), ''
  else bits = (s).toString(2)
  bits = bits.replace /\//g, ''
  [len,count,r] = [bits.length, Math.ceil(bits.length / des.offset), ""]
  for i from 0 til count
    idx = parseInt(bits.substring(len - ( i + 1 ) * des.offset, len - i * des.offset), 2)
    r = des.map[idx] + r
  return r

enc = (s) -> convert s, base16, base64
# not accurate - base64 leaves extra bits unused yet will be decoded as 0 in base16
dec = (s) -> convert s, base64, base16

obj = (u) ->
  if typeof(u) == \object => [u,opt] = [u.uuid, u] else opt = {}
  if !u => u = uuid-gen!toLowerCase!
  ret = u.split(\-).map((d,i) ~> enc(d)).join(sep)
  ret = enc(Date.now!) + sep + ret
  ret

obj.timestamp = (u) -> parseInt(dec(u.substring(0, u.length - 23)).replace(/^0+/,''), "16")

if module? => module.exports = obj
if window? => window.suuid = obj
