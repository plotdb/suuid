{v4: uuid-gen} = require "uuid"

sep = ''
base62map = "0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz"
log62 = Math.log2 62
zeroes = "000000000"

enc = (s, pad) ->
  n = if typeof s == \string => parseInt(s, 16) else s
  r = ""
  until n == 0
    r = base62map[n % 62] + r
    n = Math.floor(n / 62)
  if pad => r = (zeroes + r).slice(-pad)
  r

dec = (s) ->
  n = s.split('').reduce ((acc, c) -> acc * 62 + base62map.indexOf(c)), 0
  n.toString(16)

obj = (u) ->
  if typeof(u) == \object => [u,opt] = [u.id, u] else opt = {}
  if !(opt.timestamp?) => opt.timestamp = true
  if !u => u = uuid-gen!toLowerCase!
  ret = u.split(\-).map((d,i) ~> enc(d, Math.ceil(d.length * 4 / log62))).join(sep)
  ret = (if opt.timestamp => enc(Date.now!) else '') + sep + ret
  ret

obj.timestamp = (u) -> parseInt(dec(u.substring(0, u.length - 24)).replace(/^0+/,''), 16)
obj.encode = (s) -> enc(s, Math.ceil(s.length * 4 / log62))

module.exports = obj
