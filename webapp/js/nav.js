function toggleMenu() {
    const sidebar = document.getElementById("sidebar");
    if (sidebar) { // Check if sidebar exists
        if (sidebar.classList.contains('visible')) {
            sidebar.classList.remove('visible');
        } else {
            sidebar.classList.add('visible');
        }
    }
}

function toggleSidebarVisibility() {
    const sidebar = document.getElementById("sidebar");
    if (sidebar && window.innerWidth >= 768) { // Check if sidebar exists and screen width is >= 768px
        sidebar.classList.add("visible");
    } else if (sidebar) { // Check if sidebar exists
        sidebar.classList.remove("visible");
    }
}

document.addEventListener("DOMContentLoaded", function () {
    const sidebarBtn = document.getElementById("sidebar-btn");
    if (sidebarBtn) { // Check if sidebarBtn exists
        toggleSidebarVisibility(); // Initial check

        sidebarBtn.addEventListener("click", function () {
            toggleMenu();
        });
    }

    window.addEventListener("resize", function () {
        toggleSidebarVisibility();
    });
});

function toggleNavbarMenu() {
    const menu = document.querySelector('.menu');
    if (menu) { // Check if menu exists
        if (menu.classList.contains('show')) {
            menu.classList.remove('show');
        } else {
            menu.classList.add('show');
        }
    }
}

document.addEventListener("DOMContentLoaded", function () {
    const navbarToggle = document.querySelector('.menu-toggle');
    if (navbarToggle) { // Check if navbarToggle exists
        navbarToggle.addEventListener("click", function () {
            toggleNavbarMenu();
        });
    }
});
