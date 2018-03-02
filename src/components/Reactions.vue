<template>
  <button v-if="voted" class="badge reactions voted">
    👍
  </button>
  <button v-else class="badge reactions" @click="upvote">
    {{ count }}
  </button>
</template>

<script>
  export default {
    props: {
      count: {
        type: Number,
        default: 0
      },
      id: {
        type: String
      },
    },
    data () {
      return {
        voted: false
      }
    },
    methods: {
      upvote () {
        this.voted = true
      }
    }
  }
</script>
<style lang="css">
  .voted {
    background: white;
  }
</style>
