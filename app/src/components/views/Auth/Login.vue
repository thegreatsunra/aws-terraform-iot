<template>
  <div class="view view--padded">
    <h2>Log In</h2>
    <p v-if="$route.query.redirect">
      Log in to your account
    </p>
    <div class="alert alert--danger" v-if="error">
      <p v-if="error" class="error">{{ error.message }}</p>
    </div>
    <form @submit.prevent="login()">
      <div class="form__group">
        <label for="username">Username</label>
        <input v-model="username" type="text" class="form__control form__control--text" id="username" ref="username" placeholder="username" required>
      </div>
      <div class="form__group">
        <label for="password">Password</label>
        <input v-model="pass" type="password" class="form__control form__control--text" id="password" ref="password" placeholder="password" required>
      </div>
      <div class="form__group">
        <button class="btn btn--primary">Log In</button>
      </div>
      <p>
        <router-link to="/account/create-account">Create account</router-link> | <router-link to="/account/request-password-reset">Forgot password</router-link>
      </p>
    </form>
  </div>
</template>

<script>
export default {
  data () {
    return {
      username: '',
      pass: '',
      error: null
    }
  },
  methods: {
    login () {
      this.$cognitoAuth.signin(this.username, this.pass, (err, result) => {
        if (err) {
          this.error = err
          console.error(err)
        } else {
          this.$router.replace(this.$route.query.redirect || '/devices')
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
