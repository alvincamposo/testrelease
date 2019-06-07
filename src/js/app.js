import ScrollMagic from 'scrollmagic';

if (process.env.NODE_ENV === 'development') {
  console.debug('development');
}

import smoothSlide from './components/smooth-slide';
smoothSlide();

import osBrowser from './components/os-browser';
osBrowser();

import navIndicator from './components/nav-indicator';
navIndicator();


let controller = new ScrollMagic.Controller();

// ScrollMagic

/*Quote*/
new ScrollMagic.Scene ({
	triggerElement: '.js-quote',
	offset: -100
})
.setClassToggle('.js-quote-text', 'is-show')
.reverse(false)
.addTo(controller);
