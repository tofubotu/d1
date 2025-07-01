<template>
  <div>
    <h2>Tabulator Demo</h2>
    <div ref="table"></div>
  </div>
</template>

<script>
import { onMounted, ref } from 'vue'
import { TabulatorFull as Tabulator } from 'tabulator-tables'


export default {
  setup() {
    const table = ref(null)

    onMounted(() => {
      fetch("/api/data/")
        .then(res => res.json())
        .then(data => {
          new Tabulator(table.value, {
            data,
            layout: "fitColumns",
            columns: [
              { title: "ID", field: "id" },
              { title: "Name", field: "name" },
              { title: "Level", field: "level" }
            ]
          })
        })
    })

    return { table }
  }
}
</script>

<style>
@import 'tabulator-tables/dist/css/tabulator.min.css';
</style>

