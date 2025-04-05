// Entry point for the build script in your package.json
import "@hotwired/turbo-rails";
import "./controllers";
import "./custom/chart_time_period";

import "chartkick/chart.js";

import * as ActiveStorage from "@rails/activestorage";
ActiveStorage.start();

import "flowbite/dist/flowbite.turbo.js";
