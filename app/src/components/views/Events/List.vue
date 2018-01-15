<template>
  <div class="view view--flex">
    <ul class="_events">
      <li
        v-for="event in events"
        :key="event.id"
        class="_event"
      >
        <div class="_event__name">
          <router-link :to="`/events/${event.id}`">
          Event {{event.id}}</router-link>
        </div>
        <div class="_event__at">
          <strong>{{ relativeAt(event.at) }}</strong>
        </div>
      </li>
    </ul>
  </div>
</template>

<script>
import { distanceInWordsToNow } from 'date-fns'

export default {
  computed: {
    events () {
      return this.$store.state.Events
    }
  },
  methods: {
    relativeAt (at) {
      return distanceInWordsToNow(at, {
        addSuffix: true
      })
    }
  },
  mounted () {
    this.$store.dispatch('pullEvents')
  }
}
</script>

<style lang="scss" scoped>
._event {
  padding-bottom: 10px;
}
</style>
