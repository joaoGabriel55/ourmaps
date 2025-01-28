<script lang="ts">
  import "../app.css";

  import type { CustomMap } from "$core/custom-map";
  import { deleteCustomMap } from "$lib/api/custom-maps/delete";
  import { makeOurMapsAPI } from "$lib/api/http-client";
  import Header from "$lib/components/Header.svelte";
  import MapsList from "$lib/components/MapsList.svelte";
  import { showToast } from "$lib/toast";
  import { Earth, LockKeyhole, Users } from "lucide-svelte";
  import { twMerge } from "tailwind-merge";
  import { page } from "$app/stores";

  let { data } = $props();

  let visibilityParam = $page.url.searchParams.get("visibility") || "private";
  let customMaps = $state(data.customMaps);
  let mapToBeDeleted = $state<CustomMap>();

  let tabs = [
    {
      name: "Private Maps",
      href: "?visibility=private",
      icon: LockKeyhole,
    },
    {
      name: "Public Maps",
      href: "?visibility=public",
      icon: Earth,
    },
    {
      name: "Collaborative Maps",
      href: "?visibility=collaborative",
      icon: Users,
    },
  ];

  const openDeleteMapModal = (map: CustomMap) => {
    const modal = document.getElementById("delete-modal") as HTMLDialogElement;

    if (modal) modal.showModal();

    mapToBeDeleted = map;
  };

  const handleDelete = (id: string) => {
    customMaps = customMaps.filter((map) => map.id !== id);

    deleteCustomMap(id, makeOurMapsAPI(data.token)).catch((error) => {
      showToast("Error deleting map. Please try again", "error");
    });
  };
</script>

<Header user={data.userProfile} />
<div class="max-w-4xl mx-auto mt-8 p-2">
  <div class="flex justify-end">
    <a data-sveltekit-reload class="btn btn-primary w-fit" href="/new">
      New Map
    </a>
  </div>
  <div role="tablist" class="tabs tabs-bordered w-fit my-4">
    {#each tabs as tab}
      <a
        data-sveltekit-reload
        role="tab"
        class={twMerge(
          "tab",
          tab.href.includes(visibilityParam) && "tab-active"
        )}
        href={tab.href}
      >
        <div class="text-base flex items-center gap-2 font-medium">
          <tab.icon class="text-primary" size={18} />
          <h2>{tab.name}</h2>
        </div>
      </a>
    {/each}
  </div>
  <section class="pb-4">
    <MapsList maps={customMaps} onDelete={openDeleteMapModal} />
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
