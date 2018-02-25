<template>
<v-layout row wrap>
  <v-flex xs11 sm10>
    <v-menu
      ref="menu"
      lazy
      :close-on-content-click="false"
      v-model="menu"
      transition="scale-transition"
      offset-y
      full-width
      :nudge-right="40"
      max-width="290px"
      min-width="290px"
      :return-value.sync="date"
    >
      <v-text-field
        slot="activator"
        :label="label"
        v-model="date"
        prepend-icon="event"
        readonly
      ></v-text-field>
      <v-date-picker
        type="date"
        v-model="date"
        no-title
        scrollable
        v-on:input="updateValue"
      >
        <v-spacer></v-spacer>
        <v-btn flat color="primary" @click="menu = false">Cancel</v-btn>
        <v-btn flat color="primary" @click="$refs.menu.save(date)">OK</v-btn>
      </v-date-picker>
    </v-menu>
  </v-flex>
</v-layout>
</template>

<script>

export default {
  name: 'picker',
  props: ['value', 'label'],
  data () {
    return {
        date: null,
        menu: false
    }
  },
  methods: {
    updateValue: function(){
        this.$emit('input', this.date)
    }
  }
}
</script>
