const jsonServer = require('json-server')

const server = jsonServer.create()

server.use((req, res, next) => {
    res.header('Access-Control-Allow-Origin', '*')
    res.header('Access-Control-Allow-Headers', 'Origin, X-Requrest-With, Content-Type, Accept')
    next()
})

var router = jsonServer.router('db.json')
server.use(router)

console.log('Listeining at 3000')
server.listen(3000)
