<script lang="ts">
  import LeafletMap from "$lib/components/LeafletMap.svelte";
  import type { LatLngExpression } from "leaflet";
  import BackIcon from "lucide-svelte/icons/arrow-left";

  const initialView: LatLngExpression = [51.514244, 7.468429]; // Dortmund, Germany
</script>

<div class="w-full h-full relative">
  <header class="p-2 flex gap-4 items-center justify-between  ">
    <a href="/" class="btn btn-circle btn-ghost">
      <BackIcon size={18} />
    </a>
    <div class="flex gap-4">
      <div class="avatar placeholder">
        <div
          class="bg-green-500 w-8 h-8 p-4 rounded-2xl flex items-center justify-center"
        >
          <span class="text-semibold">D</span>
        </div>
      </div>
      <h1 class="text-2xl font-bold">OurMaps</h1>
    </div>
  </header>
  <LeafletMap view={initialView} zoom={14}></LeafletMap>
</div>
