import $ from 'jquery';

export default function navIndicator() {

	let lastId,
		topMenu = $(".nav-list"),
		menuItems = topMenu.find("a"),
		// Anchors corresponding to menu items
		scrollItems = menuItems.map(function(){
			let item = $($(this).attr("href"));
			if (item.length) { return item; }
			return item;
		});

	// Bind to scroll
	$(window).scroll(function(){
		// Get container scroll position
		let fromTop = $(this).scrollTop();

		// Get id of current scroll item
		let cur = scrollItems.map(function(){
			if ($(this).offset().top - 110 < fromTop)
			return this;
		});

		// Get the id of the current element
		cur = cur[cur.length-1];

		let id = cur && cur.length ? cur[0].id : "";

		if (lastId !== id) {
		lastId = id;
		// Set/remove active class
		menuItems
		.parent().removeClass("is-active")
		.end().filter("[href='#"+id+"']").parent().addClass("is-active");
		}
	});
	
}
