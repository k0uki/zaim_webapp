<template>
  <v-btn
    color="info"
    :loading="loading"
    @click.native="loader = 'loading'"
    :disabled="loading"
  >
    データ取得
    <span slot="loader" class="custom-loader">
      <v-icon light>cached</v-icon>
    </span>
  </v-btn>
</template>

<script>
export default {
  name: 'syncbutton',
  props: ['value'],
  data () {
    return {
      loader: null,
      loading: false
    }
  },
  watch: {
        loader () {
          const l = this.loader
          this[l] = !this[l]

          setTimeout(() => (this[l] = false), 3000)

          this.loader = null
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
