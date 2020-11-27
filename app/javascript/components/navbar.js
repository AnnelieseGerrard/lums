const navChange = () => {
  if ( (window.location.pathname != "/#") && !(window.location.pathname != "/") || (window.location.pathname != "/") && !(window.location.pathname != "/#") ) {
    const elements = document.getElementsByTagName("nav");
    const elements_array = Array.from(elements);
    elements_array.forEach(element => element.style.backgroundColor = "transparent");
  };
};


const checkScroll = () => {
  if ( (window.location.pathname === "/") || (window.location.pathname === "/#") ) {
    const myNav = document.getElementsByTagName("nav");
    const myNav_array = Array.from(myNav);
    window.onscroll = function () {
      "use strict";
      if (document.body.scrollTop >= 1 || document.documentElement.scrollTop >= 200) {
          myNav_array[0].classList.add("nav-scrolled");
      }
      else {
        myNav_array[0].classList.remove("nav-scrolled");
      }
    };
  };
};

export { navChange, checkScroll };
