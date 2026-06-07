suuid = require "../dist/index"
nots = '--nots' in process.argv.slice(2)
console.log suuid(if nots => {timestamp: false})
