<template>
<div>
  <v-layout row>
    <v-flex xs8>
      <v-text-field
        label="目標"
        v-model="target"
        suffix="万円"
      ></v-text-field>
    </v-flex>
  </v-layout>
  <v-layout row wrap>
    <datepicker label="開始" v-model="start_date" />
    <v-spacer></v-spacer>
    <datepicker label="終了" v-model="end_date" />
    <v-spacer></v-spacer>
    <sync-button :start_date="start_date" :end_date="end_date" @on_sync="syncMoney" />
  </v-layout>
  <v-layout raw wrap>
    <v-flex xs11 sm10>
    <v-data-table
       hide-headers
       :items="results"
       hide-actions
       class="elevation-1"
     >
       <template slot="items" slot-scope="props">
         <td>{{ props.item.name }}</td>
         <td class="text-xs-right">{{ props.item.text }}</td>
       </template>
    </v-data-table>
    </v-flex>
  </v-layout>
  <br />  
  <v-layout row wrap>
    <money-table title="収入" :items="moneys['income']" :categories="categories['income']" />
    <v-spacer></v-spacer>
    <money-table title="支出" :items="moneys['payment']" :categories="categories['payment']" />
  </v-layout>
</div>
</template>

<script>
import DatePicker from './DatePicker.vue'
import SyncButton from './SyncButton.vue'
import MoneyTable from './MoneyTable.vue'
import axios from 'axios'

export default {
  name: 'money',
  components: { 'datepicker': DatePicker, 'sync-button': SyncButton, 'money-table': MoneyTable },
  beforeMount: function(){
    let that = this;
    axios.get('/zaim/category')
    .then(function (response) {
      that.categories = response.data;
    })
    .catch(function (error) {
      console.log(error);
    });
  },
  methods: {
    syncMoney: function(moneys){
      this.moneys = moneys;
    }
  },
  data () {
    return {
      start_date: null,
      end_date: null,
      target: 50,
      categories: {},
      moneys: {
        'payment': [],
        'income': []
      },
     results: [
                {
                  value: false,
                  name: '収支',
                  text: "+ ５万円"
                },
                {
                  value: false,
                  name: 'このペースなら目標額まであと',
                  text: '10日'
                }
    ]
    }
  }
}
</script>
