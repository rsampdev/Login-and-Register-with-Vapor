import Vapor

let drop = Droplet()

try load(drop)

print(drop.workDir)

drop.run()
