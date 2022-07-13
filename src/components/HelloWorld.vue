<template>
  <div class="hello">
    <h1>{{ msg }}</h1>
    <h2>IP : {{ ip }}</h2>
    <h2>HOST NAME : {{ hostName }}</h2>
  </div>
</template>

<script>
export default {
    name: 'HelloWorld',
    props: {
        msg: String
    },
    data() {
        return {
            ip: '',
            hostName: '',
        }
    },
    created() {
        this.getIp()
        this.getHostName()
    },
    methods: {
        getIp() {
            let _vue = this
            this.$http.get('http://slb-11505024.ncloudslb.com/api/ip')
                        .then(function(response){
                            _vue.ip = response.bodyText
                        });
        },
        getHostName() {
            let _vue = this
            this.$http.get('http://slb-11505024.ncloudslb.com/api/host-name')
                        .then(function(response){
                            _vue.hostName = response.bodyText
                        });
        }
    }

}
</script>

<!-- Add "scoped" attribute to limit CSS to this component only -->
<style scoped>
h3 {
  margin: 40px 0 0;
}
ul {
  list-style-type: none;
  padding: 0;
}
li {
  display: inline-block;
  margin: 0 10px;
}
a {
  color: #42b983;
}
</style>
