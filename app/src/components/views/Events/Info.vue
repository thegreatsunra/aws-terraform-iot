<template>
  <div class="view view--padded">
    <h1>Event {{event.id}}</h1>
    <pre><code>{{event}}</code></pre>
  </div>
</template>

<script>
export default {
  computed: {
    event () {
      return this.$store.state.Events.find(({ id }) => id === this.$route.params.id)
    }
  },
  mounted () {
    this.$store.dispatch('pullEvent', this.$route.params.id)
  }
}
</script>

<style lang="scss" scoped>
</style>
