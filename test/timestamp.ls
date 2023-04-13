bytes = [7 8 9]
base = 62

console.log "with base #base: "
bytes.map (b) ->
  # bits count with `b` bytes of string in `base` base
  bc = b * Math.log(base) / Math.log(2)
  # how many years `bc` can track
  y = Math.pow(Math.E, bc * Math.log(2)) / (365.25 * 86400000)
  console.log "overflow year for #{b} bytes string: #{Math.floor(1970 + y)}AD"
