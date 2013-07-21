
var App = require('./app');
require('source-map-support').install();

app = new App();
app.routes();
app.start();
