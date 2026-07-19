document.addEventListener('DOMContentLoaded', () => {
	const backToTopBtn = document.getElementById("backToTop");

	window.onscroll = function () {
		if (document.body.scrollTop > 0 || document.documentElement.scrollTop > 0) {
			backToTopBtn.style.display = "flex";
		} else {
			backToTopBtn.style.display = "none";
		}
	};

	backToTopBtn.addEventListener("click", () => {
		window.scrollTo({
			top: 0,
			behavior: "smooth"
		});
	});
});