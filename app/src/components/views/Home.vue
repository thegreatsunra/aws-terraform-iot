<template>
  <div class="view _view view--padded">
    <button class="_btn btn" @click="logOut()">Sign out</button>
    <h1>Home</h1>
    <h3><router-link to="/devices">Devices</router-link></h3>
    <h3><router-link to="/events">Events</router-link></h3>
  </div>
</template>

<script>

export default {
  data () {
    return {
    }
  },
  mounted () {
    this.$store.dispatch('pullDevices')
  },
  methods: {
    logOut () {
      this.$router.push('/logout')
    }
  }
}
</script>

<style lang="scss">

</style>
