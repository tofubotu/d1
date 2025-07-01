<template>
  <div id="app">
    <h2>Vue + Tabulator Demo</h2>
    <div style="margin-bottom: 1rem;">
      <button @click="logSelected">Show Selected Rows</button>
    </div>
    <div ref="table"></div>
  </div>
</template>

<script>
import 'tabulator-tables/dist/css/tabulator.min.css'
import { onMounted, ref } from 'vue'
import { TabulatorFull as Tabulator } from 'tabulator-tables'

export default {
  setup() {
    const tableRef = ref(null)
    let tableInstance = null

    // Generate 100 rows of sample data
    const statuses = ["Active", "Inactive", "Pending", "Banned"]
    const tableData = Array.from({ length: 100 }, (_, i) => ({
      id: i + 1,
      name: `User${i + 1}`,
      age: 18 + (i % 40),
      status: statuses[i % statuses.length],
      message: `This is message number ${i + 1}, a bit longer for testing tooltip rendering and overflow handling.`
    }))

    const columns = [
      { title: "", formatter: "rowSelection", titleFormatter: "rowSelection", hozAlign: "center", headerSort: false, cellClick: (e, cell) => cell.getRow().toggleSelect(), width: 40 },
      { title: "ID", field: "id", width: 60, sorter: "number" },
      { title: "Name", field: "name", headerFilter: "input" },
      { title: "Age", field: "age", hozAlign: "center", sorter: "number" },
      {
        title: "Status", field: "status", headerFilter: true,
        formatter: cell => {
          const value = cell.getValue()
          const colors = { Active: "green", Inactive: "gray", Pending: "orange", Banned: "red" }
          return `<span style="color:${colors[value]}; font-weight:bold">${value}</span>`
        }
      },
      {
        title: "Message",
        field: "message",
        tooltip: true,
        formatter: "textarea",
        widthGrow: 2,
        headerFilter: "input"
      }
    ]

    onMounted(() => {
      tableInstance = new Tabulator(tableRef.value, {
        data: tableData,
        layout: "fitColumns",
        responsiveLayout: "collapse",
        pagination: "local",
        paginationSize: 10,
        selectable: true,
        columns
      })
    })

    function logSelected() {
      const selectedData = tableInstance.getSelectedData()
      console.log("Selected rows:", selectedData)
      alert(`Selected ${selectedData.length} rows. See console for details.`)
    }

    return {
      table: tableRef,
      logSelected
    }
  }
}
</script>

<style>
#app {
  font-family: Arial, sans-serif;
  padding: 2rem;
}
h2 {
  margin-bottom: 1rem;
}
button {
  padding: 0.5rem 1rem;
  font-weight: bold;
}
</style>

