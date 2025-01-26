<script lang="ts">
  import { goto } from "$app/navigation";
  import { createCustomMap } from "$lib/api/custom-maps/create";
  import { makeOurMapsAPI } from "$lib/api/http-client";
  import MapForm from "$lib/components/MapForm.svelte";
  import MapViewer from "$lib/components/MapViewer.svelte";
  import { showToast } from "$lib/toast";
  import BackIcon from "lucide-svelte/icons/arrow-left";

  import type { PageData } from "./$types";

  const { data }: { data: PageData } = $props();

  let center = $state<[number, number]>([7.468429, 51.514244]);
  let featureCollection = $state<any[]>([]);

  function handleCustomMapContent(features: any) {
    featureCollection = features;
  }

  async function handleCreateCustomMap(formData: FormData) {
    try {
      const customMap = await createCustomMap(
        {
          ownerId: data.userId,
          name: formData.get("name") as string,
          description: formData.get("description") as string,
          center,
          visibility:
            formData.get("visibility") === "on" ? "private" : "public",
          content: {
            type: "FeatureCollection",
            features: featureCollection,
          },
        },
        makeOurMapsAPI(data.token)
      );

      goto(`/${customMap.id}`);

      showToast("Map created successfully!", "success");
    } catch (error) {
      showToast("Error creating map!", "error");
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
          <h2 class="card-title">Create a new map</h2>
        </header>
        <MapForm onSubmit={handleCreateCustomMap} />
      </div>
    </div>
  </div>
</div>
