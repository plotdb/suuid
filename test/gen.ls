suuid = require '../dist/index'
ret = suuid!
console.log "generated suuid: #ret"
console.log "timestamp: #{suuid.timestamp(ret)} ( #{new Date(suuid.timestamp(ret))} )" 

