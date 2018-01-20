<template>
  <div class="view view--padded">
    <h2>Change Password</h2>
    <div class="alert alert-danger" v-if="error">
      <p v-if="error" class="error">{{ error.message }}</p>
    </div>
    <form @submit.prevent="changePassword()">

      <div class="form__group">
        <label for="oldpass">Current Password</label>
        <input v-model="oldpass" type="password" class="form__control form__control--text" id="oldpass" ref="oldpass" placeholder="Your current password" required>
      </div>

      <div class="form__group">
        <label for="newpass">New Password</label>
        <input v-model="newpass" type="password" class="form__control form__control--text" id="newpass" ref="newpass" placeholder="Your new password" required>
      </div>

      <div class="form__group">
      <router-link to="/" class="btn">Cancel</router-link> <button class="btn btn--primary">Change Password</button>
      </div>
    </form>
  </div>
</template>

<script>
export default {
  data () {
    return {
      oldpass: '',
      newpass: '',
      error: null
    }
  },
  methods: {
    changePassword () {
      this.$cognitoAuth.changePassword(this.oldpass, this.newpass, (err, result) => {
        if (err) {
          this.error = err
          console.error(err)
        } else {
          console.log('Password change successful:', result)
          this.$router.replace('/')
        }
      })
    }
  }
}
</script>

<style>
.error {
  color: red;
}
</style>
