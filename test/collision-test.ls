require! <[../dist/suuid]>
hash = {}
count = 0
total = +process.argv.2 or 1000
for i from 0 til total
  id = suuid!
  if hash[id] =>
    count++
    console.log "collide ( #id ) #count"
  hash[id] = true

console.log "total collision: #{count}, percentage: #{100 * count / total}%"
