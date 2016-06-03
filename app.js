#!/usr/bin/env node

var fs = require('fs'),
    path = require('path');

var project_path = path.dirname(fs.realpathSync(__filename));

require('dotenv').config({path: project_path + '/.env'});

require('slackin').default({
  token: process.env.TOKEN,
  interval: 1000,
  org: process.env.ORG,
  path: project_path,
  silent: true
}).listen(3000);