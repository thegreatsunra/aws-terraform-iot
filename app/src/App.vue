<template>
  <div id="app" class="app">
    <router-view></router-view>
  </div>
</template>

<script>
export default {
  name: 'app',
  mounted () {
    setInterval(() => this.$store.dispatch('pullDevices'), 5000)
  }
}
</script>

<style lang="scss">
  @import './styles/app';
  .view {
    overflow: auto;
  }
</style>
