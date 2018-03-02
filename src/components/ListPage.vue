<template>
  <div class="feed">

    <template v-if="loading > 0">
      Be cool...
    </template>

    <template v-else>
      <ul>
        <li v-for="highlight in allHighlights" :key="highlight.id">
          <highlight :highlight='highlight' class="highlight" />
        </li>
      </ul>
    </template>

  </div>
</template>

<style>
  /*.highlight {
    margin-bottom: 20px;
    background-color:gray;
    border-radius:20px;
    border-shadow
  }*/

  .stats {
    display: block; margin: 1em;
  }
  .stats img {
    width: 100%;
  }

  .highlight {
    /* Add shadows to create the "card" effect */
    box-shadow: 0 4px 8px 0 rgba(0, 0, 0, 0.2);
    transition: 0.3s;
    width: 300px;
    height: auto;
    float: left;
  }

  ul {
    list-style: none outside none;
  }

  li {
    position: relative;
    display: inline;
  }


  /* On mouse-over, add a deeper shadow */

  .highlight:hover {
    box-shadow: 0 8px 16px 0 rgba(0, 0, 0, 0.2);
  }
</style>

<script>
  import gql from 'graphql-tag'
  import Highlight from './Highlight.vue'

  // GraphQL query
  const FeedQuery = gql `
    query allHighlights {
      allHighlights(orderBy: createdAt_DESC) {
        id
        sourceUrl
        reactions
        productions {
          id
          embedUrl
          text
        }
        text
      }
    }
  `

  // Component def
  export default {
    // Local state
    data: () => ({
      allHighlights: {},
      loading: 0,
    }),
    // Apollo GraphQL
    apollo: {
      allHighlights: {
        query: FeedQuery,
        loadingKey: 'loading',
      },
    },
    components: {
      // <my-component> will only be available in parent's template
      'highlight': Highlight
    }
  }
</script>
