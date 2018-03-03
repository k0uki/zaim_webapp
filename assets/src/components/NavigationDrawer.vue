<template>
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
           <v-list-tile-title>
             <a href="/auth/clear">ログアウト</a>
           </v-list-tile-title>
         </v-list-tile-content>
       </v-list-tile>
     </v-list>
   </v-navigation-drawer>
</template>

<script>
export default {
  name: 'navdrawer',
  props: ['drawer'],
  data () {
    return {
    }
  }
}
</script>
