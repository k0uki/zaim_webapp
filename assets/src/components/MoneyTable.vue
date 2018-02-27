<template>
  <v-flex xs11 sm6>
  <v-data-table
     :headers="headers"
     :items="item_with_name"
     :categories="categories"
     hide-actions
     class="elevation-1"
     v-if="items.length > 1"
   >
     <template slot="items" slot-scope="props">
       <td>{{ props.item.category.name }}</td>
       <td class="text-xs-right">
         <v-edit-dialog
           lazy
         > {{ props.item.amount }}
           <v-text-field
             slot="input"
             label="Edit"
             v-model="props.item.amount"
             @blur="update_money(props.item.id, $event)"
             single-line
             counter
           ></v-text-field>
          </v-edit-dialog>
       </td>
       <td class="text-xs-right">todo</td>
     </template>
  </v-data-table>
  </v-flex>
</template>

<script>
export default {
  name: 'money-table',
  props: ['value', 'title', 'items', 'categories'],
  methods: {
    update_money: function(id, event){
      this.$set(this.items_for_modify, id, event.target.value);
    }
  },
  data() {
    return {
      items_for_modify: {},
      headers: [
                {
                  text: this.title,
                  align: 'left',
                  sortable: false,
                  value: 'name'
                },
                { text: '金額', value: 'amount' },
                { text: '割合', value: 'amount' },
              ]
    }
  },
  watch: {
    items_for_modify: function(val){
      this.$emit('modify', val);
    }
  },
  computed: {
     item_with_name: function () {
       let result = [];
       for(let i of this.items) {
         result.push({'id': i[0], 'amount': i[1], 'category': this.categories[i[0]]});
       }
       return result;
     }
   }
}
</script>
