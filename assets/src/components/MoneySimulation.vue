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
    <datepicker label="開始" v-model="start_date" default="2017-01-01" />
    <v-spacer></v-spacer>
    <datepicker label="終了" v-model="end_date" default="2018-12-31" />
    <v-spacer></v-spacer>
    <sync-button :start_date="start_date" :end_date="end_date" @on_sync="syncMoney" />
  </v-layout>
  <v-layout raw warp>
    <result-table :income="moneys['income']" :payment="moneys['payment']" :days="moneys['days']" :target="target" />
  </v-layout>
  <br />
  <v-layout row wrap>
    <money-table title="収入" :items="moneys['income']" :categories="categories['income']" @modify="modifyIncome" />
    <v-spacer></v-spacer>
    <money-table title="支出" :items="moneys['payment']" :categories="categories['payment']" />
  </v-layout>
</div>
</template>

<script>
import DatePicker from './DatePicker.vue'
import SyncButton from './SyncButton.vue'
import MoneyTable from './MoneyTable.vue'
import ResultTable from './ResultTable.vue'
import axios from 'axios'

export default {
  name: 'money',
  components: { 'datepicker': DatePicker, 'sync-button': SyncButton, 'money-table': MoneyTable, 'result-table': ResultTable },
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
    },
    modifyIncome: function(updates){
      let income = this.moneys['income'];
      let i = 0;
      for(let money of income) {
        if(updates[money[0]]){
          this.$set(this.moneys['income'][i], 1, parseInt(updates[money[0]]));
          // this.moneys['income'][i][1] = parseInt(updates[money[0]]);
        }
        i++;
      }
    }
  },
  data () {
    return {
      start_date: '2017-01-01',
      end_date: '2019-01-01',
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
