import axios from 'axios'

const instance = axios.create({
    baseURL: 'https://react-burger-builder-b3309.firebaseio.com'
})

export default instance 