<script lang="ts">
  import TrashIcon from "lucide-svelte/icons/trash";

  export let title: string;
  export let maps: { id: number; name: string; description: string }[] = [];
</script>

<div class="p-4">
  <h2 class="text-xl font-semibold">{title}</h2>
</div>
<ul>
  {#each maps as map}
    <a data-sveltekit-reload href="/{map.id}" class="no-underline">
      <li
        class="p-4 cursor-pointer flex justify-between hover:bg-gray-100 transition duration-300"
      >
        <div class="flex flex-col">
          <strong class="font-medium">{map.name}</strong>
          <span class="text-sm">{map.description}</span>
        </div>
        <div class="flex">
          <button
            class="btn btn-sm btn-circle btn-ghost hover:bg-red-100 transition duration-300"
          >
            <TrashIcon size={18} class="text-red-500" />
          </button>
        </div>
      </li>
    </a>
  {/each}
</ul>
