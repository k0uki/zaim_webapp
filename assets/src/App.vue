<template>
  <v-app id="app">
    <v-navigation-drawer
      fixed
      v-model="drawer"
      app
    >
      <v-list dense>
       <v-list-tile @click="">
         <v-list-tile-action>
           <v-icon>home</v-icon>
         </v-list-tile-action>
         <v-list-tile-content>
           <v-list-tile-title>Home</v-list-tile-title>
         </v-list-tile-content>
       </v-list-tile>
       <v-list-tile @click="">
         <v-list-tile-action>
           <v-icon>contact_mail</v-icon>
         </v-list-tile-action>
         <v-list-tile-content>
           <v-list-tile-title>ログアウト</v-list-tile-title>
         </v-list-tile-content>
       </v-list-tile>
     </v-list>
   </v-navigation-drawer>
   <v-toolbar color="indigo" dark fixed app>
       <v-toolbar-side-icon @click.stop="drawer = !drawer"></v-toolbar-side-icon>
       <v-toolbar-title>{{ msg }}</v-toolbar-title>
   </v-toolbar>
  <v-content>
    <v-container fluid fill-height>
      <v-layout justify-center align-center>
      </v-layout>
    </v-container>
  </v-content>
  <v-footer color="indigo" app>
    <span class="white--text">&copy; 2017</span>
  </v-footer>
  </v-app>
</template>

<script>
export default {
  name: 'app',
  data () {
    return {
      msg: 'Welcome to Your Vue.js App',
      drawer: false
    }
  }
}
</script>
