<template>
  <div class='container'>
    <h3>
      {{ highlight.text }}
      <a href="#" class='reactions'>
        <span class="badge">
          {{ highlight.reactions }}
        </span>
      </a>
    </h3>
    <a class='sourcelink' :href='highlight.sourceUrl' target="_blank">
      {{ highlight.sourceUrl | truncate(40) }}
    </a>
  </div>
</template>

<script>
  import Vue from 'vue';
  const VueTruncate = require('vue-truncate-filter')
  Vue.use(VueTruncate);

  export default {
    data: () => ({
      image: {
        'min-width': '60%',
        'max-width': '60%'
      }
    }),
    props: {
      highlight: {
        type: Object,
        default: function () {
          return { text: '', sourceUrl: '', reactions: 0 }
        }
      },
    },
  }
</script>
<style lang="css">
/* Add some padding inside the card container */
  .container {
      padding: 2px 16px;
      margin:10px;
  }

  .reactions {
    text-decoration: none;
  }
  .badge {
    margin: 10px;
    background-color: lightblue;
    padding: 5px 10px;
    border-radius: 10px;
    color: #ff4400;
  }
</style>
