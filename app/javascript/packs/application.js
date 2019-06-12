var InfiniteScroll = require('infinite-scroll');

const scroll = document.querySelector('.infinite-scroll');
const infScroll = new InfiniteScroll( scroll, {
  path: '.next_page',
  append: '.tweet-info',
  history: false,
});

