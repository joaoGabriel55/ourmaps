<script lang="ts">
  import MapViewer from "$lib/components/MapViewer.svelte";
  import type { LatLngExpression } from "leaflet";

  const initialView: LatLngExpression = [51.514244, 7.468429]; // Dortmund, Germany
  let { data } = $props();

  console.log(data.id);
</script>

<div class="w-full h-full">
  <MapViewer view={initialView} zoom={14}></MapViewer>
</div>
