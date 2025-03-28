// Configure your import map in config/importmap.rb. Read more: https://github.com/rails/importmap-rails
import '@hotwired/turbo-rails';
import 'controllers';
import 'custom/chart_time_period';

import 'chartkick';
import 'Chart.bundle';

import LocalTime from 'local-time';
LocalTime.start();

import * as ActiveStorage from '@rails/activestorage';
ActiveStorage.start();

import 'flowbite';
