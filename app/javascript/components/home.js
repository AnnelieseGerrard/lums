const descriptionTrigger = () => {
  const courseTop = document.querySelectorAll('.course-top');
  courseTop.forEach(item => {
    item.addEventListener('click', event => {
      const description = item.nextElementSibling;
      const chevron = item.querySelectorAll('.fa-chevron-right');
      if (description.style.display === "none") {
        description.style.display = "block";
        chevron[0].classList.add("rotate");
        // description.classList.remove("fade-out");
        // description.classList.add("fade-in");
      } else {
        // description.classList.remove("fade-in");
        // description.classList.add("fade-out");
        description.style.display = "none";
        chevron[0].classList.remove("rotate");
      };
    });
  });
};



export { descriptionTrigger };
