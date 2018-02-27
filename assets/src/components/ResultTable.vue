<template>
  <v-flex xs11 sm10>
  <v-data-table
     hide-headers
     :items="results"
     hide-actions
     class="elevation-1"
     v-if="get_money"
   >
     <template slot="items" slot-scope="props">
       <td>{{ props.item.name }}</td>
       <td class="text-xs-right">{{ props.item.text }}</td>
     </template>
  </v-data-table>
  </v-flex>
</template>

<script>

export default {
  name: 'resulttable',
  components: { },
  props: ['target', 'income', 'payment', 'days', 'moneys'],
  methods: {
    balance2: function(){
      let balance = 0;
      for(let i of this.income) {
        balance += i[1];
      }
      for(let i of this.payment) {
        balance += -i[1];
      }
      return balance;
    }
  },
  computed: {
    get_money: function(){
      if (this.income && this.income.length > 1){
        return true;
      }else{
        return false;
      }
    },
    balance: function(){
      let balance = 0;
      for(let i of this.income) {
        balance += i[1];
      }
      for(let i of this.payment) {
        balance += -i[1];
      }
      return balance;
    },
    road: function(){
      let balance_per_days = this.balance/ this.days
      return Math.round(this.target * 10000 / balance_per_days)
    },
    road_to_text: function(){
      let road = this.road;

      if(road < 365){
        return road + "日";
      }else {
        let years = Math.floor(road / 365);
        let days = road % 365;
        return years + "年と"　+ days + "日"
      }
    },
    results: {
      get: function(){
        let balance_result = {
            value: false,
            name: '指定した期間の収支',
            text: this.balance + "円"
          };
        let road_result = {
          value: false,
          name: 'このペースなら目標額まであと',
          text: this.road_to_text
        };

        return [balance_result, road_result];
      }
    }
  },
  data () {
    return {
    }
  }
}
</script>
