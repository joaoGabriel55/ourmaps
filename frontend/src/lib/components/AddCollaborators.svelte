<script lang="ts">
  import type { CustomMap } from "$core/custom-map";
  import type { User } from "$core/user";
  import { makeOurMapsAPI } from "$lib/api/http-client";
  import { searchUsers } from "$lib/api/users/search";
  import { TrashIcon } from "lucide-svelte";
  import SearchInput, { type Option } from "./SearchInput.svelte";
  import { addCustomMapCollaborators } from "$lib/api/custom-maps/add-collaborators";

  type Props = {
    token: string;
    map: CustomMap;
  };

  let { token, map }: Props = $props();

  console.log(map)

  const toOption = (user: User) => ({
    value: user.id,
    label: `${user.name} - (${user.email})`,
  });

  let collaborators = $state<Array<User>>([]);
  let selectedCollaborators = $state<Array<User>>(map.collaborators || []);

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
      // TODO: remove collaborator from API
    }
  }

  function submitCollaborators() {
    addCustomMapCollaborators(
      map.id,
      selectedCollaborators.map((c) => c.id),
      makeOurMapsAPI(token)
    );
  }
</script>

<dialog
  open
  class="modal modal-bottom sm:modal-middle backdrop-brightness-[20%]"
>
  <div class="modal-box h-2/3 flex flex-col justify-between">
    <section>
      <h3 class="text-lg font-bold">Share map "{map.name}"</h3>
      <div class="py-4 relative">
        <SearchInput
          options={collaborators.flatMap((collaborator) => {
            if (selectedCollaborators.find((c) => c.id === collaborator.id))
              return [];

            return toOption(collaborator);
          })}
          onChange={searchCollaborators}
          onSelect={addCollaborator}
        />
      </div>
      <section>
        <h3 class="text-md font-semibold">Collaborators</h3>
        <ul
          class="grid gap-2 mt-2 overflow-y-auto max-h-[268px] md:max-h-[328px]"
        >
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
            <p class="text-gray-500 text-sm text-center py-4">
              No collaborators
            </p>
          {/if}
        </ul>
      </section>
    </section>
    <div class="modal-action">
      <form class="flex gap-2 justify-end" method="dialog">
        <button class="btn" onclick={() => history.back()}>Cancel</button>
        <button class="btn btn-primary" onclick={submitCollaborators}>
          Submit
        </button>
      </form>
    </div>
  </div>
</dialog>
