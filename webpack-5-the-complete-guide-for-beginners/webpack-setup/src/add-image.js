import Kiwi from './kiwi.jpg'

function addImage() {
  console.log("adding image")
  const img = document.createElement('img');
  img.alt = 'Kiwi';
  img.width = 300;
  img.src = Kiwi
  const body = document.querySelector('body');
  body.appendChild(img);
  console.log('image added', img, body)
}

export default addImage;
