const fs = require('fs');
fs.writeFileSync('./default-evn.json',process.env.VCAP_SERVICES);