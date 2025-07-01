<template>
  <div id="app">
    <h2>Demo Table: Tabulator + Vue 3</h2>
    <button @click="downloadCSV">Download CSV</button>
    <div ref="table" style="margin-top: 1rem;"></div>
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

    const tableData = [
      { id: 1, name: "Alice", age: 34, status: "Active", message: "This is a very long message that would usually overflow a normal table cell.\n AAAAAAAAAAAAAA\nAaaaaaaaaaaaa\naaaaaaaaaa" },
      { id: 2, name: "Bob", age: 27, status: "Inactive", message: "Short msg." },
      { id: 3, name: "Charlie", age: 29, status: "Pending", message: "Awaiting response from upper management, decision expected by Friday." },
      { id: 4, name: "Diana", age: 41, status: "Active", message: "Can be contacted via Signal." },
      { id: 5, name: "Eve", age: 22, status: "Banned", message: "Abusive behavior in channel." },
      { id: 6, name: "Frank", age: 31, status: "Active", message: "Assigned to project Zeta." },
      { id: 7, name: "Grace", age: 36, status: "Pending", message: "Interview scheduled for Tuesday morning." },
      { id: 8, name: "Heidi", age: 28, status: "Inactive", message: "Out of office until next month." },
    ]

    const columns = [
      { title: "ID", field: "id", width: 60, sorter: "number" },
      { title: "Name", field: "name", headerFilter: "input" },
      { title: "Age", field: "age", hozAlign: "center", sorter: "number" },
      {
        title: "Status", field: "status", headerFilter: true, editor: "select",
        editorParams: { values: ["Active", "Inactive", "Pending", "Banned"] },
        formatter: cell => {
          const value = cell.getValue()
          const colors = {
            Active: "green",
            Inactive: "gray",
            Pending: "orange",
            Banned: "red"
          }
          return `<span style="color:${colors[value] || 'black'}; font-weight:bold">${value}</span>`
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
        height: "500px",
        data: tableData,
        layout: "fitColumns",
        responsiveLayout: "collapse",
        pagination: "local",
        paginationSize: 5,
        movableColumns: true,
        columns
      })
    })

    function downloadCSV() {
      if (tableInstance) {
        tableInstance.download("csv", "data_export.csv")
      }
    }

    return {
      table: tableRef,
      downloadCSV
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

