<script lang="ts">
  import type { User } from "$core/user";
  import { makeOurMapsAPI } from "$lib/api/http-client";
  import { searchUsers } from "$lib/api/users/search";
  import * as Dialog from "$lib/components/ui/dialog";
  import { TrashIcon } from "lucide-svelte";

  import type { CustomMap } from "$core/custom-map";
  import { addCustomMapCollaborators } from "$lib/api/custom-maps/add-collaborators";
  import { removeCustomMapCollaborators } from "$lib/api/custom-maps/remove-collaborators";
  import SearchInput, { type Option } from "$lib/components/SearchInput.svelte";
  import { showToast } from "$lib/toast";

  type Props = {
    map: CustomMap;
    token: string;
    onClose: () => void;
  };

  let { map, token, onClose }: Props = $props();

  const toOption = (user: User) => ({
    value: user.id,
    label: `${user.name} - (${user.email})`,
  });

  let collaborators = $state<Array<User>>([]);
  let selectedCollaborators = $state<Array<User>>(map.collaborators || []);
  let searchOptions = $derived(
    collaborators.flatMap((collaborator) => {
      if (selectedCollaborators.find((c) => c.id === collaborator.id))
        return [];

      return toOption(collaborator);
    })
  );

  async function searchCollaborators(value: string) {
    try {
      const users = await searchUsers(value, makeOurMapsAPI(token));

      collaborators = users;
    } catch {
      collaborators = [];
    }
  }

  function addCollaborator(selectedCollaborator: Option) {
    const collaborator = collaborators.find(
      (collaborator) => collaborator.id === selectedCollaborator.value
    );

    if (!collaborator) return;

    selectedCollaborators = [...selectedCollaborators, collaborator];
  }

  function removeCollaborator(collaborator: User) {
    selectedCollaborators = selectedCollaborators.filter(
      (c) => c.id !== collaborator.id
    );

    if (map.collaborators?.find((c) => c.id === collaborator.id)) {
      removeCustomMapCollaborators(
        map.id,
        [collaborator.id],
        makeOurMapsAPI(token)
      );
    }
  }

  async function submitCollaborators() {
    try {
      await addCustomMapCollaborators(
        map.id,
        selectedCollaborators.map((c) => c.id),
        makeOurMapsAPI(token)
      );

      onClose();
    } catch (e: any) {
      showToast(e.response.data.error, "error");
    }
  }
</script>

<Dialog.Content class="card bg-base-100 w-full">
  <h2 class="card-title">Share map "{map.name}"</h2>
  <section class="py-4 relative">
    <SearchInput
      options={searchOptions}
      onChange={searchCollaborators}
      onSelect={addCollaborator}
    />
  </section>
  <section>
    <h3 class="text-md font-semibold">Collaborators</h3>
    <ul class="grid gap-2 mt-2 overflow-y-auto max-h-[268px] md:max-h-[328px]">
      {#each selectedCollaborators as collaborator}
        <li class="flex justify-between items-center">
          <div class="flex flex-col">
            <strong>{collaborator.name}</strong>
            <span class="text-sm text-gray-500">{collaborator.email}</span>
          </div>
          <div class="flex gap-2">
            <button
              class="btn btn-sm btn-circle btn-ghost hover:bg-red-100 transition duration-300"
              onclick={() => removeCollaborator(collaborator)}
            >
              <TrashIcon size={18} class="text-red-500" />
            </button>
          </div>
        </li>
      {/each}
      {#if selectedCollaborators.length === 0}
        <p class="text-gray-500 text-sm text-center py-4">No collaborators</p>
      {/if}
    </ul>
  </section>
  <div class="card-actions justify-end">
    <button class="btn" onclick={() => onClose()}>Cancel</button>
    <button class="btn btn-primary" onclick={submitCollaborators}>
      Submit
    </button>
  </div>
</Dialog.Content>
