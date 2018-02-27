<template>
  <v-btn
    color="info"
    :loading="loading"
    @click.native="getMoney"
    :disabled="!syncEnable"
  >
    データ取得
    <span slot="loader" class="custom-loader">
      <v-icon light>cached</v-icon>
    </span>
  </v-btn>
</template>

<script>
import axios from 'axios';

export default {
  name: 'syncbutton',
  props: ['value', 'start_date', 'end_date'],
  data () {
    return {
      loader: null,
      loading: false,
      moneys: []
    }
  },
  computed: {
    syncEnable: function(){
      return this.start_date && this.end_date && !this.loading
    }
  },
  methods: {
    getMoney: function(){
      // @click.native="loader = 'loading'"
      this.loader = true;
      this.loading = true;
      let that = this;
      axios.get('/zaim/money', {
          params: {
            start_date: this.start_date,
            end_date: this.end_date
          }
      })
      .then(function (response) {
        that.moneys = response.data;
        that.$emit('on_sync', that.moneys);
        that.loading = false;
        that.loader = null;
      })
      .catch(function (error) {
        window.alert("エラーが発生しました")
        that.loading = false;
        that.loader = null;
      });
    }
  }
}
</script>

<style>
.custom-loader {
    animation: loader 1s infinite;
    display: flex;
  }
  @-moz-keyframes loader {
    from {
      transform: rotate(0);
    }
    to {
      transform: rotate(360deg);
    }
  }
  @-webkit-keyframes loader {
    from {
      transform: rotate(0);
    }
    to {
      transform: rotate(360deg);
    }
  }
  @-o-keyframes loader {
    from {
      transform: rotate(0);
    }
    to {
      transform: rotate(360deg);
    }
  }
  @keyframes loader {
    from {
      transform: rotate(0);
    }
    to {
      transform: rotate(360deg);
    }
  }
</style>
