<script lang="ts">
  import { SearchIcon } from "lucide-svelte";
  import Search from "svelte-search";

  export type Option = { value: string; label: string };

  type Props = {
    options: Array<Option>;
    onChange: (value: string) => void;
    onSelect: (option: Option) => void;
  };

  let value = $state<string>();

  let { options, onChange, onSelect }: Props = $props();

  const handleSelect = (option: Option) => {
    value = "";
    onSelect(option);
  };
</script>

<div
  class="w-full"
  role="combobox"
  aria-expanded="false"
  aria-controls="listbox"
>
  <label class="input input-bordered flex w-full items-center gap-2">
    <SearchIcon />
    <Search
      label=""
      debounce={500}
      class="w-full"
      placeholder="Search"
      bind:value
      on:type={(e) => {
        onChange(e.detail);
      }}
    />
  </label>
  <div class="w-full bg-white">
    {#if value && options.length > 0}
      <ul role="listbox" class="overflow-auto mt-2 bg-white max-h-[200px] w-full absolute z-50 shadow rounded-b-md">
        {#each options as option}
          <li role="option" aria-selected={option.value === value}>
            <button
              class="p-2 mt-2 hover:bg-gray-100 w-full text-start"
              onclick={() => {
                handleSelect(option);
              }}
            >
              {option.label}
            </button>
          </li>
        {/each}
      </ul>
    {/if}
  </div>
</div>
