<template>
  <div class="view view--padded">
    <h2>Reset Password</h2>
    <p>We emailed you a verification code for resetting your password. Please enter it here, along with a new password.</p>
    <div class="alert alert-danger" v-if="error">
      <p v-if="error" class="error">{{ error.message }}</p>
    </div>
    <form @submit.prevent="confirmPasswordReset()">

      <div class="form__group">
        <label for="username">Username (or email address)</label>
        <input v-model="username" type="text" class="form__control form__control--text" id="username" ref="username" placeholder="Your username" required>
      </div>

      <div class="form__group">
        <label for="code">Verification Code</label>
        <input v-model="code" type="text" class="form__control form__control--text" id="code" ref="code" placeholder="Your verification code" required>
      </div>

      <div class="form__group">
        <label for="password">New Password</label>
        <input v-model="pass" type="password" class="form__control form__control--text" id="password" ref="password" placeholder="Your new password" required>
      </div>

      <div class="form__group">
        <router-link to="/" class="btn">Cancel</router-link> <button class="btn btn--primary">Reset Password</button>
      </div>
    </form>
  </div>
</template>

<script>
export default {
  data () {
    return {
      username: '',
      code: '',
      pass: '',
      error: null
    }
  },
  methods: {
    confirmPasswordReset () {
      this.$cognitoAuth.confirmPassword(this.username, this.code, this.pass, (err, result) => {
        if (err) {
          this.error = err
          console.error(err)
        } else {
          console.log('Password reset successful:', result)
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
