<template>
  <v-flex xs11 sm5>
  <v-data-table
     :headers="headers"
     :items="items"
     hide-actions
     class="elevation-1"
   >
     <template slot="items" slot-scope="props">
       <td>{{ props.item.name }}</td>
       <td class="text-xs-right">{{ props.item.calories }}</td>
       <td class="text-xs-right">{{ props.item.fat }}</td>
     </template>
  </v-data-table>
  </v-flex>
</template>

<script>
export default {
  name: 'money-table',
  props: ['value', 'title', 'items'],
  data () {
    return {
      headers: [
                {
                  text: this.title,
                  align: 'left',
                  sortable: false,
                  value: 'name'
                },
                { text: '金額', value: 'calories' },
                { text: '割合', value: 'fat' },
              ]
    }
  }
}
</script>
