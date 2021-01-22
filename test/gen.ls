require! <[../dist/suuid]>
ret = suuid!
console.log "generated suuid: #ret"
console.log "timestamp: #{suuid.timestamp(ret)} ( #{new Date(suuid.timestamp(ret))} )" 

