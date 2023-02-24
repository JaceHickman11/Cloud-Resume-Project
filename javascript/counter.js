let count = localStorage.getItem('pageCount');

if (!count) {
  count = 0;
}

count++;
localStorage.setItem('pageCount', count);

let counterElement = document.getElementById('counter');
counterElement.innerText = 'Page views: ' + count;
