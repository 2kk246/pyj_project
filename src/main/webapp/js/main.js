(function () {
  new WOW().init();

  /* Navigation Bar*/
  const toggleBtn = document.querySelector(".navbar_toggleBtn");
  const menu = document.querySelector(".navbar_menu");

  toggleBtn.addEventListener("click", () => {
    menu.classList.toggle("active");
  });

  const menuList = document.querySelectorAll(".navbar_menu li");
  for (const element of menuList) {
    element.addEventListener("click", () => {
      element.classList.add("active");
      for (const other of menuList) {
        if (other !== element) {
          other.classList.remove("active");
        }
      }
    });
  }

})();
