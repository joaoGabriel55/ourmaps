<script lang="ts">
  import { MapLibre } from "svelte-maplibre";

  import "@watergis/maplibre-gl-terradraw/dist/maplibre-gl-terradraw.css";

  import { createMapBoxDraw, onAddFeature } from "$lib/map-viewer";
  import type maplibregl from "maplibre-gl";

  let map: maplibregl.Map | undefined = $state();

  const { view, zoom } = $props();

  const draw = createMapBoxDraw();

  $effect(() => {
    if (!map) return;

    map.addControl(draw);

    map.once("load", () => {
      onAddFeature(draw, (feature) => {
        console.log(feature);
      });
    });
  });
</script>

<MapLibre
  bind:map
  center={view}
  {zoom}
  class="map"
  standardControls
  style="https://basemaps.cartocdn.com/gl/positron-gl-style/style.json"
/>

<style>
  :global(.map) {
    height: calc(100vh - 64px);
  }
</style>
