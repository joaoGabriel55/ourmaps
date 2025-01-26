<script lang="ts">
  import Header from "$lib/components/Header.svelte";
  import MapsList from "$lib/components/MapsList.svelte";
  import { Earth, LockKeyhole, Users } from "lucide-svelte";
  import "../app.css";
  import type { CustomMap } from "$core/custom-map";
  import { deleteCustomMap } from "$lib/api/custom-maps/delete";
  import { makeOurMapsAPI } from "$lib/api/http-client";
  import { showToast } from "$lib/toast";

  let { data } = $props();

  let userMaps = $state(data.userMaps);
  let sharedMaps = data.sharedMaps;

  let mapToBeDeleted = $state<CustomMap>();

  const openDeleteMapModal = (map: CustomMap) => {
    const modal = document.getElementById("delete-modal") as HTMLDialogElement;

    if (modal) modal.showModal();

    mapToBeDeleted = map;
  };

  const handleDelete = (id: string) => {
    userMaps = userMaps.filter((map) => map.id !== id);

    deleteCustomMap(id, makeOurMapsAPI(data.token)).catch((error) => {
      showToast("Error deleting map. Please try again", "error");
    });
  };
</script>

<Header />
<div class="max-w-4xl mx-auto mt-8 p-2">
  <div class="flex justify-end">
    <a data-sveltekit-reload class="btn btn-primary w-fit" href="/new">
      New Map
    </a>
  </div>
  <section class="my-4">
    <div class="collapse collapse-arrow border border-base-300">
      <input type="checkbox" />
      <div class="collapse-title text-xl flex items-center gap-2 font-medium">
        <LockKeyhole class="text-primary" />
        <h2>Private Maps</h2>
      </div>
      <div class="collapse-content">
        <MapsList maps={userMaps} onDelete={openDeleteMapModal} />
      </div>
    </div>
    <hr class="my-4" />
    <div class="collapse collapse-arrow border border-base-300">
      <input type="checkbox" />
      <div class="collapse-title text-xl flex items-center gap-2 font-medium">
        <Earth class="text-primary" />
        <h2>Public Maps</h2>
      </div>
      <div class="collapse-content">
        <MapsList maps={sharedMaps} onDelete={openDeleteMapModal} />
      </div>
    </div>
    <hr class="my-4" />
    <div class="collapse collapse-arrow border border-base-300">
      <input type="checkbox" />
      <div class="collapse-title text-xl flex items-center gap-2 font-medium">
        <Users class="text-primary" />
        <h2>Collaborative Maps</h2>
      </div>
      <div class="collapse-content">
        <MapsList maps={[]} onDelete={openDeleteMapModal} />
      </div>
    </div>
  </section>
  <dialog id="delete-modal" class="modal modal-bottom sm:modal-middle">
    <div class="modal-box">
      <h3 class="text-lg font-bold">Delete Map {mapToBeDeleted?.name}</h3>
      <p class="py-4">This action cannot be undone</p>
      <div class="modal-action">
        <form method="dialog">
          <button
            class="btn btn-error"
            onclick={() => handleDelete(mapToBeDeleted?.id || "")}
            >Delete</button
          >
          <button class="btn">Cancel</button>
        </form>
      </div>
    </div>
  </dialog>
</div>

<style lang="postcss">
  :global(html) {
    background-color: theme(colors.gray.100);
  }
</style>
