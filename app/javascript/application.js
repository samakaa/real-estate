//= require jquery
//= require jquery_ujs
//= require bootstrap
//= require rails-ujs
//= require_tree ./custom




import "controllers";
import "custom";
import "@fortawesome/fontawesome-free/css/all";
import "custom/main";
import 'bootstrap';  // Assuming Bootstrap is already included

import Rails from "@rails/ujs";
Rails.start();


import toastr from "toastr";
import "toastr/build/toastr.min.css";


toastr.options = {
  "closeButton": true,
  "progressBar": true,
  "positionClass": "toast-bottom-right",
  "timeOut": "5000",
  "extendedTimeOut": "1000",
  "showDuration": "300",
  "hideDuration": "1000",
  "showMethod": "fadeIn",
  "hideMethod": "fadeOut"
};

toastr.success("Signed in successfully");
document.addEventListener("DOMContentLoaded", function () {
  // Toggle visibility for password field
  const showPass = document.querySelector(".show-pass");
  const passwordField = document.querySelector(".password-field");

  if (showPass && passwordField) {
    showPass.addEventListener("click", () => {
      if (passwordField.type === "password") {
        passwordField.type = "text";
      } else {
        passwordField.type = "password";
      }
      showPass.classList.toggle("active");
    });
  }

  // Toggle visibility for confirm password field
  const showPass2 = document.querySelector(".show-pass2");
  const passwordField2 = document.querySelector(".password-field2");

  if (showPass2 && passwordField2) {
    showPass2.addEventListener("click", () => {
      if (passwordField2.type === "password") {
        passwordField2.type = "text";
      } else {
        passwordField2.type = "password";
      }
      showPass2.classList.toggle("active");
    });
  }
});
// Toggle mobile menu
document.addEventListener("DOMContentLoaded", function () {
  const mobileMenu = document.querySelector(".mobile-menu");
  const closeBtn = document.querySelector(".close-btn");

  // Open the mobile menu
  document.querySelector(".menu-toggle").addEventListener("click", function () {
    mobileMenu.classList.add("active");
  });

  // Close the mobile menu
  closeBtn.addEventListener("click", function () {
    mobileMenu.classList.remove("active");
  });
});

