<template>
  <div class="view view--flex">
    <ul class="_devices">
      <li
        v-for="device in devices"
        :key="device.id"
        class="_device"
      >
        <div class="_device__name">
          <strong>Device:</strong> <router-link :to="`/devices/${device.id}`">
          {{device.name ? device.name : device.id}}</router-link>
        </div>
        <div class="_device__id">
          <strong>ID</strong>: {{device.id}}
        </div>
        <div class="_device__at">
          <strong>Last reported {{ relativeAt(device.at) }}</strong>
        </div>
      </li>
    </ul>
  </div>
</template>
 
<script>
import { distanceInWordsToNow } from 'date-fns'

export default {
  computed: {
    devices () {
      return this.$store.state.Devices
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
    this.$store.dispatch('pullDevices')
  }
}
</script>

<style lang="scss" scoped>
._device {
  padding-bottom: 10px;
}
</style>

