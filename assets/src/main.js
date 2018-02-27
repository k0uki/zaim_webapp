import Vue from 'vue'
import App from './App.vue'
import Vuetify from 'vuetify'
import 'vuetify/dist/vuetify.min.css'
import axios from 'axios';

Vue.use(Vuetify)

new Vue({
  el: '#app',
  render: h => h(App)
})
