const navChange = () => {
  if ( (window.location.pathname != "/#") && !(window.location.pathname != "/") || (window.location.pathname != "/") && !(window.location.pathname != "/#") ) {
    const elements = document.getElementsByTagName("nav");
    const elements_array = Array.from(elements);
    elements_array.forEach(element => element.style.backgroundColor = "transparent");
  };
};
export { navChange };
