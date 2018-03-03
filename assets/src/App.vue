<template>
  <v-app id="app">
   <navdrawer :drawer="drawer" />
   <v-toolbar color="indigo" dark fixed app>
       <v-toolbar-side-icon @click.stop="drawer = !drawer"></v-toolbar-side-icon>
       <v-toolbar-title>{{ msg }}</v-toolbar-title>
   </v-toolbar>
  <v-content>
    <v-container fluid fill-height>
      <v-layout justify-center align-center>
        <money-simulation />
      </v-layout>
    </v-container>
  </v-content>
  <v-footer color="indigo" app>
  </v-footer>
  </v-app>
</template>

<script>
import NavigationDrawer from './components/NavigationDrawer.vue'
import MoneySimulation from './components/MoneySimulation.vue'
export default {
  name: 'app',
  components: { 'navdrawer': NavigationDrawer, 'money-simulation': MoneySimulation },
  data () {
    return {
      msg: '貯金シミュレーション',
      drawer: false
    }
  }
}
</script>
