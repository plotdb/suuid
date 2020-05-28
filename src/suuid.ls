(->
  if module? => {v4: uuid-gen} = require "uuid" else uuid-gen = uuid
  hsh = {}
  map = "123456789ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz+-$".split('');
  sep = "0"
  for i from 0 til map.length => hsh[map[i]] = i
  enc = (v) ->
    r = ''
    while true
      r = map[v .&. 0x3f] + r
      v = v .>>>. 6
      if !v => break
    return r
  dec = (s) ->
    r = 0
    for i from 0 til s.length
      r = (r .<<. 6) + hsh[s[i]]
    return r

  obj = (u) ->
    if !u => u = uuid-gen!
    u.split(\-).map(~> enc(parseInt(it, 16))).join(sep)

  if module? => module.exports = obj
  if window? => window.suuid = obj
)!
