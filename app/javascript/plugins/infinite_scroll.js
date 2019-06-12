var InfiniteScroll = require('infinite-scroll');

const infiniteScroll = (elem) => {
  const scroll = document.querySelector(elem);
  const infScroll = new InfiniteScroll( scroll, {
    path: '.pagination__next',
    append: '.post',
    history: false,
  });
}


export { infiniteScroll };
