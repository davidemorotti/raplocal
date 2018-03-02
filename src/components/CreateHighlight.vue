<template>
  <div class='create'>
    <div class="modal-mask" v-if="showModal" @close="showModal = false">
      <div class="modal-wrapper">
        <div class="modal-container">

          <div class="modal-header">
            <slot name="header">
              <button class="closeModal" @click="showModal = false">
                X
              </button>
              Highlight
            </slot>
          </div>

          <div class="modal-body">
            <slot name="body">
              <textarea v-model="text"></textarea>
              <input v-model="sourceUrl" placeholder="Page url">
              <button @click="create">Share</button>
            </slot>
          </div>

          <div class="modal-footer">
            <slot name="footer">
            </slot>
          </div>
        </div>
      </div>
    </div>

    <transition name="fade">
      <p v-if="intro">hello</p>
    </transition>

    <div class='introBox' v-if="showIntro">
      <button class="closeModal" @click="showIntro=false">
        X
      </button>

      <div class="stats">
        <img src="/static/images/raplocal-icon-square-google-128.png">
        <img src="/static/images/fakestats.png">
      </div>

    </div>

    <div class='createHighlight' @click="showModal = true">
      <button class='newHighlight' >🎤 MEIND TEILEN</button>
    </div>
  </div>
</template>

<script>
  import gql from 'graphql-tag'
  const createHighlight = gql `
    mutation createHighlight($text: String!, $sourceUrl: String!) {
      createHighlight(text: $text, sourceUrl: $sourceUrl) {
        id
        sourceUrl
        text
      }
    }
  `
  export default {
    data: () => ({
      text: '',
      sourceUrl: '',
      reactions: 0,
      showModal: false,
      showIntro: true,
      intro: true,
    }),

    // Attribute
    methods: {
      create() {
        const text = this.text
        const sourceUrl = this.sourceUrl

        // Mutation
        this.$apollo.mutate({
          mutation: createHighlight,
          variables: {
            text,
            sourceUrl,
          },
          updateQueries: {
            allHighlights: (prev, {
              mutationResult
            }) => {
              return {
                // append at head of list because we sort the Highlights reverse chronological
                allHighlights: [mutationResult.data.createHighlight, ...prev.allHighlights],
              }
            },
          },
        }).then((data) => {
          // Result
          console.log(data);
          this.text = ''
          this.sourceUrl = ''
          this.showModal=false;
        }).catch((error) => {
          // Error
          console.error(error)
        })
      },
    },
  }
</script>

<style>
  .fade-enter-active, .fade-leave-active {
    transition: opacity .5s;
  }
  .fade-enter, .fade-leave-to /* .fade-leave-active below version 2.1.8 */ {
    opacity: 0;
  }
  .introBox {
    /* Add shadows to create the "card" effect
    box-shadow: 0 4px 8px 0 rgba(0, 0, 0, 0.2);*/

    border: 30px solid purple;
    background: #fff;
    transition: 0.3s;
    width: 300px;
    height: auto;
    margin-bottom: 35px;

    position: fixed;
    left: 50%;
    top: 50%;
    margin-left: -165px;
    margin-top: -10em;
  }

  .createHighlight {
    position: fixed;
    left: 50%;
    bottom: 1em;
    width: auto;
    height: 1.5em;
    margin-left: -4.5em;
    background-color: white;
    border: 3px solid #eee;
  }

  .createHighlight:hover {
    box-shadow: 0 8px 16px 0 rgba(0, 0, 0, 0.2);
    border: 3px solid transparent;
  }

  .newHighlight {
    border: none;
    color: gray;
    background-color: white;
  }

  .plusImage {
    height: 1.8em;
    margin-top: 1em;
    margin-bottom: -0.5em;
  }

  .modal-mask {
    position: fixed;
    z-index: 9998;
    top: 0;
    left: 0;
    width: 100%;
    height: 100%;
    background-color: rgba(0, 0, 0, .5);
    display: table;
    transition: opacity .3s ease;
  }

  .modal-wrapper {
    display: table-cell;
    vertical-align: middle;
  }

  .modal-container {
    width: 400px;
    height: 13em;
    margin: 0px auto;
    padding: 20px 30px;
    background-color: #fff;
    border-radius: 2px;
    box-shadow: 0 2px 8px rgba(0, 0, 0, .33);
    transition: all .3s ease;
    font-family: Helvetica, Arial, sans-serif;
  }

  .modal-header h3 {
    margin-top: 0;
    color: #42b983;
  }
  .closeModal {
    float: right;
    width: 2em;
    margin-left: -2em;
  }

  .modal-body {
    margin: 2em 0;
  }
  .modal-body textarea {
    width: 100%;
    height: 10em;
    margin-bottom: 1em;
  }
  .modal-enter {
    opacity: 0;
  }
  .modal-footer{
    float:right;
  }
  .modal-leave-active {
    opacity: 0;
  }

  .modal-enter .modal-container,
  .modal-leave-active .modal-container {
    -webkit-transform: scale(1.1);
    transform: scale(1.1);
  }
  /*
  .create {
    text-align: center;
    display: flex;
    justify-content: flex-start;
    flex-direction: column;
  }*/
</style>
