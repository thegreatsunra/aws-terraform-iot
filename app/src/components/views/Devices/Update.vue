<template>
  <div class="view view--padded">
    <h1>Edit Device {{device.id}}</h1>
    <form class="_form" @submit.prevent="updateDevice()">
      <div class="form__group">
        <label class="form__label" for="deviceName">Device Name</label>
        <input v-model="editableDevice.name" autocorrect="off" autocapitalize="words" type="text" class="_form__control--text form__control form__control--text" id="deviceName" ref="deviceName" placeholder="">
      </div>

      <div>
        <router-link :to="`/devices/${device.id ? device.id : device.id}`" class="btn btn--lg">Cancel</router-link> <input type="submit" name="updateDevice" value="Save" class="btn btn--lg btn--primary">
      </div>
    </form>
  </div>
</template>

<script>
export default {
  data () {
    return {
      editableDevice: {
        id: '',
        name: ''
      }
    }
  },
  computed: {
    device () {
      return this.$store.state.Devices.find(({ id }) => id === this.$route.params.id)
    }
  },
  mounted () {
    this.updateEditableDevice()
  },
  methods: {
    updateDevice () {
      this.$store.dispatch('updateDevice', this.editableDevice)
      setTimeout(() => { this.$router.push('/devices') }, 500)
    },
    updateEditableDevice () {
      this.pullDevice()
      this.editableDevice.id = this.device.id
      this.editableDevice.name = this.device.name
    },
    pullDevice () {
      this.$store.dispatch('pullDevice', this.$route.params.id)
    }
  }
}
</script>

<style lang="scss" scoped>
</style>
