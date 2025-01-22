<script lang="ts">
  import MapForm from "$lib/components/MapForm.svelte";
  import MapViewer from "$lib/components/MapViewer.svelte";
  import BackIcon from "lucide-svelte/icons/arrow-left";
  import type { CustomMap } from "../../../core/custom-map";

  const initialView: [number, number] = [7.468429, 51.514244]; // Dortmund, Germany
  let { data }: { data: CustomMap } = $props();

  let featureCollection = $state<any[]>([]);

  function handleCustomMapContent(features: any) {
    featureCollection = features;
  }
</script>

<div class="w-full h-full relative">
  <div class="relative">
    <MapViewer
      view={initialView}
      zoom={10}
      onFeaturesChange={handleCustomMapContent}
    />
    <div class="absolute bottom-10 left-5 card bg-base-100 shadow w-96 z-10">
      <div class="card-body">
        <header class="flex items-center gap-2">
          <a href="/" class="btn btn-sm btn-circle btn-ghost">
            <BackIcon size={18} />
          </a>
          <h2 class="card-title">Edit map</h2>
        </header>
        <MapForm map={data} onSubmit={() => {}} />
      </div>
    </div>
  </div>
</div>
