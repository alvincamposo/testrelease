import $ from 'jquery';

module.exports = {
	$window: $(window),
    $document: $(document),
    $html: $('html'),
    $body: $('body'),
    $htmlBody: $('html, body'),
    $this: $(this),
    ACTIVE_CLASS: 'is-active',
    OPEN_CLASS: 'is-open',
    DURATION: 2000,
    HEADER_HEIGHT: 60,
    JS_NAV_LINK: '#js-nav',
    JS_NAV_LINK: '#js-nav-link'
};