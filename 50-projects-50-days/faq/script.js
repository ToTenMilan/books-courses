const faqs = document.querySelectorAll('.faq')

faqs.forEach((faq) => {
  faq.addEventListener('click', () => {
    if (faq.classList.contains('active')) {
      faq.classList.remove('active');
    } else {
      faq.classList.add('active');
    }
  })
})


// const  toggles = document.querySelectorAll('.faq-toggle')

// toggles.forEach(toggle => {
//   toggle.addEventListener('click', () => {
//     toggle.parentNode.classList.toggle('active')
//   })
// })
