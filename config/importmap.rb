# Pin npm packages by running ./bin/importmap

pin "application"
pin "@rails/ujs", to: "rails-ujs.js"

pin "@hotwired/stimulus", to: "stimulus.min.js"
pin "@hotwired/stimulus-loading", to: "stimulus-loading.js"
pin_all_from "app/javascript/controllers", under: "controllers"
pin "animation_heading", to: "custom/animation_heading.js"
pin "custom/main", to: "custom/main.js"
