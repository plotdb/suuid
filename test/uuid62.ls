{v4: uuid-gen} = require "uuid"
# this code convert uuid (as input of encode) to a base-62 string, in 23 bytes.
# the returned code doesn't contain dot `.` and underline `_`,
# which is prettier and prevent from some potential issues regarding `.`
base62 = "0123456789abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ"
decode = (s = "") ->
  [s.substring(0,9), s.substring(9,14), s.substring(14)]
    .map (t,j) ->
      v = 0
      for i from 0 til t.length => v = v * 62 + base62.indexOf(t[i])
      len = [13,6,13][j] #Math.ceil((Math.log(62) * t.length) / Math.log(16))
      code = ""
      for i from 0 til len
        r = v % 16
        code = "#{(r).toString(16)}#code"
        v = (v - r) / 16
      code
    .join(' ')

encode = (s = "") ->
  s = s.replace(/-/g,'')
  [s.substring(0,13), s.substring(13,19), s.substring(19)]
    .map (t) ->
      v = 0
      for i from 0 til t.length => v = v * 16 + parseInt(t[i], 16)
      len = Math.ceil((Math.log(16) * t.length) / Math.log(62))
      code = ""
      for i from 0 til len
        r = v % 62
        code = "#{base62.charAt(r)}#code"
        v = (v - r) / 62
      code
    .join('')

uuid = uuid-gen!
encoded = encode(uuid)
decoded = decode(encoded)
console.log "uuid: ", uuid
console.log "encoded: ", encoded
console.log "decoded: ", decoded
