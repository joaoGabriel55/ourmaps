<script lang="ts">
  import type { CustomMap } from "$core/custom-map";
  import { UserPlus } from "lucide-svelte";
  import TrashIcon from "lucide-svelte/icons/trash";

  type Props = {
    maps: Array<CustomMap>;
    onAddCollaborators: (map: CustomMap) => void;
    onDelete: (map: CustomMap) => void;
  };

  let { maps, onAddCollaborators, onDelete }: Props = $props();
</script>

{#if maps.length === 0}
  <p>No maps found</p>
{/if}

<ul>
  {#each maps as map}
    <li
      class="p-4 rounded-md border border-solid border-gray-200 flex justify-between hover:bg-gray-100 transition duration-300"
    >
      <div class="flex flex-col gap-4">
        <a
          data-sveltekit-reload
          href="/{map.id}"
          class="link link-primary font-medium text-lg"
        >
          {map.name}
        </a>
        <p class="text-md">{map.description}</p>
        <div class="align-bottom">
          <span class="text-xs text-gray-500">
            Created at: {new Date(map.createdAt).toLocaleString()}
          </span>
          <span class="text-gray-500">|</span>
          {#if map.updatedAt}
            <span class="text-xs text-gray-500">
              Updated at: {new Date(map.updatedAt).toLocaleString()}
            </span>
          {/if}
        </div>
      </div>
      <div class="flex gap-2">
        <button
          class="btn btn-sm btn-circle btn-ghost hover:bg-primary-100 transition duration-300"
          onclick={() => onAddCollaborators(map)}
        >
          <UserPlus size={18} class="text-primary" />
        </button>
        <button
          class="btn btn-sm btn-circle btn-ghost hover:bg-red-100 transition duration-300"
          onclick={() => onDelete(map)}
        >
          <TrashIcon size={18} class="text-red-500" />
        </button>
      </div>
    </li>
  {/each}
</ul>
