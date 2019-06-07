'use strict';

import CONST from '../constants/';
import $ from 'jquery';

export default function smoothSlide() {

    'use strict';

    const HEADER_HEIGHT = 60;

    let $document = CONST.$document;

    let mStopOn = () => {
        $document.on('DOMMouseScroll', preventDefault);
        $document.on('mousewheel', preventDefault);
    };

    let mStopOff = () => {
        $document.off('DOMMouseScroll', preventDefault);
        $document.off('mousewheel', preventDefault);
    };

    let preventDefault = (event) => {
        event.preventDefault();
    };

    let handleClick = (e) => {
        if (!$(e.currentTarget).hasClass('nolink')) {
            let id = $(e.currentTarget).attr('href'),
                target = $(id).offset().top;
            mStopOn();
            CONST.$htmlBody.animate({scrollTop: target - HEADER_HEIGHT}, 500, mStopOff);
            e.preventDefault();
        }
    };

    $('a.js-scroll').on('click', handleClick);
}