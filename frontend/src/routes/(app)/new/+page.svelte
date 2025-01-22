<script lang="ts">
  import { createCustomMap } from "$lib/api/custom-maps/create";
  import MapForm from "$lib/components/MapForm.svelte";
  import MapViewer from "$lib/components/MapViewer.svelte";
  import BackIcon from "lucide-svelte/icons/arrow-left";

  let center = $state<[number, number]>([7.468429, 51.514244]);
  let featureCollection = $state<any[]>([]);

  function handleCustomMapContent(features: any) {
    featureCollection = features;
  }

  async function handleCreateCustomMap(formData: FormData) {
    const customMap = await createCustomMap({
      // TODO: Get the owner ID from the session
      ownerId: "61682ddc-08da-4eef-921c-65db6143ff36",
      name: formData.get("name") as string,
      description: formData.get("description") as string,
      center,
      visibility: "public",
      content: {
        type: "FeatureCollection",
        features: featureCollection,
      },
    });

    window.location.href = `/${customMap.id}`;
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
          <h2 class="card-title">Create a new map</h2>
        </header>
        <MapForm onSubmit={handleCreateCustomMap} />
      </div>
    </div>
  </div>
</div>
