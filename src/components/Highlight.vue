<template>
  <div class='container'>

    <ul class="productionsList">
      <li v-for="production in highlight.productions" :key="production.id">
        <div class='production'>
          <img src="/static/images/flame.png" class="onfireImage">

          <iframe class="ytplayer" type="text/html" width="100%" height="200"
            :src="production.embedUrl" allow="encrypted-media"
            frameborder="0"/>

          <p>{{ production.text }}</p>
        </div>
      </li>
    </ul>

    <h3 v-if="highlight.reactions>5">
      {{ highlight.text }}
    </h3>
    <h4 v-else-if="highlight.reactions>2">
      {{ highlight.text }}
    </h4>
    <h5 v-else>
      {{ highlight.text }}
    </h5>

    <div class="badgesFooter">
      <reactions :id='highlight.id' :count='highlight.reactions' />

      <a class='sourcelink' :href='highlight.sourceUrl' target="_blank">
        🌎
      </a>
    </div>

  </div>
</template>

<script>
  import Reactions from './Reactions.vue'

  import gql from 'graphql-tag'
  const plusoneHighlight = gql `
    mutation updateHighlight(
      $id: h_id
    ) {
      id
    }
  `
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
          return { text: '', sourceUrl: '', reactions: 0, productions: [] }
        }
      },
    },

    components: {
      'reactions': Reactions
    },

    methods: {
      plusone: function(event) {
        // console.log(this._uid);
        const h_id = event.target.dataset['id'];

        // Mutation
        this.$apollo.mutate({
          mutation: plusoneHighlight,
          variables: {
            h_id,
          },
          updateQueries: {
            allHighlights: (prev, {
              mutationResult
            }) => {
              return {
                updatedData: mutationResult.data,
              }
            },
          },
        }).then((data) => {
          // Result
          console.log(data);
          this.reactions += 1;
        }).catch((error) => {
          // Error
          console.error(error)
        })
      }
    }
  }
</script>
<style lang="css">
/* Add some padding inside the card container */
  .container {
      padding: 2px 16px;
      margin:10px;
  }

  .highlight .small {
    font-size: 12pt;
  }
  .highlight .medium {
    font-size: 15pt;
  }
  .highlight .large {
    font-size: 18pt;
  }

  .reactions {
    text-decoration: none;
  }
  .badgesFooter {
    margin: 0 0 20px;
  }
  .badge {
    margin: 10px;
    background-color: lightblue;
    padding: 5px 10px;
    border-radius: 10px;
    color: #ff4400;
  }
  .sourcelink {
    text-decoration: none;
  }

  .productionsList {
    margin: 0; padding: 0;
  }
  .onfireImage {
    float: left;
    margin-left: -15px;
  }
</style>
