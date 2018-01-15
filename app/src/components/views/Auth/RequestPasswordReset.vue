<template>
  <div class="view view--padded">
    <h2>Forgot Password</h2>
    <p>We will email a code that will allow you to reset your password.</p>
    <div class="alert alert-danger" v-if="error">
      <p v-if="error" class="error">{{ error.message }}</p>
    </div>
    <form @submit.prevent="resetPassword()">
      <div class="form__group">
        <label for="username">Username (or email address)</label>
        <input v-model="username" type="text" class="form__control form__control--text" id="username" ref="username" placeholder="Your username" required>
      </div>
      <div class="form__group">
        <router-link to="/" class="btn">Cancel</router-link> <button class="btn btn--primary">Request Code</button>
      </div>
    </form>
  </div>
</template>

<script>
export default {
  data () {
    return {
      username: '',
      error: null
    }
  },
  methods: {
    resetPassword () {
      this.$cognitoAuth.forgotPassword(this.username, (err, result) => {
        if (err) {
          this.error = err
          console.error(err)
        } else {
          console.log('Password reset successful:', result)
          this.$router.replace('/account/confirm-password-reset')
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
