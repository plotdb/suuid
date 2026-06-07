sep = ''
base62map = "0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz"
log62 = Math.log2 62
zeroes = "000000000"

random-bytes = if require? and (require \crypto)?.randomBytes?
  (n) -> require(\crypto).randomBytes n
else
  (n) ->
    buf = new Uint8Array n
    crypto.getRandomValues buf
    buf

hex2 = (n) -> ("0" + n.toString(16)).slice -2

uuid-v4 = ->
  b = random-bytes 16
  b[6] = b[6] .&. 0x0f .|. 0x40
  b[8] = b[8] .&. 0x3f .|. 0x80
  [
    [0,1,2,3].map(-> hex2 b[it]).join('')
    [4,5].map(-> hex2 b[it]).join('')
    [6,7].map(-> hex2 b[it]).join('')
    [8,9].map(-> hex2 b[it]).join('')
    [10,11,12,13,14,15].map(-> hex2 b[it]).join('')
  ].join \-

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
  if !u => u = uuid-v4!
  ret = u.split(\-).map((d,i) ~> enc(d, Math.ceil(d.length * 4 / log62))).join(sep)
  ret = (if opt.timestamp => enc(Date.now!) else '') + sep + ret
  ret

obj.timestamp = (u) -> parseInt(dec(u.substring(0, u.length - 24)).replace(/^0+/,''), 16)
obj.encode = (s) -> enc(s, Math.ceil(s.length * 4 / log62))

if module? => module.exports = obj else window.suuid = obj
