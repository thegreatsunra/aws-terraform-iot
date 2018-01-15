<template>
  <div class="view view--padded">
    <h1>Device {{device.id}} <router-link :to="`/devices/${device.id ? device.id : device.device.id}/edit`" class="btn btn--lg">Edit</router-link></h1>
    <pre><code>{{device}}</code></pre>
  </div>
</template>

<script>
export default {
  computed: {
    device () {
      return this.$store.state.Devices.find(({ id }) => id === this.$route.params.id)
    }
  },
  mounted () {
    this.$store.dispatch('pullDevice', this.$route.params.id)
  }
}
</script>

<style lang="scss" scoped>
</style>
