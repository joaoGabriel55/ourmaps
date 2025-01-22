<script>
  import Header from "$lib/components/Header.svelte";
  import MapsList from "$lib/components/MapsList.svelte";
  import { Earth, LockKeyhole } from "lucide-svelte";
  import "../app.css";

  let { data } = $props();

  let userMaps = data.userMaps;
  let sharedMaps = data.sharedMaps;
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
        <LockKeyhole />
        <h2>My maps</h2>
      </div>
      <div class="collapse-content">
        <MapsList maps={userMaps} />
      </div>
    </div>
    <hr class="my-4" />
    <div class="collapse collapse-arrow border border-base-300">
      <input type="checkbox" />
      <div class="collapse-title text-xl flex items-center gap-2 font-medium">
        <Earth />
        <h2>Public maps</h2>
      </div>
      <div class="collapse-content">
        <MapsList maps={sharedMaps} />
      </div>
    </div>
  </section>
</div>

<style lang="postcss">
  :global(html) {
    background-color: theme(colors.gray.100);
  }
</style>
