import React from 'react'
import ReactDOM from 'react-dom'
import PropTypes from 'prop-types'

var slideIndex = 0;
showSlides(); // call showslide method
   
function showSlides()
{
    var i;
    // get the array of divs' with classname image-sliderfade
    var slides = document.getElementsByClassName("image-sliderfade"); 
      
  
    for (i = 0; i < slides.length; i++) {
        // initially set the display to 
        // none for every image.
        slides[i].style.display = "none"; 
    }
   
     // increase by 1, Global variable
    slideIndex++; 
   
     // check for boundary
    if (slideIndex > slides.length) 
    {
        slideIndex = 1;
    }
   
    
   
    slides[slideIndex - 1].style.display = "block";
  
    // Change image every 2 seconds
    setTimeout(showSlides, 2000); 
}

