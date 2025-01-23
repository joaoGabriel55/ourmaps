<script lang="ts">
  import type { CustomMap } from "$core/custom-map";
  import { updateCustomMap } from "$lib/api/custom-maps/update";
  import MapForm from "$lib/components/MapForm.svelte";
  import MapViewer from "$lib/components/MapViewer.svelte";
  import { showToast } from "$lib/toast";
  import BackIcon from "lucide-svelte/icons/arrow-left";

  let center = $state<[number, number]>([7.468429, 51.514244]);
  let { data }: { data: CustomMap } = $props();

  let featureCollection = $state<any[]>([]);

  function handleCustomMapContent(features: any) {
    featureCollection = features;
  }

  async function handleUpdateCustomMap(formData: FormData) {
    try {
      await updateCustomMap({
        id: data.id,
        ownerId: "61682ddc-08da-4eef-921c-65db6143ff36",
        name: formData.get("name") as string,
        description: formData.get("description") as string,
        center,
        visibility: formData.get("visibility") === "on" ? "private" : "public",
        content: {
          type: "FeatureCollection",
          features: featureCollection,
        },
      });

      showToast("Map updated successfully!", "success");
    } catch (error) {
      showToast("Error updating map", "error");
    }
  }
</script>

<div class="w-full h-full relative">
  <div class="relative">
    <MapViewer
      view={center}
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
        <MapForm map={data} onSubmit={handleUpdateCustomMap} />
      </div>
    </div>
  </div>
</div>
