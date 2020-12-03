// ——————————————————————————————————————————————————
// navChange
// ——————————————————————————————————————————————————

const navChange = () => {
  if ( (window.location.pathname === "/") || (window.location.pathname === "/#") ) {
  //if ( (window.location.pathname != "/#") && !(window.location.pathname != "/") || (window.location.pathname != "/") && !(window.location.pathname != "/#") ) {
    const elements = document.getElementsByTagName("nav");
    const elements_array = Array.from(elements);
    elements_array.forEach(element => element.style.backgroundColor = "transparent");
    elements_array.forEach(element => element.style.boxShadow = "none");
  };
};

// ——————————————————————————————————————————————————
// smoothScroll
// ——————————————————————————————————————————————————

const smoothScroll = () => {
  const scrollLink = document.querySelectorAll(".scroll-target");
  if (scrollLink) {
  scrollLink.forEach(item => {
    item.addEventListener('click', event =>{
      const scrollHTML =  item.innerText.toLowerCase();
      const scrollText = `${scrollHTML}-scroll`;
      const scrollTarget = document.getElementById(scrollText);
      scrollTarget.scrollIntoView({
        block: 'start',
        behavior: 'smooth'
        });
      });
    })
  };
}



// ——————————————————————————————————————————————————
// checkScroll
// ——————————————————————————————————————————————————

const checkScroll = () => {
  if ( (window.location.pathname === "/") || (window.location.pathname === "/#") ) {
    const myNav = document.getElementsByTagName("nav");
    const myNav_array = Array.from(myNav);
    window.onscroll = function () {
      "use strict";
      if (document.body.scrollTop >= 1 || document.documentElement.scrollTop >= 250) {
          myNav_array[0].classList.add("nav-scrolled");
      }
      else {
        myNav_array[0].classList.remove("nav-scrolled");
      }
    };
  };
};

export { navChange, checkScroll, smoothScroll };
