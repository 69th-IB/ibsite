// Configure your import map in config/importmap.rb. Read more: https://github.com/rails/importmap-rails
import "@hotwired/turbo-rails"
import "channels"
import "controllers"
import "trix"
import "@rails/actiontext"

import jstz from "jstz";
const time_zone = jstz.determine();
document.cookie = "time_zone=" + time_zone.name() + "; Path=/; SameSite=Strict; Secure";
