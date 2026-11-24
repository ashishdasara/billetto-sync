// Configure your import map in config/importmap.rb. Read more: https://github.com/rails/importmap-rails
import "@hotwired/turbo-rails"
import "controllers"

setTimeout(() => {
  const flash = document.querySelector('.flash');
  if (flash) {
    // slide up
    flash.style.transition = 'opacity 0.5s ease-out';
    flash.style.opacity = '0';
    setTimeout(() => {
      flash.style.display = 'none';
    }, 500);
  }
}, 4000); // 4 seconds
