<script lang="ts">
  import type { CustomMap } from "$core/custom-map";
  import BackIcon from "lucide-svelte/icons/arrow-left";
  import { Earth } from "lucide-svelte";

  type Props = {
    map: CustomMap;
  };

  let { map }: Props = $props();
</script>

<h2 class="card-title">{map.name}</h2>
<div class="flex items-center gap-2">
  <Earth size={18} />
  <span>Public</span>
</div>
<div>
  <span class="text-gray-500 text-sm font-semibold">Description</span>
  <p>{map.description}</p>
</div>
<div class="flex justify-end gap-2">
  <a class="btn btn-sm btn-ghost" href="/">Back</a>
</div>
