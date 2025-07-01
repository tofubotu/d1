<template>
  <div>
    <h1>Vue + Tabulator</h1>
    <div id="table"></div>

    <div v-if="popupMessage" class="popup-overlay" @click="popupMessage = null">
      <div class="popup-content" @click.stop>
        <h3>Full Message</h3>
        <p>{{ popupMessage }}</p>
        <button @click="popupMessage = null">Close</button>
      </div>
    </div>
  </div>
</template>

<script setup>
import { onMounted, ref } from 'vue'
import { TabulatorFull as Tabulator } from 'tabulator-tables'
import 'tabulator-tables/dist/css/tabulator.min.css'

const popupMessage = ref(null)

const tableData = ref([
  { id: 1, name: "Alice", message: "This is a long message that won’t fit nicely in a cell.", status: "Pending" },
  { id: 2, name: "Bob", message: "Another quite long message with overflowing content.", status: "Active" },
  { id: 3, name: "Charlie", message: "Short one.", status: "Inactive" },
  { id: 4, name: "Denise", message: "Lorem ipsum dolor sit amet, consectetur adipiscing elit.", status: "Active" },
  { id: 5, name: "Eve", message: "User account flagged for review.", status: "Banned" },
  { id: 6, name: "Frank", message: "This entry contains extended notes and system messages.", status: "Pending" },
  { id: 7, name: "Grace", message: "Critical error logged by system daemon.", status: "Inactive" },
  { id: 8, name: "Heidi", message: "New invite sent to user’s email address.", status: "Active" },
  { id: 9, name: "Ivan", message: "Attempted unauthorized access detected.", status: "Banned" },
  { id: 10, name: "Judy", message: "Password reset issued.", status: "Pending" }
])

function getUniqueColumnValues(data, field) {
  return Array.from(new Set(data.map(row => row[field]))).reduce((acc, value) => {
    acc[value] = value
    return acc
  }, {})
}

onMounted(() => {
  new Tabulator("#table", {
    data: tableData.value,
    layout: "fitColumns",
    selectable: true,
    columns: [
      { formatter: "rowSelection", titleFormatter: "rowSelection", hozAlign: "center", headerSort: false, width: 50 },
      { title: "ID", field: "id", width: 60 },
      {
        title: "Name",
        field: "name",
        headerFilter: "input"
      },
      {
        title: "Message",
        field: "message",
        formatter: cell => {
          const msg = cell.getValue()
          return `<div class="clickable-message" data-msg="${msg.replace(/"/g, '&quot;')}">${msg.slice(0, 30)}...</div>`
        },
        cellClick: (e, cell) => {
          popupMessage.value = cell.getValue()
        },
        headerFilter: "input"
      },
      {
        title: "Status",
        field: "status",
        formatter: cell => {
          const value = cell.getValue()
          const colors = { Active: "green", Inactive: "gray", Pending: "orange", Banned: "red" }
          return `<span style="color:${colors[value] || 'black'}; font-weight:bold">${value}</span>`
        },
        headerFilter: "select",
        headerFilterParams: {
          values: getUniqueColumnValues(tableData.value, "status")
        }
      }
    ]
  })
})
</script>

<style>
#table {
  margin-top: 20px;
}
.clickable-message {
  cursor: pointer;
  text-overflow: ellipsis;
  overflow: hidden;
  white-space: nowrap;
}

/* Popup modal */
.popup-overlay {
  position: fixed;
  top: 0; left: 0; right: 0; bottom: 0;
  background-color: rgba(0, 0, 0, 0.6);
  display: flex;
  align-items: center;
  justify-content: center;
  z-index: 1000;
}
.popup-content {
  background: white;
  padding: 20px;
  border-radius: 8px;
  max-width: 80vw;
  max-height: 80vh;
  overflow-y: auto;
  box-shadow: 0 0 20px rgba(0,0,0,0.3);
}
</style>

