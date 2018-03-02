<template>
  <div class='container'>
    <div>{{ highlight.text }}</div>
    <a class='sourcelink' :src='highlight.sourceUrl'>SOURCE</a>
  </div>
</template>

<script>
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
          return { text: '', sourceUrl: '' }
        }
      },
    },
  }
</script>
<style>
/* Add some padding inside the card container */
.container {
    padding: 2px 16px;
    margin:10px;
}
</style>
