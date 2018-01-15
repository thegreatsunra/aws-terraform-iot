<template>
  <div class="view view--padded">
    <h2>Verify your email address</h2>
    <p>We just emailed you a verification code. Please enter it here to finishing creating your account.</p>
    <div class="alert alert-danger" v-if="error">
      <p v-if="error" class="error">{{ error.message }}</p>
    </div>
    <form @submit.prevent="verifyEmailAddress()">
      <div class="form__group">
        <label for="username">Username</label>
        <input v-model="username" type="text" class="form__control form__control--text" id="username" ref="username" placeholder="Your username" required>
      </div>
      <div class="form__group">
        <label for="code">Verification Code</label>
        <input v-model="code" type="text" class="form__control form__control--text" id="code" ref="code" placeholder="Your verification code" required>
      </div>
      <button class="btn btn--primary">Verify</button>
    </form>
  </div>
</template>

<script>
export default {
  data () {
    return {
      username: this.$route.query.username,
      code: '',
      error: null
    }
  },
  methods: {
    verifyEmailAddress () {
      this.$cognitoAuth.confirmRegistration(this.username, this.code, (err, result) => {
        if (err) {
          this.error = err
          console.error(err)
        } else {
          this.$router.replace('/')
        }
      })
    }
  }
}
</script>
