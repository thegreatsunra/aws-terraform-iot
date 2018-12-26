<template>
  <div class="view view--padded">
    <h2>Create a new account</h2>
    <div class="alert alert-danger" v-if="error">
      <p v-if="error" class="error">{{ error.message }}</p>
    </div>
    <form @submit.prevent="createAccount">

      <div class="form__group">
        <label for="email">Email Address (must be @gmail.com)</label>
        <input v-model="email" type="email" class="form__control form__control--text" id="email" ref="email" placeholder="Email" required>
      </div>

      <div class="form__group">
        <label for="username">Username</label>
        <input v-model="username" type="text" class="form__control form__control--text" id="username" ref="username" placeholder="Username" required>
      </div>

      <div class="form__group">
        <label for="password">Password</label>
        <input v-model="pass" type="password" class="form__control form__control--text" id="password" ref="password" placeholder="password" required>
      </div>

      <div class="form__group">
        <router-link to="/" class="btn">Cancel</router-link> <button class="btn btn--primary">Create Account</button>
      </div>

    </form>
  </div>
</template>

<script>
export default {
  data () {
    return {
      username: '',
      email: '',
      pass: '',
      error: null
    }
  },
  methods: {
    createAccount () {
      this.$cognitoAuth.signup(this.username, this.email, this.pass, (err, result) => {
        if (err) {
          this.error = err
          console.error(err)
        } else {
          console.log('Successfully created new account:', result)
          this.$router.replace({ path: '/account/verify-email-address', query: { username: this.username } })
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
