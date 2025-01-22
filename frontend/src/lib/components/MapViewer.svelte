<script lang="ts">
  import { MapLibre } from "svelte-maplibre";

  import "@watergis/maplibre-gl-terradraw/dist/maplibre-gl-terradraw.css";

  import {
    createMapBoxDraw,
    onAddFeature,
    onRemoveFeature,
  } from "$lib/map-viewer";
  import maplibregl from "maplibre-gl";

  type Props = {
    view: [number, number];
    zoom: number;
    onFeaturesChange?: (features: any) => void;
  };

  let map: maplibregl.Map | undefined = $state();

  const { view, zoom, onFeaturesChange }: Props = $props();

  const draw = createMapBoxDraw();

  $effect(() => {
    if (!map) return;

    map.addControl(draw);

    map.once("load", () => {
      if (onFeaturesChange) {
        onAddFeature(draw, onFeaturesChange);
        onRemoveFeature(draw, onFeaturesChange);
      }
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
    height: 100vh;
  }
</style>
