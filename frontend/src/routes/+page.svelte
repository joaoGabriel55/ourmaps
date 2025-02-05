<script lang="ts">
  import "../app.css";

  import { preloadData } from "$app/navigation";
  import { page } from "$app/stores";
  import type { CustomMap } from "$core/custom-map";
  import { deleteCustomMap } from "$lib/api/custom-maps/delete";
  import { makeOurMapsAPI } from "$lib/api/http-client";
  import AddCollaborators from "$lib/components/AddCollaborators.svelte";
  import Header from "$lib/components/Header.svelte";
  import MapsList from "$lib/components/MapsList.svelte";
  import * as Dialog from "$lib/components/ui/dialog";
  import { showToast } from "$lib/toast";
  import { cn } from "$lib/utils";
  import { Earth, LockKeyhole, Users } from "lucide-svelte";

  let { data } = $props();

  let visibilityParam = $page.url.searchParams.get("visibility") || "private";
  let openConfirmDeleteDialog = $state<boolean>(false);
  let openAddCollaboratorsDialog = $state<boolean>(false);

  let customMaps = $state(data.customMaps);
  let mapSelected = $state<CustomMap>();

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

  const handleAddCollaborators = async (map: CustomMap) => {
    mapSelected = map;
  };

  const openDeleteMapModal = (map: CustomMap) => {
    mapSelected = map;
    openConfirmDeleteDialog = true;
  };

  const handleDelete = (id: string) => {
    customMaps = customMaps.filter((map) => map.id !== id);

    deleteCustomMap(id, makeOurMapsAPI(data.token)).catch((error) => {
      showToast("Error deleting map. Please try again", "error");
    });
  };

  $effect(() => {
    if ($page.url.hash.includes("add-collaborators")) {
      const match = $page.url.hash.match(/#\/([^/]+)/);

      if (!match) return;

      const mapId = match[1];

      preloadData(`/${mapId}`).then((response) => {
        if (response.type === "loaded") {
          mapSelected = response.data.map;
        }

        openAddCollaboratorsDialog = true;
      });
    } else {
      openAddCollaboratorsDialog = false;
    }
  });
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
        class={cn("tab", tab.href.includes(visibilityParam) && "tab-active")}
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
    <MapsList
      maps={customMaps}
      onAddCollaborators={handleAddCollaborators}
      onDelete={openDeleteMapModal}
    />
  </section>
  <Dialog.Root
    open={openAddCollaboratorsDialog}
    closeOnOutsideClick={false}
    onOpenChange={(open) => {
      if (!open) {
        history.back();
      }
    }}
  >
    {#if mapSelected}
      <AddCollaborators
        map={mapSelected}
        token={data.token}
        onClose={() => {
          openAddCollaboratorsDialog = false;
          history.back();
        }}
      />
    {/if}
  </Dialog.Root>
  <Dialog.Root open={openConfirmDeleteDialog}>
    <Dialog.Content>
      <Dialog.Title>Confirm Delete</Dialog.Title>
      <Dialog.Description>
        Are you sure you want to delete this map? This action cannot be undone
      </Dialog.Description>
      <Dialog.Footer>
        <button class="btn" onclick={() => (openConfirmDeleteDialog = false)}
          >Cancel</button
        >
        <button
          class={"btn btn-primary btn-error"}
          onclick={() => handleDelete(mapSelected?.id || "")}
        >
          Confirm
        </button>
      </Dialog.Footer>
    </Dialog.Content>
  </Dialog.Root>
</div>

<style lang="postcss">
  :global(html) {
    background-color: theme(colors.gray.100);
  }
  :global([data-svelte-search] input, form) {
    width: 100%;
  }
</style>
