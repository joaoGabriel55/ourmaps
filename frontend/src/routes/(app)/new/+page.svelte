<script lang="ts">
  import { createCustomMap } from "$lib/api/custom-maps/create";
  import MapViewer from "$lib/components/MapViewer.svelte";
  import BackIcon from "lucide-svelte/icons/arrow-left";

  let center = $state<[number, number]>([7.468429, 51.514244]);
  let featureCollection = $state<any[]>([]);

  function handleCustomMapContent(features: any) {
    featureCollection = features;
  }

  async function handleCreateCustomMap(event: SubmitEvent) {
    event.preventDefault();

    const form = event.target as HTMLFormElement;
    const formData = new FormData(form);

    await createCustomMap({
      // TODO: Get the owner ID from the session
      ownerId: "61682ddc-08da-4eef-921c-65db6143ff36",
      name: formData.get("name") as string,
      description: formData.get("description") as string,
      center,
      content: {
        type: "FeatureCollection",
        features: featureCollection,
      },
    });

    form.reset();
  }
</script>

<div class="w-full h-full relative">
  <header class="p-2 flex gap-4 items-center justify-between">
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
  <div class="relative">
    <MapViewer
      view={center}
      zoom={10}
      onFeaturesChange={handleCustomMapContent}
    />
    <div class="absolute bottom-10 left-5 card bg-base-100 shadow w-96">
      <div class="card-body">
        <h2 class="card-title">Create a new map</h2>
        <form onsubmit={handleCreateCustomMap} class="flex flex-col">
          <label class="form-control w-full max-w-xs">
            <div class="label">
              <span class="label-text">Map name*</span>
            </div>
            <input
              class="input input-bordered w-full max-w-xs"
              type="text"
              name="name"
              placeholder="Cool map name"
              required
            />
          </label>
          <label class="form-control">
            <div class="label">
              <span class="label-text">Description</span>
            </div>
            <textarea
              class="textarea textarea-bordered h-24"
              placeholder="My cool description..."
              name="description"
            ></textarea>
          </label>
          <button type="submit" class="btn btn-primary w-full mt-4"
            >Save!</button
          >
        </form>
      </div>
    </div>
  </div>
</div>
